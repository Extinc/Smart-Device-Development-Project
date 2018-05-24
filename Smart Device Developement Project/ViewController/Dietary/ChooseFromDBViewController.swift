//
//  ChooseFromDBViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 22/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class ChooseFromDBViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table: UITableView!
    
    
    let meal = [Meal("Porridge", "350 Calories", "porridge"),
                Meal("Chicken Rice", "500 Calories", "chickenrice"),
                Meal("Aglio Olio", "450 Calories", ""),
                Meal("Oreo", "200 Calories", "")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DBMealTableViewCell
        cell.mealLabel.text = meal[indexPath.row].mealName
        cell.caloriesLabel.text = meal[indexPath.row].mealCalories
        cell.mealImage.image = UIImage(named: meal[indexPath.row].imagePath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return meal.count
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "ShowMealDetails"
        {
            let detailViewController = segue.destination as! DisplayMealViewController
            
            let myIndexPath = self.table.indexPathForSelectedRow
            if myIndexPath != nil {
                let actualMeal = meal[myIndexPath!.row]
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
