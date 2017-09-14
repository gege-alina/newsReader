//
//  IndexVC.swift
//  NewsReader
//
//  Created by Gege on 13/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit

class IndexVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
