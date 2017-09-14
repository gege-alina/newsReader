//
//  StoryTableViewCell.swift
//  NewsReader
//
//  Created by Gege on 14/09/2017.
//  Copyright © 2017 georgiana. All rights reserved.
//

import UIKit

class StoryTableViewCell: UITableViewCell {

    @IBOutlet var favButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var readButton: UIButton!
    var story:Story? = nil
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithStory(_ story: Story) {
        guard let titleLabel = self.titleLabel,
        let detailLabel = self.detailLabel else {
            return
        }
        titleLabel.text = story.title
        if let date = story.time as Date? {
            detailLabel.text = String(date.toString(dateFormat: "dd-MM-YYYY"))
        }
        
        if story.later {
            self.favButton.imageView?.image = UIImage(named: "star")
            self.favButton.isHidden = false
            self.favButton.isEnabled = true
        }
        else
        {
            self.favButton.imageView?.image = nil
            self.favButton.isHidden = false
            self.favButton.isEnabled = true
        }
        
        if story.read {
            self.readButton.imageView?.image = UIImage(named: "fullFlag")
        }
        else {
            self.readButton.imageView?.image = UIImage(named: "flag")
        }

        
    }
    @IBAction func toggleFavourite(_ sender: UIButton) {
        if let isFav = self.story {
            if isFav.favourite {
                isFav.favourite = false
            }
            else {
                isFav.favourite = true
            }
        }
        DBManager.sharedInstance.saveInContext()
    }

    @IBAction func toggleRead(_ sender: UIButton) {
        if let isRead = self.story {
            if isRead.read {
                isRead.read = false
            }
            else {
                isRead.read = true
            }
        }
        DBManager.sharedInstance.saveInContext()
        
    }
    
}
