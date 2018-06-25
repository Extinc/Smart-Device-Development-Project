//
//  PlanOptionsViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 20/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class PlanOptionsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tableData=["Type of Meal Plan", "Goals of Diet", "Duration of Diet", "Meals per day", "Meal Timing Intervals", "Reminders before Meals"]
    var planpreferences = [UserPlanPreferences]()
    
    var preferences = ["test", "Vegan", "Lose Weight", "2 Weeks", "3", "2 Hours", "Yes"]
    var username = "test"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadPreferences()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlanOptionsTableViewCell
        cell.optionsLabel.text = tableData[indexPath.section]
        if(preferences[indexPath.section + 1] == ""){
            cell.detailLabel.text = "Unselected"
        }
        else {
            cell.detailLabel.text = preferences[indexPath.section + 1]
        }
        return cell
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "optionsSegue") {
            let secondOptions = segue.destination as! PlanOptions2ViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow
            let chosenRow = tableData[(myIndexPath?.section)!]
            var optionsTableData = [String]()
            switch chosenRow{
                case "Type of Meal Plan":
                    optionsTableData = ["Vegan", "Gluten Free", "Clean Eating", "Muscle Builder", "Keto", "Dash"]
                case "Goals of Diet":
                    optionsTableData = ["Gain Weight", "Lose Weight", "Maintain Weight"]
                case "Duration of Diet":
                    optionsTableData = ["1 Week", "2 Weeks", "1 Month", "3 Months", "6 Months"]
                case "Meals per day":
                    optionsTableData = ["1", "2", "3", "4", "5", "6"]
                case "Meal Timings":
                    optionsTableData = ["2 Hours","3 Hours", "4 Hours", "5 Hours", "6 Hours"]
                case "Reminders before Meals":
                    optionsTableData = ["Yes", "No"]
                default:
                    optionsTableData = [ ""]
            }
            secondOptions.tableData = optionsTableData

        }
        
    }

    // MARK: - Functions
    func loadPreferences () {
        planpreferences = PlanDataManager.loadPlanPreferences(username: "test")
        preferences.append(planpreferences[0].mealPlanType!)
        preferences.append(planpreferences[0].goals!)
        preferences.append(planpreferences[0].duration!)
        preferences.append(String(planpreferences[0].mealsperday!))
        preferences.append(planpreferences[0].mealtiming!)
        preferences.append(planpreferences[0].reminders!)
    }

}
