//
//  BMIViewController.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 8/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class BMIViewController: UIViewController {
    
    @IBOutlet weak var ServerlyUnderWeight: UIView!
    @IBOutlet weak var UnderWeight: UIView!
    @IBOutlet weak var SlightlyUnderWeight: UIView!
    @IBOutlet weak var Normal: UIView!
    @IBOutlet weak var SlightlyOverWeight: UIView!
    @IBOutlet weak var OverWeight: UIView!
    @IBOutlet weak var ServerlyOverWeight: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*NutrInfo().calcBMI(){
            bmi in
            if (bmi <= 0 && bmi <= 10.5){
                self.ServerlyUnderWeight.backgroundColor = UIColor.red
            }
            else if(bmi >= 10.6 && bmi <= 16.5){
                self.SlightlyUnderWeight.backgroundColor = UIColor.red
                self.ServerlyUnderWeight.backgroundColor = UIColor.red
            }
            else if(bmi >= 16.6 && bmi <= 18.5){
                self.UnderWeight.backgroundColor = UIColor.orange
                self.SlightlyUnderWeight.backgroundColor = UIColor.orange
                self.ServerlyUnderWeight.backgroundColor = UIColor.orange
            }
            else if(bmi >= 18.6 && bmi <= 25){
                self.Normal.backgroundColor = UIColor.green
                self.UnderWeight.backgroundColor = UIColor.green
                self.SlightlyUnderWeight.backgroundColor = UIColor.green
                self.ServerlyUnderWeight.backgroundColor = UIColor.green
            }
            else if(bmi >= 26 && bmi <= 29){
                self.SlightlyOverWeight.backgroundColor = UIColor.orange
                self.Normal.backgroundColor = UIColor.orange
                self.UnderWeight.backgroundColor = UIColor.orange
                self.SlightlyUnderWeight.backgroundColor = UIColor.orange
                self.ServerlyUnderWeight.backgroundColor = UIColor.orange
            }
            else if(bmi >= 30 && bmi <= 40){
                self.OverWeight.backgroundColor = UIColor.red
                self.SlightlyOverWeight.backgroundColor = UIColor.red
                self.Normal.backgroundColor = UIColor.red
                self.UnderWeight.backgroundColor = UIColor.red
                self.SlightlyUnderWeight.backgroundColor = UIColor.red
                self.ServerlyUnderWeight.backgroundColor = UIColor.red
            }
            else if(bmi > 41){
                self.ServerlyOverWeight.backgroundColor = UIColor.red
                self.OverWeight.backgroundColor = UIColor.red
                self.SlightlyOverWeight.backgroundColor = UIColor.red
                self.Normal.backgroundColor = UIColor.red
                self.UnderWeight.backgroundColor = UIColor.red
                self.SlightlyUnderWeight.backgroundColor = UIColor.red
                self.ServerlyUnderWeight.backgroundColor = UIColor.red
            }
        }*/
        let bmi = 17.0
        if (bmi >= 0 && bmi <= 10.5){
            self.ServerlyUnderWeight.backgroundColor = UIColor.red
        }
        else if(bmi >= 10.6 && bmi <= 16.5){
            self.SlightlyUnderWeight.backgroundColor = UIColor.red
            self.ServerlyUnderWeight.backgroundColor = UIColor.red
        }
        else if(bmi >= 16.6 && bmi <= 18.5){
            self.UnderWeight.backgroundColor = UIColor.orange
            self.SlightlyUnderWeight.backgroundColor = UIColor.orange
            self.ServerlyUnderWeight.backgroundColor = UIColor.orange
        }
        else if(bmi >= 18.6 && bmi <= 25){
            self.Normal.backgroundColor = UIColor.green
            self.UnderWeight.backgroundColor = UIColor.green
            self.SlightlyUnderWeight.backgroundColor = UIColor.green
            self.ServerlyUnderWeight.backgroundColor = UIColor.green
        }
        else if(bmi >= 26 && bmi <= 29){
            self.SlightlyOverWeight.backgroundColor = UIColor.orange
            self.Normal.backgroundColor = UIColor.orange
            self.UnderWeight.backgroundColor = UIColor.orange
            self.SlightlyUnderWeight.backgroundColor = UIColor.orange
            self.ServerlyUnderWeight.backgroundColor = UIColor.orange
        }
        else if(bmi >= 30 && bmi <= 40){
            self.OverWeight.backgroundColor = UIColor.red
            self.SlightlyOverWeight.backgroundColor = UIColor.red
            self.Normal.backgroundColor = UIColor.red
            self.UnderWeight.backgroundColor = UIColor.red
            self.SlightlyUnderWeight.backgroundColor = UIColor.red
            self.ServerlyUnderWeight.backgroundColor = UIColor.red
        }
        else if(bmi > 41){
            self.ServerlyOverWeight.backgroundColor = UIColor.red
            self.OverWeight.backgroundColor = UIColor.red
            self.SlightlyOverWeight.backgroundColor = UIColor.red
            self.Normal.backgroundColor = UIColor.red
            self.UnderWeight.backgroundColor = UIColor.red
            self.SlightlyUnderWeight.backgroundColor = UIColor.red
            self.ServerlyUnderWeight.backgroundColor = UIColor.red
        }
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
