//
//  SearchViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 11/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource{
    
    var mealList: [Meal] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DietaryPlanDataManagerFirebase.loadMeals(){
            meals in
            self.mealList = meals
            
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealPlanTableViewCell
        cell.mname.text = mealList[indexPath.row].name
        cell.mimage.image = UIImage(named: mealList[indexPath.row].mealImage!)
        
        return cell
    }

}
