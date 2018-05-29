//
//  LoginViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 19/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents
import FirebaseAuth

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginUser: MDCTextField! = {
        let username = MDCTextField()
        username.backgroundColor = .white
        return username
    }()
    
    @IBOutlet weak var loginPwd: MDCTextField! = {
        let pwd = MDCTextField()
        pwd.backgroundColor = .white
        return pwd
    }()
    
    var allTextFieldControllers = [MDCTextInputControllerFloatingPlaceholder]()
    
    @IBOutlet weak var loginBtn: MDCFlatButton!
    @IBOutlet weak var signupBtn: MDCFlatButton!
    
    var success: Bool = false
    
    @IBAction func loginAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: loginUser.text!, password: loginPwd.text!) { (user, error) in
            if error == nil {
                
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTextField()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        let colors = Colors()
        let lifestyleTheme = LifestyleTheme()

        lifestyleTheme.styleBtn(btn: loginBtn, title: "Login", pColor: colors.secondaryDarkColor)
        lifestyleTheme.styleBtn(btn: signupBtn, title: "Sign Up", pColor: colors.secondaryDarkColor)
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
        loginUserController.placeholderText = "Email"
        allTextFieldControllers.append(loginUserController)
        
        let loginPwdController = MDCTextInputControllerOutlined(textInput: loginPwd)
        loginPwdController.placeholderText = "Password"
        loginPwd.isSecureTextEntry = true
        allTextFieldControllers.append(loginPwdController)
    }
}
