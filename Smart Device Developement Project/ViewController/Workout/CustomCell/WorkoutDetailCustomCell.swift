//
//  WorkoutDetailCustomCell.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 14/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class WorkoutDetailCustomCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}

class WorkoutDetailImgCustomCell: UITableViewCell {
    
    @IBOutlet weak var muscleImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
