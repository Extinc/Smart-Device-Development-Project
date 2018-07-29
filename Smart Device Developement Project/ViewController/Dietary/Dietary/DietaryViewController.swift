//
//  DietaryViewController.swift
//  Smart Device Developement Project
//
//  Created by Aloysius on 18/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import FirebaseDatabase

class DietaryViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var reccCal: UILabel!
    @IBOutlet weak var intakeCal: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var progressBar: KDCircularProgress!
    
    var pickerData: [String] = ["None","Lose Weight", "Gain Weight"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(AuthenticateUser.getUID()	)
        
        NutrInfo().calReccCalories(){
            cal in
            self.reccCal.text = cal.description

            let calories = Double(cal)
            let percent = (1500.0/calories)*100
            let angle = (360/100)*percent
            self.progressBar.animate(fromAngle: self.progressBar.angle, toAngle: angle, duration: 0.5, completion: nil)
            self.intakeCal.text = "1500"

            NutrInfo().getGoal(){
                goal in

                self.picker.selectRow(goal, inComponent: 0, animated: true)
            }

            if(self.picker.selectedRow(inComponent: 0) == 1){
                print("loseweight")
            }
            else if(self.picker.selectedRow(inComponent: 0) == 2){
                print("gainweight")
            }
            else{
                print("none")
            }
        }
        
        self.picker.dataSource = self;
        self.picker.delegate = self;
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ picker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
