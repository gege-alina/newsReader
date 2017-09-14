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

    var context:NSManagedObjectContext? = nil
    
    static let sharedInstance = DBManager()
    
    private override init() {
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    func addTopStoriesToDatabase(_ newStory:[String:Any]) {
        
        do {
            let fetchRequest: NSFetchRequest<Story> = Story.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == \(String(describing: newStory["id"] as! Int64))")
            let count = try self.context?.count(for:fetchRequest)
            if count == 0 {
                let story = NSEntityDescription.insertNewObject(forEntityName: "Story", into: self.context!) as! Story
                story.id = newStory["id"] as! Int64
                story.by = newStory["by"] as? String
                let date = NSDate(timeIntervalSince1970: newStory["time"] as! TimeInterval)
                story.time = date
                story.title = newStory["title"] as? String
                story.url = newStory["url"] as? String
                story.top = true
                
//                do {
//                    try self.moc.save()
//                } catch {
//                    fatalError("Failure to save context: \(error)")
//                }
            }
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
        
        
        
        
    }
    
    func addNewStoriesToDatabase(_ newStory:[String:Any]) {
        
        do {
            let fetchRequest: NSFetchRequest<Story> = Story.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "id == \(String(describing: newStory["id"] as! Int64))")
            let count = try self.context?.count(for:fetchRequest)
            if count == 0 {
                let story = NSEntityDescription.insertNewObject(forEntityName: "Story", into: self.context!) as! Story
                story.id = newStory["id"] as! Int64
                story.by = newStory["by"] as? String
                let date = NSDate(timeIntervalSince1970: newStory["time"] as! TimeInterval)
                story.time = date
                story.title = newStory["title"] as? String
                story.url = newStory["url"] as? String
                story.top = false
                
//                do {
//                    try self.moc.save()
//                } catch {
//                    fatalError("Failure to save context: \(error)")
//                }
            }
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }

        
        
    }
    
    func saveInContext() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
