//
//  DietaryViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 15/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialButtons_ButtonThemer

class DietaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var totalCaloriesButton: UIButton!
    @IBOutlet weak var addMealButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    
    let colors = Colors()
    let buttonScheme = MDCButtonScheme()
    
    let headers:[String] = ["Breakfast", "Lunch", "Dinner", "Snacks"]
    
    let meal = [[Meal("Porridge", "350 Calories", "porridge")],
                [Meal("Chicken Rice", "500 Calories", "chickenrice")],
                [Meal("Aglio Olio", "450 Calories", "aglioolio")],
                [Meal("Oreo", "200 Calories", "oreo")]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalCaloriesButton.setImage(UIImage(named: "dietary1")?.withRenderingMode(.alwaysOriginal), for: .normal)
        addMealButton.backgroundColor = colors.secondaryDarkColor
        addMealButton.setTitleColor(colors.secondaryTextColor, for: .normal)
        generateButton.backgroundColor = colors.secondaryDarkColor
        generateButton.setTitleColor(colors.secondaryTextColor, for: .normal)
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealTableViewCell
        cell.mealLabel.text = meal[indexPath.section][indexPath.row].mealName
        cell.caloriesLabel.text = meal[indexPath.section][indexPath.row].mealCalories
        cell.mealImage.image = UIImage(named: meal[indexPath.section][indexPath.row].imagePath)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meal.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMealDetails"
        {
            let detailViewController = segue.destination as! DisplayMealViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow
            if myIndexPath != nil {
                let actualMeal = meal[myIndexPath!.section][myIndexPath!.row]
                detailViewController.mealItem = actualMeal
            }
        }
    }

    //Go to meal plan page.
    @IBAction func goToMealPlan(for segue: UIStoryboardSegue,_ sender: Any) {
        var chosen = 1 //0 = havent choose meal plan, 1 = chose meal plan alr
        //var chosen = 0
        if chosen == 1 {
            let planViewController = segue.destination as! DietaryViewController
            self.navigationController?.pushViewController(planViewController, animated: true)
            
        }
        else if chosen == 0 {
            let mealViewController = segue.destination as! MealPlanViewController
            self.navigationController?.pushViewController(mealViewController, animated: true)
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

}