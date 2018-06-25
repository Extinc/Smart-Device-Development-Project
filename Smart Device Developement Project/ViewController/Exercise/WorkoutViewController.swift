//
//  WorkoutViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 15/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var workoutSegmentControl: UISegmentedControl!
    @IBOutlet weak var workouttable: UITableView!
    @IBOutlet weak var sv: UIStackView!
    
    var exerciseCat: [ExerciseCategory]?
    var catID : Int = 0
    var exercise: [Exercise]?
    
    @IBAction func workoutSegment(_ sender: Any) {

        DispatchQueue.main.async {
            self.catID = ExerciseDataManager.getCatID(name: self.workoutSegmentControl.titleForSegment(at: self.workoutSegmentControl.selectedSegmentIndex)!)
            self.workouttable.reloadData()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        exerciseCat = ExerciseDataManager.loadCategory()

        catID = ExerciseDataManager.getCatID(name: workoutSegmentControl.titleForSegment(at: workoutSegmentControl.selectedSegmentIndex)!)

        exercise = ExerciseDataManager.loadExerciseOfCat(catID: catID)
        for ex in exercise!{
            print(ex.name!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (exercise?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        /*
        if indexPath.row > 1 {
            var x1 : Int = indexPath.row + 1
            var x2 : Int = indexPath.row - 1
            if (exercise![indexPath.row].name!. && exercise![indexPath.row].name! != exercise![x2].name!){
                
            }
        } else {
             cell.textLabel?.text = exercise![indexPath.row].name!
        }*/
        cell.textLabel?.text = exercise![indexPath.row].name!

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
