//
//  ViewMealViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 24/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class ViewMealViewController: UIViewController {
  

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var findBtn: MDCFlatButton!
    @IBOutlet weak var scrollView: UIScrollView!
    var mealPlan: MealPlan = MealPlan("", "", 0, "", "", 0, "", "")
    var meals: [Meal] = [] //to parse all aval meals to other vc
    var meal: Meal = Meal(0, "", "", 0, 0, 0, 0, 0, "", "", "")
    var mealID: Int = 0
    var hawkerCentres : [HawkerCentres] = []
    var hawkerCentresWithMeal : [HawkerCentres] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let colors = Colors()
        let lifestyleTheme = LifestyleTheme()
        
        lifestyleTheme.styleBtn(btn: findBtn, title: "Find Meal", pColor: colors.primaryDarkColor)

        
        mealID = mealPlan.mealID!
        meals = LoadingData.shared.mealList
        
        DispatchQueue.main.async{
            self.loadOneMeal()
        }
        loadAllHawkers()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        recipeImage.image = UIImage(named: mealPlan.recipeImage!)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?)
    {
        let newMeals: [Meal] = RecommendMeal.getSimilarMeal(meal: meal, meals: meals)
        let mealid: Int = mealPlan.mealID!
        hawkerCentresWithMeal = checkForHawker.loadHawkerWithMeal(meal: self.meal, hawkers: self.hawkerCentres)
        if(segue.identifier == "showHawkerSegue")
        {
            let ViewHawkerViewController =
                segue.destination as! HawkerViewController
            
            ViewHawkerViewController.meal = meal
            ViewHawkerViewController.hawkerCentres = hawkerCentres
            ViewHawkerViewController.hawkerCenteresWithMeal = hawkerCentresWithMeal
            
        }
        else if(segue.identifier == "editMealSegue"){
            let ChangeMealViewController = segue.destination as! ChangeMealViewController
            if (mealPlan.isDiary == "No"){
                ChangeMealViewController.meals = newMeals
            }
            else {
                ChangeMealViewController.meals = meals
            }
            
            ChangeMealViewController.meal = meal
            ChangeMealViewController.previousMealPlan = mealPlan
            
        }
    }
    
    // MARK: - Functions
    func loadOneMeal(){
        DietaryPlanDataManagerFirebase.loadOneMeal(id: mealID){
            mealFromFirebase in
            self.meal = mealFromFirebase
        }
    }
    
    func loadAllHawkers(){
        DietaryPlanDataManagerFirebase.loadHawkerCentres(){
            hawkerFromFirebase in
            self.hawkerCentres = hawkerFromFirebase
        }
    }
    
    @IBAction func unwindToRecipeVC(segue:UIStoryboardSegue){}
}
