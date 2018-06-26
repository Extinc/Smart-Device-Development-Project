//
//  PlanOptionsTableViewCell.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 25/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class PlanOptionsTableViewCell: UITableViewCell {
    @IBOutlet weak var optionsLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
