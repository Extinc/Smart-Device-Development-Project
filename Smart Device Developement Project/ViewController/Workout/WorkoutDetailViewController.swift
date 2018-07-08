//
//  WorkoutDetailViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 8/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class WorkoutDetailViewController: UIViewController {

    var passedExercise: Exercise!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        descLabel.text = passedExercise.desc
        print(descLabel.text)
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
    
    func splitStringToMultiLine(str: String){
        
    }

}
