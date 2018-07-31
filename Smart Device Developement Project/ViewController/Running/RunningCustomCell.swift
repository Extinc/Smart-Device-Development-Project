//
//  RunningCustomCell.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 29/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class RunningCustomCell: UITableViewCell {
    
    @IBOutlet weak var datelabel: UILabel!
    
    @IBOutlet weak var timinglabel: UILabel!
    
    @IBOutlet weak var timingdescriplbl: UILabel!
    
    @IBOutlet weak var calorieslabel: UILabel!
    
    @IBOutlet weak var caloriesdescriptlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
