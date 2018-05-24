//
//  ViewGraphViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 24/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class ViewGraphViewController: UIViewController {

    @IBOutlet weak var imgGraph: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet var periodButton: [UIButton]!
        
        @IBAction func handleSelection(_ sender: UIButton) {
            
            periodButton.forEach{(button) in
                button.isHidden = !button.isHidden
            }
    }
    
    
    @IBAction func daysago(_ sender: Any) {
        imgGraph.image = UIImage (named : "graph7day")
    }
    
    @IBAction func weeksago(_ sender: Any) {
        imgGraph.image = UIImage (named : "graphweek")
    }
    
    @IBAction func monthsago(_ sender: Any) {
        imgGraph.image = UIImage (named : "monthago")
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
