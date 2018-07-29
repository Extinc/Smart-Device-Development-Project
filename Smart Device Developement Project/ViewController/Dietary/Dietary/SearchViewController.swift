//
//  SearchViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 11/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    var mealList: [Meal] = []
    var searchActive : Bool = false
    var filtered:[Meal] = []

    @IBOutlet weak var search: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    var id: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DietaryPlanDataManagerFirebase.loadMeals(){
            meals in
            self.mealList = meals
            self.tableView.reloadData()
        }
        
        search.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return mealList.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MealPlanTableViewCell
        if(searchActive){
            cell.mname.text = filtered[indexPath.row].name
            cell.mimage.image = UIImage(named: filtered[indexPath.row].mealImage!)
        } else {
            cell.mname.text = mealList[indexPath.row].name
            cell.mimage.image = UIImage(named: mealList[indexPath.row].mealImage!)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowAddMeal", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let popup = segue.destination as! FoodViewController
        let indexPath = tableView.indexPathForSelectedRow!
        
        popup.img = UIImage(named: mealList[indexPath.row].mealImage!)
        popup.cal = mealList[indexPath.row].calories
        popup.mName = mealList[indexPath.row].name
        popup.meal = [mealList[indexPath.row]]
        popup.modalPresentationStyle = .overFullScreen
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtered = mealList.filter({
            (meal: Meal) -> Bool in
            let tmp: NSString = meal.name! as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
}
