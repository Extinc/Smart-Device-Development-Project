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
    
    var bmi:Double = 0.0
    var rcalories:Int = 0
    var weight:Double = 0.0
    var goals:Int = 0
    
    @IBOutlet weak var reccCal: UILabel!
    @IBOutlet weak var intakeCal: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var progressBar: KDCircularProgress!
    
    var pickerData: [String] = ["None","Lose Weight", "Gain Weight"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.reccCal.text = LoadingData.shared.rcalories.description
        self.picker.selectRow(LoadingData.shared.goals, inComponent: 0, animated: true)
        
        let intake: Double = 0.0
        
        let calories = 1500.0
        let percent = (intake/calories)*100
        let angle = (360/100)*percent
        self.progressBar.animate(fromAngle: self.progressBar.angle, toAngle: angle, duration: 0.5, completion: nil)
        self.intakeCal.text = intake.description

        
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
