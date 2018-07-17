//
//  WorkoutStartViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 17/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MZTimerLabel

class WorkoutStartViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: MZTimerLabel!
    
    var passedExercise: Exercise!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.'
        timerLabel.delegate = self
        timerLabel.timerType = MZTimerLabelTypeTimer
        timerLabel.timeFormat = "mm:ss"
        timerLabel.setCountDownTime(TimeInterval(60))
        timerLabel.resetTimerAfterFinish = true
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

extension WorkoutStartViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabels: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType) {
        if timerLabels.isEqual(timerLabel) && time < 10 {
            self.timerLabel.timeLabel.textColor = UIColor.red
        }
    }
    
}
