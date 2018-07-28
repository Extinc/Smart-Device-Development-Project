//
//  ViewMealViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 24/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class ViewMealViewController: UIViewController {
  

    @IBOutlet weak var recipeImage: UIImageView!
    var mealPlan: MealPlan = MealPlan("", "", 0, "", "", 0, "", "")
    var meals: [Meal] = [] //to parse all aval meals to other vc
    var meal: Meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
    var mealID: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mealID = mealPlan.mealID!
        loadOneMeal()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeImage.image = UIImage(named: mealPlan.mealImage!)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    {
        var newMeals: [Meal] = RecommendMeal.getSimilarMeal(meal: meal, meals: meals)
        let mealid: Int = mealPlan.mealID!
        if(segue.identifier == "showHawkerSegue")
        {
            let ViewHawkerViewController =
                segue.destination as! HawkerViewController
            
            ViewHawkerViewController.mealID = mealid 
            
        }
        else if(segue.identifier == "editMealSegue"){
            let ChangeMealViewController = segue.destination as! ChangeMealViewController
            ChangeMealViewController.meals = newMeals
            ChangeMealViewController.meal = meal
            
        }
    }
    
    // MARK: - Functions
    func loadOneMeal(){
        DietaryPlanDataManagerFirebase.loadOneMeal(id: mealID){
            mealFromFirebase in
            self.meal = mealFromFirebase
        }
    }
}
