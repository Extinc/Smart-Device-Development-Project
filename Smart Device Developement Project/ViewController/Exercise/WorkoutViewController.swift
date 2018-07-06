//
//  WorkoutViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 15/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class WorkoutViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{


    var exerciseCat: [ExerciseCategory]?
    var catID : Int = 0
    var exercise: [Exercise]?
    
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var cardView1: MDCCard!
    @IBOutlet weak var cardView2: MDCCard!
    @IBOutlet weak var cardView1ImageView: UIImageView!
    @IBOutlet weak var cardView2ImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        exerciseCat = ExerciseDataManager.loadCategory()
        testCardColorThemer()

        //catID = ExerciseDataManager.getCatID(name: workoutSegmentControl.titleForSegment(at: workoutSegmentControl.selectedSegmentIndex)!)

        exercise = ExerciseDataManager.loadExerciseOfCat(catID: catID)
        for ex in exercise!{
            print(ex.name!)
        }

    }
    
    func testCardColorThemer() {
        // Given
        let colorScheme = MDCSemanticColorScheme()
        colorScheme.surfaceColor = .white
        cardView1.backgroundColor = .white
        cardView1.setBorderColor(UIColor.blue, for: cardView1.state)
        // When
        MDCCardsColorThemer.applySemanticColorScheme(colorScheme, to: cardView1)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (exerciseCat?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkoutCustomViewCell
        
        cell.cellLabel.text = exerciseCat?[indexPath.row].name
        
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
