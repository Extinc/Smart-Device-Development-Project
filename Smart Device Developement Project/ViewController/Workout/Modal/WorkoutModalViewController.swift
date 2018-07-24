//
//  WorkoutModalViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 24/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents
class WorkoutModalViewController: UIViewController {

    @IBOutlet weak var addBtn: MDCFloatingButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        LifestyleTheme.styleFloatBtn(btn: addBtn, title: "", pColor: Colors.PrimaryColor())
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
