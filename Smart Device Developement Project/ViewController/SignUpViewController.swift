//
//  SignUpViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 18/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var reguser: UITextField!
    @IBOutlet weak var regpass: UITextField!
    @IBOutlet weak var regrepeatpass: UITextField!
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
    
    // Action for the signup button
    //
    @IBAction func registerAction(_ sender: Any) {
        // TODO: Check if username exist in database
        //
        
        if(regrepeatpass.text == regpass.text){
            
        }
    }
}
