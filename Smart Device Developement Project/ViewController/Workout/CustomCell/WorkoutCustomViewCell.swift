//
//  WorkoutCustomCollectionViewCell.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 4/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents
import Cards

class WorkoutCustomViewCell: UITableViewCell{
    @IBOutlet weak var idLabel: UILabel!
    
    @IBOutlet weak var cellLabel: UILabel!
    
    @IBOutlet weak var card: MDCCard!
}

class WorkoutListCustomCell: UITableViewCell {
    
    @IBOutlet weak var exerciseimageView: UIImageView!
    
    @IBOutlet weak var exerciseLabel: UILabel!
    
}

class WorkoutCustomCardCell: UITableViewCell {
    
    @IBOutlet weak var card: CardHighlight!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func TestButton(_ sender: Any) {
        print("TEST BUTTON")
    }
}

