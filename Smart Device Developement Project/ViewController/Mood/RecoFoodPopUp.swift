//
//  RecoFoodPopUp.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 24/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class RecoFoodPopUp: UIViewController {

    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        // Do any additional setup after loading the view.
    }

    @IBAction func ClosePopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
