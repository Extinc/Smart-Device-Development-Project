//
//  InitialPlanViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 17/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class InitialPlanViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let plansVC: DietaryViewController? = storyboard?.instantiateViewController(withIdentifier: "DietaryViewController") as! DietaryViewController
        self.navigationController?.pushViewController(plansVC!, animated: true)
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
