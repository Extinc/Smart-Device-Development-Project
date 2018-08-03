//
//  DietaryPlanViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 12/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import UserNotifications
import MaterialComponents

class DietaryPlanViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var generatePlanButton: MDCFlatButton!
    @IBOutlet weak var notifyLabel: UILabel!
    @IBOutlet weak var addMeal: MDCFlatButton!
    
    
    private var datePicker: UIDatePicker?
    
    let headers:[String] = ["Planned Meals", "Dietary Diary"]
    var meal : [Meal] = []
    var mealplan: [MealPlan] = []
    var mealPlans: [[MealPlan]] = [[],[]]

    var contentWidth:CGFloat = 0.0
    var username = ""
    var totalCalories:Int = 0
    var selectedDate:String = ""
    var preferences: [UserPlanPreferences] = []
    var planCount: Int = 0
    
    var planID: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = Colors()
        let lifestyleTheme = LifestyleTheme()
        
        lifestyleTheme.styleBtn(btn: generatePlanButton, title: "Start a new plan", pColor: colors.primaryDarkColor)
        lifestyleTheme.styleBtn(btn: addMeal, title: "Add Meal", pColor: colors.primaryDarkColor)
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let todayDate = formatter.string(from: date)
        dateTextField.text = todayDate
        selectedDate = dateTextField.text!
        
       
        self.username = AuthenticateUser.getUID()
        
        
        //Firebase load meals and plans
        DispatchQueue.main.async {
            DietaryPlanDataManagerFirebase.createMealData()
            self.loadPlanCount(date: self.selectedDate, username: self.username)
        }
        
        
        //Load mealplans to display in table
        mealplan = LoadingData.shared.mealPlan
        for j in 0...self.mealplan.count-1 {
            if (self.mealplan[j].isDiary == "No") {
                self.mealPlans[0].append(self.mealplan[j])
            }
            else if (self.mealplan[j].isDiary == "Yes"){
                self.mealPlans[1].append(self.mealplan[j])
            }
            else{
                break
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
        
        //Load Preferences
        preferences = DietaryPlanDataManager.loadPreferences(username: username)
        
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadPlanCount(date: selectedDate, username: username)
        if(planCount < 1) {
            generatePlanButton.isHidden = false
            notifyLabel.text = "You do not have any meal plans planned today, press start a new plan to generate one."
        }
        else if (planCount > 1){
            generatePlanButton.isHidden = true
            notifyLabel.text = ""
        }
        loadPlanMeals(date: selectedDate, username: username)
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
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        selectedDate = dateTextField.text!
        loadPlanMeals(date: selectedDate, username: username)
        loadPlanCount(date: selectedDate, username: username)
        if(planCount < 1) {
            generatePlanButton.isHidden = false
            notifyLabel.text = "You do not have any meal plans planned today, press start a new plan to generate one."
        }
        else if (planCount > 1){
            generatePlanButton.isHidden = true
            notifyLabel.text = ""
        }
        view.endEditing(true)
    }

    // MARK: - Segue unwind
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
        cell.mealCalories.text = String(describing: mealPlans[indexPath.section][indexPath.row].calories!) + " calories"
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
                let selectedMealPlan: MealPlan = mealPlans[myIndexPath!.section][myIndexPath!.row]
   
                ViewMealViewController.mealPlan = selectedMealPlan
                ViewMealViewController.meals = meal
                ViewMealViewController.mealID = selectedMealPlan.mealID!

            }
        }
        else if(segue.identifier == "viewmealtypessegue"){
            let MealTypeViewController = segue.destination as! MealTypesViewController
            MealTypeViewController.date = selectedDate
        }
    }
    
    
    func loadPlanMeals (date: String, username: String) {
        mealPlans.removeAll()
        mealPlans = [[],[]]
        DietaryPlanDataManagerFirebase.loadMealPlans(date: date, username: username){
            mealPlanListFromFirebase in
            self.mealplan = mealPlanListFromFirebase
          
                for j in 0...self.mealplan.count-1 {
                    if (self.mealplan[j].isDiary == "No") {
                        self.mealPlans[0].append(self.mealplan[j])
                    }
                    else if (self.mealplan[j].isDiary == "Yes"){
                        self.mealPlans[1].append(self.mealplan[j])
                    }
                    else{
                        break
                    }
                }
            
            self.tableView.reloadData()
            
        }
    }
    
    func loadPlanCount(date: String, username: String) {
        DietaryPlanDataManagerFirebase.loadMealPlansCount(date: date, username: username) {
            planCountFromFirebase in
            self.planCount = planCountFromFirebase
            if(self.planCount < 1) {
                self.generatePlanButton.isHidden = false
                self.notifyLabel.text = "You do not have any meal plans planned today, press start a new plan to generate one."
            }
            else if (self.planCount > 1){
                self.generatePlanButton.isHidden = true
                self.notifyLabel.text = ""
            }
        }
        
    }
    
 

   
    @IBAction func loadMeals(_ sender: Any) {
        
        if(planCount < 1) {
        }
        
        DispatchQueue.main.async {
            self.loadPlanMeals(date: self.selectedDate, username: self.username)
        }
    }
    
 

}
