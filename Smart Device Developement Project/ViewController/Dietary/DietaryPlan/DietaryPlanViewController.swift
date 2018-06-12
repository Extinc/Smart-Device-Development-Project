//
//  DietaryPlanViewController.swift
//  Smart Device Developement Project
//
//  Created by Guan Wei on 12/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class DietaryPlanViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    let mealType = [[MealType("Vegan", "No animal products", "vegan")],
                [MealType("Clean Eating", "Ideal if you are looking to make a healthy change in your eating habits", "cleaneating")],
                [MealType("High Protein", "High Protein", "highprotein")],
                [MealType("Keto", "Low in carbohydrates, high in fats. If you get hungry easily and struggle with weight loss this is the plan.", "keto")]]

    var contentWidth:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        loadMealTypeImages()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadMealTypeImages(){
        //Meal Plan Types images to load
        for i in 0...mealType.count-1{
            
            //label to display meal type
            let mealTypeLabel = UILabel()
            mealTypeLabel.text = ""
            mealTypeLabel.textAlignment = .center
            
            //food image to display
            let imageToDisplay = UIImage(named:"\(mealType[i][2].image)")!
            let imageView = UIImageView(image: imageToDisplay)
            
            //x coordinate of image
            let xCoordinate = view.frame.midX + view.frame.width * CGFloat(i)
            //Set x,y coordinates and height and width of image
            imageView.frame = CGRect(x: xCoordinate - 150, y: (view.frame.height / 2) -  100, width: 300, height: 200)
        
            
            //add to scroll view horizontally, so need to + wdith every time it loops
            contentWidth += view.frame.width
            scrollView.addSubview(imageView)
        }
        scrollView.contentSize = CGSize(width: contentWidth, height: view.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / CGFloat(414))
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
