//
//  WorkoutViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 15/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {

    @IBOutlet weak var sv: UIStackView!
    
    var exerciseCat: [ExerciseCategory] = [];
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        exerciseCat = ExerciseDataManager.loadCategory()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(exerciseCat)
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
