//
//  ChangeMealViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 8/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class ChangeMealViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var chooseMealButton: UIButton!
    @IBOutlet weak var removeMealButton: UIButton!
    
    
    var meals: [Meal] = [] // Get all aval meals 
    var meal : Meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
    var selectedIndexPath: Int = 0
    var selectedMeal : Meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
    var username = ""
    var previousMealPlan: MealPlan = MealPlan("", "", 0, "", "", 0, "", "")
    override func viewDidLoad() {
        super.viewDidLoad()
        username = AuthenticateUser.getUID()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealPlanTableViewCell
        cell.rMealName.text = meals[indexPath.row].name
        cell.rMealCalories.text = String(describing: meals[indexPath.row].calories!)
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
        
        let mealPlan: MealPlan = MealPlan(username, date, mealID, mealName, mealImage, calories, recipeImage, isDiary)
        DietaryPlanDataManagerFirebase.updatePlan(mealPlan: mealPlan)
    }
    
}
