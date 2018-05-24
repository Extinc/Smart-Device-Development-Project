//
//  SuggestionViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 25/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class SuggestionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmButton: UIButton!
   
    @IBOutlet weak var regenerateButton: UIButton!
    
    let colors = Colors()
    
    let headers:[String] = ["Breakfast", "Lunch", "Dinner", "Snacks"]
    
    let meal = [[Meal("Porridge", "350 Calories", "porridge")],
                [Meal("Chicken Rice", "500 Calories", "chickenrice")],
                [Meal("Aglio Olio", "450 Calories", "aglioolio")],
                [Meal("Oreo", "200 Calories", "oreo")]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regenerateButton.backgroundColor = colors.secondaryDarkColor
        regenerateButton.setTitleColor(colors.secondaryTextColor, for: .normal)
        confirmButton.backgroundColor = colors.secondaryDarkColor
        confirmButton.setTitleColor(colors.secondaryTextColor, for: .normal)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealTableViewCell
        cell.suggestMealCalories.text = meal[indexPath.section][indexPath.row].mealCalories
        cell.suggestMealLabel.text = meal[indexPath.section][indexPath.row].mealName
        cell.suggestMealImage.image = UIImage(named: meal[indexPath.section][indexPath.row].imagePath)
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meal.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
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
