//
//  WorkoutOfCatViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 6/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class WorkoutOfCatViewController: UIViewController {

    var passedId: String?
    var passedName: String?
    
    @IBOutlet weak var titleHeader: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleHeader.title = passedName
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
