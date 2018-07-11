//
//  HistorySessionViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 7/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit



class HistorySessionViewController: UIViewController {

  
    @IBOutlet weak var btnAverageSpeed: UIButton!
    
    
    @IBOutlet weak var lblavgspeed: UILabel!
    
    @IBOutlet weak var lblTotalTime: UILabel!
    
    @IBOutlet weak var lblTotalDistance: UILabel!
    
    @IBOutlet weak var lblTotalCaloriesBurnt: UILabel!
    
    var currentid = String()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var selectedID : Int = Int(currentid)!
        var selectedSession = RunningDataManager.loadSessionByID(selectedID)
        lblTotalTime.text = selectedSession.totaltime
        lblTotalDistance.text = String(format: "%.2f",selectedSession.totaldistance!)
        lblTotalCaloriesBurnt.text = String(format: "%.2f", selectedSession.totalcaloriesburnt!)
        lblavgspeed.text = String(format: "%.2f", selectedSession.totalspeed!)
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
