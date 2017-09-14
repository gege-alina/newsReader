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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCellWithStory(_ story: Story) {
        self.titleLabel!.text = story.title
        guard let date = story.time as Date? else {
            return
        }
        self.detailLabel?.text = String(date.toString(dateFormat: "dd-MM-YYYY"))
        if story.favourite {
            self.favButton.imageView?.isHidden = false
        }
        else
        {
            self.favButton.imageView?.isHidden = true
        }
        
        if story.read {
            self.readButton.imageView?.image = UIImage(named: "fullFlag")
        }
        
    }
    @IBAction func toggleFavourite(_ sender: UIButton) {
        
        
    }

    @IBAction func toggleRead(_ sender: UIButton) {
        
        
    }
    
}
