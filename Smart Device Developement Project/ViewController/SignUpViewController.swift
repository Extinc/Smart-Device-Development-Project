//
//  SignUpViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 19/5/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBAction func closeSignUp(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
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
    
    @IBOutlet weak var regRepeatPass: MDCTextField! = {
        let pass = MDCTextField()
        pass.backgroundColor = .white
        return pass
    }()
    
    @IBOutlet weak var regHeightTF: MDCTextField! = {
        let height = MDCTextField()
        height.backgroundColor = .white
        return height
    }()
    @IBOutlet weak var regWeightTF: MDCTextField! = {
        let weight = MDCTextField()
        weight.backgroundColor = .white
        return weight
    }()
    
    @IBOutlet weak var closeContainer: UIStackView!
    @IBOutlet weak var signupBtn: MDCFlatButton!
    var allTextFieldControllers = [MDCTextInputControllerFloatingPlaceholder]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        closeContainer.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        closeContainer.layoutMargins.left = closeContainer.frame.size.width * 0.8
        let colors = Colors()
        let lifestyleTheme = LifestyleTheme()

        lifestyleTheme.styleBtn(btn: signupBtn, title: "Sign Up", pColor: colors.primaryDarkColor	)
        setUpTextField()
        
    }		
    func setUpTextField(){
            let reguserController = MDCTextInputControllerOutlined(textInput: reguser)
            reguserController.placeholderText = "Enter your email"
            allTextFieldControllers.append(reguserController)
        
            let regpassController = MDCTextInputControllerOutlined(textInput: regpass)
            regpassController.placeholderText = "Enter Password"
            regpass.isSecureTextEntry = true
            regpass.backgroundColor = .white
            allTextFieldControllers.append(regpassController)
        
            let regRepeatPassController = MDCTextInputControllerOutlined(textInput: regRepeatPass)
            regRepeatPassController.placeholderText = "Confirm Password"
            regRepeatPass.isSecureTextEntry = true
            allTextFieldControllers.append(regRepeatPassController)
        
            let regHeightController = MDCTextInputControllerOutlined(textInput: regHeightTF)
            regHeightController.placeholderText = "Height"
            allTextFieldControllers.append(regHeightController)
        
            let regWeightController = MDCTextInputControllerOutlined(textInput: regWeightTF)
            regWeightController.placeholderText = "Weight"
            allTextFieldControllers.append(regWeightController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        if (regpass.text?.isEmpty)! && (reguser.text?.isEmpty)! {
            let alertController = UIAlertController(title: "Email & Password Empty", message: "Please enter email and password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        } else if regpass.text != regRepeatPass.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }else {
        
            if regHeightTF.text?.isEmpty == false && regWeightTF.text?.isEmpty == false {
                Auth.auth().createUser(withEmail: reguser.text!, password: regpass.text!){ (user, error) in
                    if error == nil {
                        DataManager.insertOthersIntoDB(uid: (user?.user.uid)!, height: self.regHeightTF.text!, weight: self.regWeightTF.text!)
                        
                        self.navigationController?.popViewController(animated: true)
                        self.dismiss(animated: true, completion: nil)
                    }
                    else{
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                }

            } else {
                let alertController = UIAlertController(title: "Height & Weight Empty", message: "Please enter your heeight and weigth", preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        
        }
        

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
    



