//
//  MealOptionsViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 20/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

var mealPlan = ["Vegan", "Clean Eating", "High Protein", "Keto"]
var goals = ["Lose weight", "Gain weight", "Maintain weight"]
var duration = ["1 Week", "2 Weeks", "3 Weeks", "1 Month", "3 Months", "6 Months", "1 Year"]

var mealsPerDay = ["1", "2", "3", "4", "5", "6"]
var reminders = ["Yes", "No"]

class MealOptionsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var headers:[String] = ["Basic", "Advanced"]
    var tableData=[["Type of Meal Plan", "Goals of Diet", "Duration of Diet"],["Meals per day","Meal Timings", "Reminders before Meals"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.label?.text = tableData[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "optionsSegue"
        {
           // let mealOptions2 = segue.destination as!
            
            let myIndexPath = self.tableView.indexPathForSelectedRow
            if myIndexPath != nil {
                //let movie = data[myIndexPath!.section][myIndexPath!.row]
                //detailViewController.movieItem = movie
            }
        }
    }*/

}
