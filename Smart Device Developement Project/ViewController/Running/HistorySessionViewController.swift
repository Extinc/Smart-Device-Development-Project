//
//  HistorySessionViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 7/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class HistorySessionViewController: UIViewController {

    @IBOutlet weak var lblavgspeed: UILabel!
    
    @IBOutlet weak var lblTotalTime: UILabel!
    
    @IBOutlet weak var lblTotalDistance: UILabel!
    
    @IBOutlet weak var lblTotalCaloriesBurnt: UILabel!
    
    var currentid = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id : Int = Int(currentid)!
        let thisSession : Session = RunningDataManager.loadSessionByID(id)
        lblTotalDistance.text = String(format : "%.1f",thisSession.totaldistance!)
        lblTotalTime.text = String(format : "%.1f",thisSession.totaltime!)
        lblTotalCaloriesBurnt.text = String(format : "%.1f",thisSession.totalcaloriesburnt!)
        
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
