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
    
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func createCustomWorkoutSet(_ sender: Any) {
        var workouts: [String] = []
        workouts.append(workoutTextField.selectedItem!)
        workouts.append(workoutTextField.selectedItem!)
        ExerciseDataManager.createWorkout(uid: AuthenticateUser.getUID(), setName:
            nameTextField.text! , exercises: workouts)
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var createBtn: MDCFlatButton!
    
    @IBOutlet weak var workoutTextField: IQDropDownTextField!
    @IBOutlet weak var workoutTextField2: IQDropDownTextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    
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

//    func setupTextField(){
//        let loginUserController = MDCTextInputControllerOutlined(textInput: loginUser)
//        loginUserController.placeholderText = "Email"
//        allTextFieldControllers.append(loginUserController)
//
//        let loginPwdController = MDCTextInputControllerOutlined(textInput: loginPwd)
//        loginPwdController.placeholderText = "Password"
//        loginPwd.isSecureTextEntry = true
//        allTextFieldControllers.append(loginPwdController)
//    }
    
}
