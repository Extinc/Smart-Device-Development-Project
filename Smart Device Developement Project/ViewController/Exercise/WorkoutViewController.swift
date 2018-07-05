//
//  WorkoutViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 15/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class WorkoutViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    var exerciseCat: [ExerciseCategory]?
    var catID : Int = 0
    var exercise: [Exercise]?
    
    @IBOutlet weak var cardView1: MDCCard!
    @IBOutlet weak var cardView2: MDCCard!
    @IBOutlet weak var cardView1ImageView: UIImageView!
    @IBOutlet weak var cardView2ImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testCardColorThemer()
        exerciseCat = ExerciseDataManager.loadCategory()
        
        //catID = ExerciseDataManager.getCatID(name: workoutSegmentControl.titleForSegment(at: workoutSegmentControl.selectedSegmentIndex)!)

        exercise = ExerciseDataManager.loadExerciseOfCat(catID: catID)
        for ex in exercise!{
            print(ex.name!)
        }
        collectionView.register(WorkoutCustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((exerciseCat?.count)!/numberOfSections(in: collectionView))
    }
  
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",
                                                      for: indexPath) as! WorkoutCustomCollectionViewCell
        // If you wanted to have the card show the selected state when tapped
        // then you need to turn isSelectable to true, otherwise the default is false.
        cell.isSelectable = false
       //cell.selectedImageTintColor = .blue
        cell.cornerRadius = 8
        cell.setShadowElevation(ShadowElevation(rawValue: 6), for: .selected)
        cell.setShadowColor(UIColor.black, for: .highlighted)
        return cell
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

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
