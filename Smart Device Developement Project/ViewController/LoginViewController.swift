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
    
    var allTextFieldControllers = [MDCTextInputControllerFloatingPlaceholder]()
    
    @IBOutlet weak var loginBtn: MDCFlatButton!
    @IBOutlet weak var signupBtn: MDCFlatButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let buttonScheme = MDCButtonScheme()
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: loginBtn)
        MDCContainedButtonThemer.applyScheme(buttonScheme, to: signupBtn)
        let btncolorScheme = MDCSemanticColorScheme()

        let colors = Colors()
    
        btncolorScheme.primaryColor = colors.secondaryDarkColor

        MDCButtonColorThemer.applySemanticColorScheme(btncolorScheme, to: loginBtn)
        MDCButtonColorThemer.applySemanticColorScheme(btncolorScheme, to: signupBtn)

        loginBtn.setTitle("Login", for: UIControlState())
        loginBtn.titleLabel?.textColor = colors.secondaryTextColor
        signupBtn.setTitle("Sign Up", for: UIControlState())
        signupBtn.titleLabel?.textColor = colors.secondaryTextColor
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
