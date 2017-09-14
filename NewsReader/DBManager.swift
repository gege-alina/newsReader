//
//  DBManager.swift
//  NewsReader
//
//  Created by Gege on 13/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit
import CoreData

class DBManager: NSObject {

    let moc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func addTopStoriesToDatabase() {
        
        let story = NSEntityDescription.insertNewObject(forEntityName: "Story", into: self.moc) as! Story
        story.id = 15238395
        story.by = "bhouston"
        let date = NSDate(timeIntervalSince1970: 1505311859)
        story.time = date
        story.title = "The bad new politics of big tech"
        story.url = "https://www.buzzfeed.com/bensmith/theres-blood-in-the-water-in-silicon-valley"
        story.top = true

        do {
            try self.moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
    }
    
    func addNewStoriesToDatabase() {
        
        let story = NSEntityDescription.insertNewObject(forEntityName: "Story", into: self.moc) as! Story
        story.id = 15238395
        story.by = "bhouston"
        let date = NSDate(timeIntervalSince1970: 1505311859)
        story.time = date
        story.title = "NThe bad new politics of big tech"
        story.url = "https://www.buzzfeed.com/bensmith/theres-blood-in-the-water-in-silicon-valley"
        story.top = false
        story.later = true
        
        do {
            try self.moc.save()
        } catch {
            fatalError("Failure to save context: \(error)")
        }
        
        
    }
    
}
