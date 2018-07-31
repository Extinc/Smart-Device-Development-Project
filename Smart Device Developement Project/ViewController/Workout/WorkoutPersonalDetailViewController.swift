//
//  WorkoutPersonalDetailViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 1/8/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class WorkoutPersonalDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var passedCustom: CustomWorkout!
    
    var exercise: Exercise!
    var exList: [Exercise] = []
    var filtered: [Exercise] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       exList =  ExerciseDataManager.loadExercise()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return passedCustom.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = passedCustom.data[indexPath.row]
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFromCustom" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedRow = indexPath.row
                filtered = exList.filter({ (e) -> Bool in
                    return e.name == passedCustom.data[selectedRow]
                })
                
                let detailVC = segue.destination as! WorkoutDetailViewController
                detailVC.passedExercise = filtered[0]
            }
            
        }
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
