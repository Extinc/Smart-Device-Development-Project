//
//  WorkoutModalViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 24/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class WorkoutModalViewController: UIViewController {

    var passedExerciseName: String!
    var passedType: String!
    
    @IBOutlet weak var addBtn: MDCFloatingButton!
    @IBOutlet weak var minusBtn: MDCFloatingButton!
    
    @IBOutlet weak var repTextField: UITextField!
    @IBOutlet weak var modalView: UIView!

    @IBAction func addRepCount(_ sender: Any) {
        if let parsedInt: Int = Int(repTextField.text!)! {
            var finalInt = parsedInt + 	1
            repTextField.text = "\(finalInt)"
        }
    }
    
    @IBAction func minuRepCount(_ sender: Any) {
        if repTextField.text != "0" {
            if let parsedInt: Int = Int(repTextField.text!)! {
                var finalInt = parsedInt - 1
                repTextField.text = "\(finalInt)"
            }
        }
    }
    @IBAction func doneClick(_ sender: Any) {
        // To get the unix time stamp to replace hmac_timestamp
        // Get the Unix timestamp
        let timestamp = NSDate().timeIntervalSince1970
        
        print("UTC Timestamp: ",timestamp)
        
        if let reps = Int(repTextField.text!)
        {
            self.dismiss(animated: true) {
                ExerciseDataManager.saveCompletedWorkout(uid: AuthenticateUser.getUID(), exercises: self.passedExerciseName, repCount: reps, typeofExercise: self.passedType)
            }
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.isOpaque = false
        self.showAnimate()
        
        
        LifestyleTheme.styleFloatBtn(btn: addBtn, title: "", pColor: Colors.PrimaryColor())
        LifestyleTheme.styleFloatBtn(btn: minusBtn, title: "", pColor: Colors.PrimaryColor())
        modalView.isOpaque = true
        
        repTextField.delegate = self
        repTextField.keyboardType = .numberPad
        
        print(passedExerciseName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 1;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1		
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
        
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
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

extension WorkoutModalViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
}
