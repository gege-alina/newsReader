//
//  Constants.swift
//  NewsReader
//
//  Created by Gege on 13/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit

struct Constants {
    private struct Root {
        static let baseURL = "http://hacker-news.firebaseio.com/v0/"
    }
    private struct Route {
        static let topStories = "topstories.json"
        static let newStories = "newstories.json"
        static let story = "item/"
    }
    static let newsURL = Root.baseURL + Route.newStories
    static let topURL = Root.baseURL + Route.topStories
    static let storyURL = Root.baseURL + Route.story
    static let storyExtension = ".json"
    
    static let top = "Top"
    static let new = "New"
}
