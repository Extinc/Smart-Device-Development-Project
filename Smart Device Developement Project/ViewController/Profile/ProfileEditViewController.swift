//
//  ProfileEditViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 1/8/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class ProfileEditViewController: UIViewController {

    var passedHeight: Double = 0.0
    var passedWeight: Double = 0.0
    var passedZS: Double = 0.0
    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var zsTextField: UITextField!
    
    @IBOutlet weak var updateBtn: MDCFlatButton!
    @IBAction func updateProfile(_ sender: Any) {
        AuthenticateUser.updateProfile(uid: AuthenticateUser.getUID(), height: Double(heightTextField.text!)!, weight: Double(weightTextField.text!)!, speed: Double(zsTextField.text!)!)
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        heightTextField.text = "\(passedHeight)"
        weightTextField.text = "\(passedWeight)"
        zsTextField.text = "\(passedZS)"
        LifestyleTheme.styleBtn2(btn: updateBtn, title: "Update", pColor: Colors.PrimaryDarkColor())
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
