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
    @IBOutlet var doneButton: UIButton!
    
    var meals: [Meal] = [] // Get all aval meals 
    var meal : Meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
 

}
