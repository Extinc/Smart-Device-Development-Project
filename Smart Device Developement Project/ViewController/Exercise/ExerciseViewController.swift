//
//  ExerciseViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 15/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class ExerciseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Below is Database code
        
        //
        // For workout
        //
        
        ExerciseDataManager.createWorkoutCatTable()
        ExerciseDataManager.createWorkoutTable()
        ExerciseDataManager.createWorkoutImgTable()
        
        // To insert data from api/json into sqlite for quicker access.
        ExerciseDataManager.addExerciseCategoryToDB()
        ExerciseDataManager.insertExerciseToDB()
        ExerciseDataManager.insertWorkoutImgUrlToTable()
        print(ExerciseDataManager.checkIfTableHasRows(tableName: "Workout"))
        //
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
