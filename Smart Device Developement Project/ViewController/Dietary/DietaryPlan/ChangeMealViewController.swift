//
//  ChangeMealViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 8/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class ChangeMealViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var chooseMealButton: MDCFlatButton!
    @IBOutlet weak var removeMealButton: MDCFlatButton!
    
    
    var meals: [Meal] = [] // Get all aval meals 
    var meal : Meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
    var selectedIndexPath: Int = 0
    var selectedMeal : Meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
    var username = ""
    var previousMealPlan: MealPlan = MealPlan("", 0,"", 0, "", "", 0, "", "", "", 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        username = AuthenticateUser.getUID()
        print(meals)
        let colors = Colors()
        let lifestyleTheme = LifestyleTheme()
        
        lifestyleTheme.styleBtn(btn: chooseMealButton, title: "Choose Meal", pColor: colors.primaryDarkColor)
        lifestyleTheme.styleBtn(btn: removeMealButton, title: "Remove Meal", pColor: colors.primaryDarkColor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    // MARK : - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealPlanTableViewCell
        cell.rMealName.text = meals[indexPath.row].name
        cell.rMealCalories.text = String(describing: meals[indexPath.row].calories!) + " calories"
        cell.rMealImage.image = UIImage(named: meals[indexPath.row].mealImage!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMeal = meals[indexPath.row]
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
 
    @IBAction func chooseMealAction(_ sender: Any) {
        let date = previousMealPlan.date!
        let mealID = selectedMeal.mealID!
        let mealName = selectedMeal.name!
        let mealImage = selectedMeal.mealImage!
        let calories = selectedMeal.calories!
        let recipeImage = selectedMeal.recipeImage!
        let isDiary = previousMealPlan.isDiary!
        let planID = previousMealPlan.planID!
        let planType = previousMealPlan.planType!
        let count = previousMealPlan.count! - 1
        
        let mealPlan: MealPlan = MealPlan(username, planID, date, mealID, mealName, mealImage, calories, recipeImage, isDiary, planType, count)
        DietaryPlanDataManagerFirebase.deleteMealPlan(previousMealPlan)
        DietaryPlanDataManagerFirebase.updatePlan(mealPlan: mealPlan)
        
        performSegue(withIdentifier: "unwindSegueToRecipeVC", sender: self)
    }
    
    @IBAction func removeMealAction(_ sender: Any) {
        
        DietaryPlanDataManagerFirebase.deleteMealPlan(previousMealPlan)
        performSegue(withIdentifier: "unwindSegueToDietaryPVC", sender: self)
    }
}
