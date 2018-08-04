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
import SelectionList

class WorkoutPersonalCreateViewController: UIViewController, UISearchBarDelegate{
    
    
    @IBAction func close(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func createCustomWorkoutSet(_ sender: Any) {
        
        
        ExerciseDataManager.createWorkout(uid: AuthenticateUser.getUID(), setName:
            nameTextField.text! , exercises: workoutsSelected)
        workoutsSelected.removeAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var createBtn: MDCFlatButton!
    
    @IBOutlet weak var nameTextField: MDCTextField! = {
        let tf = MDCTextField()
        tf.backgroundColor = .white
        return tf
    }()
    @IBOutlet weak var selectList: SelectionList!
    
    var allTextFieldControllers = [MDCTextInputControllerFloatingPlaceholder]()
    var itemList: [String] = []
    var currTextField: Int = 0
    var exercises: [Exercise] = []
    var filtered: [Exercise] = []
    var workoutsSelected: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupTextField()
        LifestyleTheme.styleBtn2(btn: createBtn, title: "Create", pColor: Colors.PrimaryDarkColor())
        self.selectList.addTarget(self, action: #selector(self.selectionChanged), for: .valueChanged)
        self.selectList.allowsMultipleSelection = true
        self.selectList.selectionImage = UIImage(named: "baseline_check_circle_outline_black_24pt")
        self.selectList.deselectionImage = UIImage(named: "baseline_radio_button_unchecked_black_24pt")
        self.selectList.isSelectionMarkTrailing = false // to put checkmark on left side
        ExerciseDataManager.getExercise { (exercise) in
            self.exercises = exercise
            
            for ex in exercise {
                self.itemList.append(ex.name!)
            }

            self.selectList.items = self.itemList

        }

    }

    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            self.itemList = []
            for ex in exercises {
                self.itemList.append(ex.name!)
            }
        } else {
            filtered = exercises.filter({ (e) -> Bool in
                return (e.name?.contains(searchText))!
            })
            for e in filtered {
                self.itemList = []
                self.itemList.append(e.name!)
            }
        }
        self.selectList.items = self.itemList
        
        DispatchQueue.main.async {
            self.selectList.tableView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func selectionChanged() {
        print(workoutsSelected)
        //        selectionList.items.append("\(selectionList.selectedIndexes)")
        //        selectionList.selectedIndexes = [0, 2, 4]
        for i in selectList.selectedIndexes {
            if !self.workoutsSelected.contains(where: { ($0 as! String) == selectList.items[i] }) {
                self.workoutsSelected.append(selectList.items[i])
            }
            
        }
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
    func setupTextField(){
        let nameController = MDCTextInputControllerOutlined(textInput: nameTextField)
        nameController.placeholderText = "Workout Set Title:"
        allTextFieldControllers.append(nameController)

    }
    
}
