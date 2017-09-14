//
//  APIManager.swift
//  NewsReader
//
//  Created by Gege on 13/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    func getStoriesType(type:String, completionHandler handler: @escaping ([String:Any]) -> Void) {
        
        var url:URL?
        
        if type == Constants.top {
            url = URL(string: Constants.topURL)
        }
        else if type == Constants.new {
            url = URL(string: Constants.newsURL)
        }
        else {
            return
        }

        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request,
                                                  completionHandler:
                { (data, response, error) in
                    if let data = data {
                        if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                    
                            let ids = self.parseJsonFromData(data)
                            var numberOfStories = 15//ids.count
                            //for storyId in ids
                            for i in 0..<min(15, ids.count)
                            {
                                let storyId = ids[i]
                                if numberOfStories > 0 {
                                self.getStoryWithId(storyId, completionHandler: handler) {
                                    numberOfStories = numberOfStories - 1
                                    print(numberOfStories)
                                    if numberOfStories == 0 {
                                        DBManager.sharedInstance.saveInContext()
                                    }
                                }
                                }
                            }
                        
                        }
                }
            })
            task.resume()
        }
        
    }
    
    func getStoryWithId(_ id:Int, completionHandler handler: @escaping ([String:Any]) -> Void, callback:@escaping ((Void) -> Void)) {
        
        let url = URL(string: Constants.storyURL + "\(id)" + Constants.storyExtension)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request,
                                                  completionHandler:
                { (data, response, error) in
                    if let data = data {
                        if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                            
                            if let dict = self.convertToDictionary(text:stringData) {
                                handler(dict)
                                callback()
                            }
                        }
                        
                        
                    }
            })
            task.resume()
        }
    }
    
    func convertToDictionary(text: String) -> [String: Any]? {
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    func parseJsonFromData(_ data:Data) -> [Int] {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            guard let array = json as? [Int] else {
                return []
            }
            return array
        } catch {
            return []
        }
    }

    
}
