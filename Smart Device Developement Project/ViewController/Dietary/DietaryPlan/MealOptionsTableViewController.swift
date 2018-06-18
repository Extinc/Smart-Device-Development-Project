//
//  MealOptionsTableViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 17/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

var mealPlan = ["", "", "", ""]
var goals = ["Lose weight", "Gain weight", "Maintain weight"]
var duration = ["1 Week", "2 Weeks", "3 Weeks", "1 Month", "3 Months", "6 Months", "1 Year"]

var mealsPerDay = ["1", "2", "3", "4", "5", "6"]
var reminders = ["Yes", "No"]

class MealOptionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
