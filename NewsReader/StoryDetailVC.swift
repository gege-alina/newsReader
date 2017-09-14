//
//  StoryDetailVC.swift
//  NewsReader
//
//  Created by Gege on 13/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit
import CoreData

class StoryDetailVC: UIViewController, UIWebViewDelegate {

    @IBOutlet var webView: UIWebView!
    //var url:String? = nil
    var story:Story? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.center = self.view.center
        //self.view.addSubview(activityIndicator)
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
            activityIndicator.startAnimating()
        }
    }
    
    @objc private func laterButtonPressed(_ sender:Any) {
        if let isLater = self.story {
            if isLater.later {
                isLater.later = false
            }
            else {
                isLater.later = true
            }
        }
        
        DBManager.sharedInstance.saveInContext()
        if (self.story?.later)! {
            let alert = UIAlertController(title: "Save for Later", message: "Story was successfully saved for later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            let alert = UIAlertController(title: "Removed from Later", message: "Story was successfully unsaved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
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
