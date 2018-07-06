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
        progressBar.animate(fromAngle: progressBar.angle, toAngle: 90, duration: 0.5, completion: nil)
    }

    var height = 1.71 //: Double?
    var weight = 80.0 //: Double?
    var BMI: Float?
    var ref:DatabaseReference?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let ref = FirebaseDatabase.Database.database().reference().child("Profile/")

        ref.observeSingleEvent(of: .value,
                               with: { (snapshot) in
                                for record in snapshot.children
                                {
                                    let r = record as! DataSnapshot
                                    // Do any additional setup after loading the view.
                                    //self.height = r.childSnapshot(forPath: "height").value as? Double)!
                                    //self.weight = (r.childSnapshot(forPath: "weight").value as? Double)!
                                }
        })
        print(height)
        print(weight)
        let BMI = weight / (height * height)
        let x = Double(BMI * 100).rounded() / 100
        print("BMI:",x)
        let b1 = 13.7516 * 90.0
        let b2 = 5.0033 * 170
        let b3 = 6.7550 * 20
        var recc = 66.4730 + b1 + b2 - b3
        let y = Int(recc.rounded())
        print(y)
        reccCal.text = y.description
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
