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
    var frame = CGRect(x:0,y:0,width:0,height:0)
    var contentWidth:CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = mealType.count
        //Meal Plan Types images to load
        for i in 0...mealType.count-1{
            //Setting size of frame.
            frame.origin.x = scrollView.frame.size.width * CGFloat(i)
            frame.size = scrollView.frame.size
            //Set images to image view
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: mealType[i][2].image)
            //Set buttons
            let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height:50))
            button.setTitle("Select", for: .normal)
            //Add image to scroll view
            self.scrollView.addSubview(imgView)
        }
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(mealType.count)), height: scrollView.frame.size.height)
        scrollView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
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
