//
//  LoginViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 19/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginUser: MDCTextField! = {
        let username = MDCTextField()
        username.autocapitalizationType = .words
        username.backgroundColor = .white
        return username
    }()
    
    @IBOutlet weak var loginPwd: MDCTextField! = {
        let pwd = MDCTextField()
        pwd.autocapitalizationType = .words
        pwd.backgroundColor = .white
        return pwd
    }()
    @IBOutlet weak var loginBtn: MDCFlatButton!
    @IBOutlet weak var registerBtn: MDCFlatButton!
    
    var allTextFieldControllers = [MDCTextInputControllerFloatingPlaceholder]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let buttonScheme = MDCButtonScheme()
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: loginBtn)
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: registerBtn)
        let colorScheme = MDCSemanticColorScheme()
        let colors = Colors()
        colorScheme.primaryColor = colors.primaryColor
        
        MDCButtonColorThemer.applySemanticColorScheme(colorScheme, to: loginBtn)
        MDCButtonColorThemer.applySemanticColorScheme(colorScheme, to: registerBtn)
        loginBtn.setTitle("Login", for: UIControlState())
        registerBtn.setTitle("Register", for: UIControlState())
        setupTextField()
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

    func setupTextField(){
        let loginUserController = MDCTextInputControllerOutlined(textInput: loginUser)
        loginUserController.placeholderText = "Username"
        allTextFieldControllers.append(loginUserController)
        
        let loginPwdController = MDCTextInputControllerOutlined(textInput: loginPwd)
        loginPwdController.placeholderText = "Password"
        allTextFieldControllers.append(loginPwdController)
    }
}
