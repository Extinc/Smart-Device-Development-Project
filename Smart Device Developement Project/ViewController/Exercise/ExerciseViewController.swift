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


    @IBOutlet weak var workoutCard: MDCCard!
    @IBOutlet weak var runningCard: MDCCard!
    @IBOutlet weak var runningStackView: UIStackView!
    @IBOutlet weak var workoutStackView: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Below is Database code
    
        LifestyleTheme.styleCard(card: workoutCard, isInteractable: true, cornerRadius: 12.0)
        LifestyleTheme.styleCard(card: runningCard, isInteractable: true, cornerRadius: 12.0)
        
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
