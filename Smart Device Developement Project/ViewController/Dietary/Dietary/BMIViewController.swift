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
