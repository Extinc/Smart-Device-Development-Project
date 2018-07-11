//
//  ExerciseViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 15/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class ExerciseViewController: UIViewController {


    @IBOutlet weak var workoutLabel: UILabel!
    @IBOutlet weak var runningLabel: UILabel!
    @IBOutlet weak var workoutCard: MDCCard!
    @IBOutlet weak var runningCard: MDCCard!
    @IBOutlet weak var runningStackView: UIStackView!
    @IBOutlet weak var workoutStackView: UIStackView!
    @IBOutlet weak var runningImgView: UIImageView!
    @IBOutlet weak var workoutImgView: UIImageView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Below is Database code
    
        //  *****
        //  Blur Effect for Image View
        //  *****
        let blurEffect = UIBlurEffect(style: .regular)
        let blurViewRunning = UIVisualEffectView(effect: blurEffect)
        let blurViewWorkout = UIVisualEffectView(effect: blurEffect)
        blurViewRunning.frame = runningImgView.bounds
        runningImgView.addSubview(blurViewRunning)
        blurViewWorkout.frame = workoutImgView.bounds
        workoutImgView.addSubview(blurViewWorkout)
        //

        //  *****
        //  Card View & Image View Corner Radius
        //  *****
        let cR = 12.0
        LifestyleTheme.styleCard(card: workoutCard, isInteractable: true, cornerRadius: cR)
        LifestyleTheme.styleCard(card: runningCard, isInteractable: true, cornerRadius: cR)
        
        runningImgView.layer.cornerRadius = CGFloat(cR)
        runningImgView.layer.masksToBounds = true
        workoutImgView.layer.cornerRadius = CGFloat(cR)
        workoutImgView.layer.masksToBounds = true
        //
        print(ExerciseDataManager.checkIfTableHasRows(tableName: "Workout"))
        //
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ExerciseDataManager.insertExerciseToDB()
    
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
