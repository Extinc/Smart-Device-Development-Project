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
    @IBOutlet weak var generatePlanButton: UIButton!
    
    private var datePicker: UIDatePicker?
    
    
    /*let mealType = [[MealType("Vegan", "No animal products", "vegan")],
                [MealType("Clean Eating", "Ideal if you are looking to make a healthy change in your eating habits", "cleaneating")],
                [MealType("High Protein", "High Protein", "highprotein")],
                [MealType("Keto", "Low in carbohydrates, high in fats. If you get hungry easily and struggle with weight loss this is the plan.", "keto")]]*/
    let mealplantype = "Vegan"
    let goals = "Maintain weight"
    let headers:[String] = ["Planned Meals", "Dietary Diary"]
    var meal : [Meal] = []
    var mealplan: [MealPlan] = []
    var mealPlans = [[MealPlan(1,"", "", 1, "Chicken rice", "chickenrice", 340.5,"No"),
                     MealPlan(2,"", "", 2, "Aglio Olio", "", 450, "No"),
                     MealPlan(3,"", "", 3, "Porridge", "", 300,"No")],
                     [MealPlan(4,"","", 14, "", "", 200, "Yes")]
                    ]

    var contentWidth:CGFloat = 0.0
    var username = "1"
    var totalCalories:Float = 1800.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        var actualDate = formatter.string(from: date)
        dateTextField.text = actualDate
        
        var preferences : [UserPlanPreferences] = DietaryPlanDataManager.loadPreferences(username: username)
        //Load meals
        loadMeals()
        
        
        //Load meal plans
        if(DietaryPlanDataManager.countPreferences(userName: username) < 1) {
                generatePlanButton.isEnabled = true
        }
        else{
            generatePlanButton.isEnabled = false
            if(DietaryPlanDataManagerFirebase.loadMealPlansCount(date: actualDate, username: username) < 1) {
                RecommendMeal.createMealPlan(meals: meal, date: actualDate, username: username)
            }
            
            loadPlanMeals(date: actualDate, username: username)
            //Append meal inside mealPlans to display at table
            for i in 0...1 {
                for j in 0...mealplan.count {
                    if (mealplan[j].isDiary == "No") {
                        mealPlans[0].append(mealplan[j])
                    }
                    else {
                        mealPlans[1].append(mealplan[j])
                    }
                }
            }
        }
        
        
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
        DietaryPlanDataManager.createUPTable()
        
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
                // Set the mealItem field with the meal
                // object selected by the user.
                //
                let meal = mealPlans[myIndexPath!.row]

                
            }
        }
        
        
    }
    
    // MARK: - Functions
    func loadMeals() {
        DietaryPlanDataManagerFirebase.loadMeals(){
            mealListFromFirebase in
            self.meal = mealListFromFirebase
        }
    }
    
    func loadPlanMeals (date: String, username: String) {
        DietaryPlanDataManagerFirebase.loadMealPlans(date: date, username: username){
            mealPlanListFromFirebase in
            self.mealplan = mealPlanListFromFirebase
        }
    }
   

 

}
