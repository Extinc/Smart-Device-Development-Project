//
//  WorkoutStartViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 17/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MZTimerLabel
import AVKit
import MaterialComponents
class WorkoutStartViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: MZTimerLabel!
    
    var passedExercise: Exercise!
    
    @IBOutlet weak var playVideo: UIBarButtonItem!
    @IBAction func playVideoClick(_ sender: Any) {
        if let path = URL(string: passedExercise.videoLink!)
        {
            let video = AVPlayer(url: path)
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion:
                {
                    video.play()
            })
        }
    }

    @IBAction func startClick(_ sender: Any) {
       timerLabel.start()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.'
        timerLabel.delegate = self
        timerLabel.timerType = MZTimerLabelTypeTimer
        timerLabel.timeFormat = "mm:ss"
        timerLabel.setCountDownTime(TimeInterval(2))

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
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval) {
        print("FINISH")
    }
    
}
