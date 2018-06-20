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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headers[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.label.text = "test"
        return cell
    }

    
    // MARK: - Navigation

 

}
