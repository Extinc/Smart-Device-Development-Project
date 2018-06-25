//
//  DietaryPlanViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 12/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class DietaryPlanViewController: UIViewController, UITableViewDataSource {


    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    private var datePicker: UIDatePicker?
    
    
    /*let mealType = [[MealType("Vegan", "No animal products", "vegan")],
                [MealType("Clean Eating", "Ideal if you are looking to make a healthy change in your eating habits", "cleaneating")],
                [MealType("High Protein", "High Protein", "highprotein")],
                [MealType("Keto", "Low in carbohydrates, high in fats. If you get hungry easily and struggle with weight loss this is the plan.", "keto")]]*/
    let mealplantype = "Vegan"
    let goals = "Maintain weight"

    var contentWidth:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Date picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(DietaryPlanViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        //when user taps, usually keyboard comes up, disables the keyboard coming up
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DietaryPlanViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        //set input type to datepicker
        dateTextField.inputView = datePicker
        
        //check if today's date has a meal plan
        if(dateTextField.text == ""){
            textLabel.text = "You do not have a meal plan for today, select a date or start a new meal plan."
        }
        else{
            textLabel.text = ""
        }
        
        //load meal plan type and goals
      /*  if (mealplantype == ""){
            mptlabel.text = ""
            glabel.text = ""
            mealPlanTypeLabel.text = ""
            goalsLabel.text = ""
        }
        else {
            mealPlanTypeLabel.text = mealplantype
            goalsLabel.text = goals
        }*/
        
        
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealPlanTableViewCell
        return cell
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
