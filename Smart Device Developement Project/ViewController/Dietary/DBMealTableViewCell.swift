//
//  DBMealTableViewCell.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 23/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class DBMealTableViewCell: UITableViewCell {
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}