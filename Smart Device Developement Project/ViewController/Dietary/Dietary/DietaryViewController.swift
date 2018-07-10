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
    
    @IBAction func Test(_ sender: Any) {
        let angle = progressBar.angle + 80
        progressBar.animate(fromAngle: progressBar.angle, toAngle: angle, duration: 0.5, completion: nil)
        let a = intakeCal.text
        let x: Int = Int(a!)!
        let y = x + 300
        intakeCal.text = String(y)
        if (progressBar.angle >= 350 ) {
            progressBar.animate(fromAngle: 360, toAngle: 360, duration: 0.5, completion: nil)
        }
    }
    
    var pickerData: [String] = ["Lose Weight", "Gain Weight"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NutrInfo().calReccCalories(){
            cal in
            self.reccCal.text = cal.description
        }
        
        self.picker.dataSource = self;
        self.picker.delegate = self;
        
        progressBar.animate(fromAngle: progressBar.angle, toAngle: 0, duration: 0.5, completion: nil)
        
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
