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
        
        if type == "Top" {
            url = URL(string: Constants.topURL)
        }
        else
        {
            url = URL(string: Constants.newsURL)
        }

        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request,
                                                  completionHandler:
                { (data, response, error) in
                    if let data = data {
                        if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                    
                            //let c = stringData.characters;
                            let range = stringData.index(stringData.startIndex, offsetBy: 1)..<stringData.index(stringData.endIndex, offsetBy: -1)
                            
                            // Access the string by the range.
                            let substring = stringData[range]
                            
                            let ids:[String] = substring.components(separatedBy: ",")
                            var numberOfStories = ids.count
                            for storyId in ids
                            {
                                self.getStoryWithId(storyId, completionHandler: handler) {
                                    numberOfStories = numberOfStories - 1
                                    print(numberOfStories)
                                    if numberOfStories == 0 {
                                        DBManager.sharedInstance.saveInContext()
                                    }
                                }
//                                if numberOfStories == 0 {
//                                    DBManager.sharedInstance.saveInContext()
//                                }
                            }
                        
                        }
                }
            })
            task.resume()
        }
        
    }
    
    func getStoryWithId(_ id:String, completionHandler handler: @escaping ([String:Any]) -> Void, callback:@escaping ((Void) -> Void)) {
        
        let url = URL(string: Constants.storyURL + id + Constants.storyExtension)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request,
                                                  completionHandler:
                { (data, response, error) in
                    if let data = data {
                        if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                            
                            let dict = self.convertToDictionary(text:stringData)
                            //print(dict!)
                            handler(dict!)
                            callback()
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

}
