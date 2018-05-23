//
//  DietaryViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 15/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class DietaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    let headers:[String] = ["Breakfast", "Lunch", "Dinner", "Snacks"]
    
    let meal = [[Meal("Porridge", "350 Calories", "porridge")],
                [Meal("Chicken Rice", "500 Calories", "chickenrice")]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination = DisplayMealViewController()
        navigationController?.pushViewController(destination, animated: true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
