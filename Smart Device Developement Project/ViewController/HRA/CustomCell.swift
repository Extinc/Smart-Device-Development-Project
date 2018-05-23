//
//  CustomCell.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 22/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
