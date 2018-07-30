//
//  FoodViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 11/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class FoodViewController: UIViewController {

    var mName: String?
    var img: UIImage?
    var cal: Float?
    var mealInfo: [MealPlan] = []
    var meal: [Meal] = []
    
    @IBOutlet weak var mealImg: UIImageView!
    @IBOutlet weak var calories: UILabel!
    @IBOutlet weak var addBtn: MDCFlatButton!
    @IBOutlet weak var closeBtn: MDCFlatButton!
    
    @IBOutlet weak var popupView: UIView!
    override func viewDidLoad() {
        
        // UI stuff
        let colors = Colors()
        let lifestyleTheme = LifestyleTheme()
        popupView.backgroundColor = colors.primaryColor
        lifestyleTheme.styleBtn(btn: addBtn, title: "Add", pColor: colors.primaryLightColor)
        lifestyleTheme.styleBtn(btn: closeBtn, title: "Close", pColor: colors.primaryDarkColor)
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.view.isOpaque = false
        self.showAnimate()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closePopUp(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addMeal(_ sender: Any) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let todayDate = formatter.string(from: date)
        
        var mealInfo: [MealPlan] = []
        let username = AuthenticateUser.getUID()
        let mealID = meal[0].mealID
        let mealName = meal[0].name
        let mealImage = meal[0].mealImage
        let calories = Int(meal[0].calories!)
        let recipeImage = meal[0].recipeImage
        
        mealInfo.insert(MealPlan(username, todayDate, mealID!, mealName!, mealImage!, Float(calories), recipeImage!, "Yes" ), at: 0)
        DietaryPlanDataManagerFirebase.createPlanData(mealPlanList: mealInfo)
        performSegue(withIdentifier: "unwindback", sender: self)
    }
    
    func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 1.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
        
        self.mealImg.image = img
        self.calories.text = String(describing: cal!) + " Kcal"
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
}
