//
//  WorkoutPersonalCreateViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 31/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import IQDropDownTextField
import MaterialComponents
class WorkoutPersonalCreateViewController: UIViewController, IQDropDownTextFieldDataSource, IQDropDownTextFieldDelegate {
    
    
    @IBAction func createCustomWorkoutSet(_ sender: Any) {
        var workouts: [String] = []
        //workouts.append(workoutTextField.text(in: UITextRange.init().end))
        //workouts.append(workoutTextField2.text(in: UITextRange.init().end))
    }
    
    @IBOutlet weak var createBtn: MDCFlatButton!
    
    @IBOutlet weak var workoutTextField: IQDropDownTextField!
    @IBOutlet weak var workoutTextField2: IQDropDownTextField!
    
    
    var itemList: [String] = []
    var currTextField: Int = 0
    var exercises: [Exercise] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        workoutTextField.isOptionalDropDown = false
        LifestyleTheme.styleBtn2(btn: createBtn, title: "Create", pColor: Colors.PrimaryDarkColor())
        ExerciseDataManager.getExercise { (exercise) in
            self.exercises = exercise
            
            for ex in exercise {
                self.itemList.append(ex.name!)
                self.workoutTextField.itemList = self.itemList
                self.workoutTextField2.itemList = self.itemList
            }
        }
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
