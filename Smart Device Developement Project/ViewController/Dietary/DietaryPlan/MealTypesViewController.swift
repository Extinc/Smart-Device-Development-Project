//
//  MealTypesViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 24/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents

class MealTypesViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var choosePlanButton: MDCFlatButton!
    
    var images: [String] = ["normal1", "dash1", "keto1"]
    var frame = CGRect(x:0, y:0, width:0, height:0)
    
    var date: String = ""
    var planID: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Buttons
        let colors = Colors()
        let lifestyleTheme = LifestyleTheme()
        
        lifestyleTheme.styleBtn(btn: choosePlanButton, title: "Choose A Plan", pColor: colors.primaryDarkColor)
        
        // Do any additional setup after loading the view.
        pageControl.numberOfPages = images.count
        
        for index in 0..<images.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(index)
            frame.size = scrollView.frame.size
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imgView)
        }
        
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(images.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //Scrollview Method
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }

    

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "choosePlanSegue"){
            let PlanMealViewController = segue.destination as! PlanOptionsViewController
            PlanMealViewController.selectedDate = date
            PlanMealViewController.planID = planID 
        }
    }

    
    //MARK: - Functions
    func loadPlanID(date: String, username: String) {
        DietaryPlanDataManagerFirebase.loadPlanID(date: date, username: username){
            planIDFromFirebase in
            self.planID = planIDFromFirebase
        }
    }
 

}
