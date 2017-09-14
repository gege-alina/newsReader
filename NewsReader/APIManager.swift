//
//  APIManager.swift
//  NewsReader
//
//  Created by Gege on 13/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit

class APIManager: NSObject {
    
    func getTopStories() {
        
        let url = URL(string: Constants.topURL)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request,
                                                  completionHandler:
                { (data, response, error) in
                    if let data = data {
                        //if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                            //print(stringData) //JSONSerialization
                        if let arr = NSKeyedUnarchiver.unarchiveObject(with: data) {
                            print(arr)
                        }
                    //}
                }
            })
            task.resume()
        }
        
    }
    
    func getNewStories() {
        
        let url = URL(string: Constants.newsURL)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request,
                                                  completionHandler:
                { (data, response, error) in
                    if let data = data {
                        if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                            print(stringData) //JSONSerialization
                        }
                    }
            })
            task.resume()
        }

    }
    
    func getStoryWithId(_ id:String) {
        
        let url = URL(string: Constants.storyURL + id + Constants.storyExtension)
        if let usableUrl = url {
            let request = URLRequest(url: usableUrl)
            let task = URLSession.shared.dataTask(with: request,
                                                  completionHandler:
                { (data, response, error) in
                    if let data = data {
                        if let stringData = String(data: data, encoding: String.Encoding.utf8) {
                            print(stringData) //JSONSerialization
                        }
                    }
            })
            task.resume()
        }
    }

}
