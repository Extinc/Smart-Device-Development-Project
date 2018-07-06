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
    @IBOutlet weak var tableView: UITableView!
    
    private var datePicker: UIDatePicker?
    
    
    /*let mealType = [[MealType("Vegan", "No animal products", "vegan")],
                [MealType("Clean Eating", "Ideal if you are looking to make a healthy change in your eating habits", "cleaneating")],
                [MealType("High Protein", "High Protein", "highprotein")],
                [MealType("Keto", "Low in carbohydrates, high in fats. If you get hungry easily and struggle with weight loss this is the plan.", "keto")]]*/
    let mealplantype = "Vegan"
    let goals = "Maintain weight"
    let headers = ["Planned Meals", "Dietary Diary"]
    var mealPlans = [[MealPlan("", "", 1, 1, 1, "Chicken rice", "chickenrice", 340.5),
                     MealPlan("", "", 2, 2, 1, "Aglio Olio", "", 450),
                     MealPlan("", "", 3, 3, 1, "Porridge", "", 300)],
                     [MealPlan("","", 14, 4, 1, "", "", 200)]
                    ]

    var contentWidth:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DietaryCreateData.createData()
        
        //Date picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(DietaryPlanViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        //when user taps, usually keyboard comes up, disables the keyboard coming up
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(DietaryPlanViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        //set input type to datepicker
        dateTextField.inputView = datePicker
        
        // Create tables
        PlanDataManager.createUPTable()
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Tap Gestures
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }

    // Segue unwind
    @IBAction func unwindToDietaryPlanController(segue: UIStoryboardSegue) {}
   
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealPlans[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return mealPlans.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealPlanTableViewCell
        cell.mealName.text = mealPlans[indexPath.section][indexPath.row].mealName
        cell.mealCalories.text = String(describing: mealPlans[indexPath.section][indexPath.row].calories!)
        cell.mealImage.image = UIImage(named: mealPlans[indexPath.section][indexPath.row].mealImage!)
        
        return cell
    }

    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    {
        if(segue.identifier == "mealSegue")
        {
            let ViewMealViewController =
                segue.destination as! ViewMealViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow
            
            if(myIndexPath != nil)
            {
                // Set the movieItem field with the movie
                // object selected by the user.
                //
                let meal = mealPlans[myIndexPath!.row]
                let recipe = Recipe(1, 1, "", "", "")
                
                ViewMealViewController.RecipeItem = recipe
                
            }
        }
        
        
    }

 

}
