//
//  DietaryViewController.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 18/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class DietaryViewController: UIViewController {

    @IBAction func Test(_ sender: Any) {
        MealInfo().GetInfo(food: "chicken",
                           onComplete:
            {
                (listofFoodData) in
                // Set the news list downloaded from Reddit
                // to our own newsList variable.
                //
                self.fd = listofFoodData
                
                /*DispatchQueue.main.async{
                 
                 }*/
        })
    }
    
    var fd : [foodData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
