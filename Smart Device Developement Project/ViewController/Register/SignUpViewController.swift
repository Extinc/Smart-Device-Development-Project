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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        signupBtn.setTitle("Sign Up", for: UIControlState())
        signupBtn.backgroundColor = MDCPalette.indigo.accent700
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
        setUpTextField()
    }

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
