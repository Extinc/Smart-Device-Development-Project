//
//  SignUpViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 19/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class SignUpViewController: UIViewController {

    @IBOutlet weak var reguser: MDCTextField! = {
        let name = MDCTextField()
        name.autocapitalizationType = .words
        name.backgroundColor = .white
        return name
    }()

    @IBOutlet weak var regpass: MDCTextField! = {
        let pass = MDCTextField()
        pass.backgroundColor = .white
        return pass
    }()
    
    @IBOutlet weak var signupBtn: MDCFlatButton!
    var allTextFieldControllers = [MDCTextInputControllerFloatingPlaceholder]()
    
    let primaryColor = UIColor(red: 0.19, green: 0.25, blue: 0.62, alpha: 1.0);
    let primaryLightColor = UIColor(red: 0.40, green: 0.42, blue: 0.82, alpha: 1.0);
    let primaryDarkColor = UIColor(red: 0.00, green: 0.10, blue: 0.44, alpha: 1.0);
    let primaryTextColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 1.0);
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let buttonScheme = MDCButtonScheme()
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: signupBtn)
        let colorScheme = MDCSemanticColorScheme()
        let colors = Colors()
        colorScheme.primaryColor = colors.primaryColor

        MDCButtonColorThemer.applySemanticColorScheme(colorScheme, to: signupBtn)
        signupBtn.setTitle("Sign Up", for: UIControlState())
        setUpTextField()
    }
    
    
    
    func setUpTextField(){
            let reguserController = MDCTextInputControllerOutlined(textInput: reguser)
            reguserController.placeholderText = "Enter username"
            allTextFieldControllers.append(reguserController)
        
            let regpassController = MDCTextInputControllerOutlined(textInput: regpass)
            regpassController.placeholderText = "Enter Password"
            allTextFieldControllers.append(regpassController)
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