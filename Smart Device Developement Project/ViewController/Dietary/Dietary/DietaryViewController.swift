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
    
    @IBAction func Test(_ sender: Any) {
        /*MealInfo().GetInfo(food: "chicken",
                           onComplete:
            {
                (listofFoodData) in
                // Set the news list downloaded from Reddit
                // to our own newsList variable.
                //
                self.fd = listofFoodData
                
                /*DispatchQueue.main.async{
                 
                 }*/
        })*/
    }
    
    //var fd : [foodData] = []
    var height = 1.71
    var weight = 90.0
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
                                    self.height = 171 //r.childSnapshot(forPath: "height").value as? Float
                                    self.weight = 90 //r.childSnapshot(forPath: "weight").value as? Float
                                }
        })
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
        //circularProgressView.animate(fromAngle: circularProgressView.angle, toAngle: 0, duration: 0.5, completion: nil)
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
