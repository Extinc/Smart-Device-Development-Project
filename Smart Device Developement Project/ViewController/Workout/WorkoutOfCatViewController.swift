//
//  WorkoutOfCatViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 6/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import SDWebImage

class WorkoutOfCatViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    

    var passedId: Int?
    var passedName: String?
    var searchActive : Bool = false
    var exercise: [Exercise] = []
    @IBOutlet weak var titleHeader: UINavigationItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleHeader.title = passedName
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        exercise = ExerciseDataManager.loadExerciseOfCat(catID: passedId!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // ****************************************************************************
    // For Table
    // ****************************************************************************
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return 1
        }
        return exercise.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutListCustomCell
        if let url = URL.init(string: exercise[indexPath.row].imageLink[1]) {
            cell.imageView?.sd_setImage(with: url, completed: { (image, error, cacheType, imageURL) in
                if error != nil {
                    print("Image View Error: \(error.debugDescription)")
                }
            })
        }
        cell.exerciseLabel.text = exercise[indexPath.row].name
        return cell
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
