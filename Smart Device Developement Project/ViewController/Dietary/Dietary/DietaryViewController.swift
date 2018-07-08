//
//  DietaryViewController.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 18/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DietaryViewController: UIViewController {
    @IBOutlet weak var reccCal: UILabel!
    
    @IBOutlet weak var progressBar: KDCircularProgress!
    @IBAction func Test(_ sender: Any) {
        let angle = progressBar.angle + 80
        progressBar.animate(fromAngle: progressBar.angle, toAngle: angle, duration: 0.5, completion: nil)
    }
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let y = NutrInfo().calcBMI()
        print(y)
        
        let x = NutrInfo().calReccCalories()
        reccCal.text = x.description
        progressBar.animate(fromAngle: progressBar.angle, toAngle: 0, duration: 0.5, completion: nil)
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
