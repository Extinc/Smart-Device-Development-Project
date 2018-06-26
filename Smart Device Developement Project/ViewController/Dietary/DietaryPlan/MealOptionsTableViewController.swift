//
//  MealOptionsTableViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 17/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

var mealPlan = ["Vegan", "Clean Eating", "High Protein", "Keto"]
var goals = ["Lose weight", "Gain weight", "Maintain weight"]
var duration = ["1 Week", "2 Weeks", "3 Weeks", "1 Month", "3 Months", "6 Months", "1 Year"]

var mealsPerDay = ["1", "2", "3", "4", "5", "6"]
var reminders = ["Yes", "No"]

class MealOptionsTableViewController: UITableViewController {
    
    var headers:[String] = ["Basic", "Advanced"]
    var tableData=[["Type of Meal Plan", "Goals of Diet", "Duration of Diet"],["Meals per day","Meal Timings", "Reminders before Meals"]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.label.text = tableData[indexPath.section][indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "optionsSegue"
        {
            let mealOptions2 = segue.destination as! MealOptionsTableViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow
            if myIndexPath != nil {
                //let movie = data[myIndexPath!.section][myIndexPath!.row]
                //detailViewController.movieItem = movie
            }
        }
    }
}
