//
//  DetailsTableViewCell.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 24/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class DetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var thingLabel: UILabel!
    @IBOutlet weak var actualThingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
