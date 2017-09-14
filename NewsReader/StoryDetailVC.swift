//
//  StoryDetailVC.swift
//  NewsReader
//
//  Created by Gege on 13/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit
import CoreData

class StoryDetailVC: UIViewController {

    @IBOutlet var webView: UIWebView!
    //var url:String? = nil
    var story:Story? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reload()
        
        let laterButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(laterButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = laterButton
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureStory(_ story:Story) {
        self.story = story
    }
    
    private func reload() {
        if let urlString = self.story?.url,
            let url = URL(string: urlString) {
                self.webView.loadRequest(URLRequest(url: url))
        }
    }
    
    @objc private func laterButtonPressed(_ sender:Any) {
        self.story?.later = true
        
        guard let context = self.managedObjectContext else {
            return
        }
        // Save the context.
        do {
            try context.save()
            let alert = UIAlertController(title: "Save for Later", message: "Story was successfully saved for later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
