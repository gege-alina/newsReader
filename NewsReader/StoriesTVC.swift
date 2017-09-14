//
//  StoriesTVC.swift
//  NewsReader
//
//  Created by Gege on 13/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit
import CoreData

class StoriesTVC: UITableViewController, NSFetchedResultsControllerDelegate {

    var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //@IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "StoryTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "Cell")
        
        self.title = "News Reader"
        
        self.refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: UIControlEvents.valueChanged)
        
    }
    
    func refresh(_ sender:Any) {
        
        let manager:APIManager = APIManager()
        DispatchQueue.global(qos: .userInitiated).async {
            manager.getStoriesType(type: "Top") { dict in
                DispatchQueue.main.sync {
                    DBManager.sharedInstance.addTopStoriesToDatabase(dict)
                }
            }
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            manager.getStoriesType(type: "New") { dict in
                DispatchQueue.main.sync {
                    DBManager.sharedInstance.addNewStoriesToDatabase(dict)
                }
            }
        }
        self.refreshControl?.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Top Stories"
        }
        else if section == 1 {
            return "New Stories"
        }
        return ""
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! StoryTableViewCell
        let story = fetchedResultsController.object(at: indexPath)
        cell.story = story
        cell.configureCellWithStory(story)
        print(story.top)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! StoryTableViewCell
        self.performSegue(withIdentifier: "showStory", sender: cell)
        let story = fetchedResultsController.object(at: indexPath)
        story.read = true
        cell.story = story
        cell.configureCellWithStory(story)
        DBManager.sharedInstance.saveInContext()
    }

    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<Story> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<Story> = Story.fetchRequest()
        
        // Set the batch size to a suitable number.
        //fetchRequest.fetchBatchSize = 30
        
        // Edit the sort key as appropriate.
        let sortDescriptorTop = NSSortDescriptor(key: "top", ascending: false)
        let sortDescriptorId = NSSortDescriptor(key: "id", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptorTop, sortDescriptorId]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: "top", cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<Story>? = nil
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            (tableView.cellForRow(at: indexPath!)! as! StoryTableViewCell).configureCellWithStory( anObject as! Story)
        case .move:
            (tableView.cellForRow(at: indexPath!)! as! StoryTableViewCell).configureCellWithStory( anObject as! Story)
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showStory" {
            if let cell = sender as? StoryTableViewCell{
                if let indexPath = tableView.indexPath(for: cell) {
                    let story = fetchedResultsController.object(at: indexPath)
                    let detail:StoryDetailVC = segue.destination as! StoryDetailVC
                    detail.managedObjectContext = self.fetchedResultsController.managedObjectContext
                    detail.configureStory(story)
                }
            }
        }
        
    }
    

}
