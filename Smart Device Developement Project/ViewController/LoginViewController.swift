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
import FirebaseDatabase
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
        // need to 
        if loginUser.text!.isEmpty == true && loginPwd.text!.isEmpty == true{
            let alertController = UIAlertController(title: "Error", message: "Email and Password cannot be empty", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if loginUser.text!.isEmpty == true && loginPwd.text!.isEmpty == false {
            let alertController = UIAlertController(title: "Error", message: "Email cannot be empty", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)			
        } else if loginUser.text!.isEmpty == false && loginPwd.text!.isEmpty == true {
            let alertController = UIAlertController(title: "Error", message: "Password cannot be empty", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if loginUser.text!.isEmpty == false && loginPwd.text!.isEmpty == false {
            Auth.auth().signIn(withEmail: self.loginUser.text!, password: self.loginPwd.text!) { (user, error) in

                if error != nil {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    
                    let databaseRef = FirebaseDatabase.Database.database().reference()
                    print("Login")
                    databaseRef.child("Users").observeSingleEvent(of: DataEventType.value, with: { (snapshot) in
                        
                        if snapshot.hasChild(self.loginUser.text!){
                            
                            print("User exist")
                            let userID: String? = user?.user.uid
                            let email: String? = user?.user.email
                            if DataManager.checkUserExist(params: [userID!, email!]) == false {
                                print(DataManager.checkUserExist(params: [userID!, email!]))
                                DataManager.insertUserInfo(uid: userID!, email: email!)
                            }

                        }else{
                            
                            print("User no exist")
                        }
                    
                    })

                }
            }
        }
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupTextField()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let colors = Colors()
        let lifestyleTheme = LifestyleTheme()

        lifestyleTheme.styleBtn(btn: loginBtn, title: "Login", pColor: colors.primaryDarkColor)
        lifestyleTheme.styleBtn(btn: signupBtn, title: "Sign Up", pColor: colors.primaryDarkColor)
        
        DataManager.createUserInfoTable()
        
        //
        // For workout
        //
        ExerciseCreateDataManager.createWorkoutCatTable()
        ExerciseCreateDataManager.createEquipmentTable()
        ExerciseCreateDataManager.createWorkoutTable()
        
        // To insert data from api/json into sqlite for quicker access.
        ExerciseDataManager.addExerciseCategoryToDB()
        ExerciseDataManager.insertEquipmentListToTable()
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}
