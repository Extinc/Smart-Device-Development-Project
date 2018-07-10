	//
//  WorkoutDetailViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 8/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents
import MaterialComponents.MaterialPageControl
import SDWebImage

class WorkoutDetailViewController: UIViewController, UIScrollViewDelegate{
    

    var passedExercise: Exercise!
    var newText: [String] = []
    var imageurl: [URL] = []
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    let pageControls = MDCPageControl()
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var pageControl: MDCPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        scrollView.delegate = self
        
        prefetchCurrExerciseImage()
        
        titleLabel.text = passedExercise.name!
        
        descLabel.lineBreakMode = .byWordWrapping
        descLabel.numberOfLines = 100
        descLabel.text = passedExercise.desc!
        newText = passedExercise.desc!.components(separatedBy: "\n")
        descLabel.text = ""
        for val in newText {
            
            if val.contains(". ") {
                newText = val.components(separatedBy: ". ")
                
                for val1 in newText {
                    descLabel.text?.append(" • \(val1) \n\n")
                }

            } else if val.contains("Caution") {
                descLabel.text?.append("\(val) \n\n")
            } else {
                descLabel.text?.append(" • \(val) \n\n")
            }
        }

        for count in 0..<passedExercise.imageLink.count {
            frame.origin.x = scrollView.frame.size.width * CGFloat(count)
            frame.size = scrollView.frame.size
            var imageView = UIImageView()
            imageView.frame = frame
            imageView.contentMode = .scaleAspectFit
            if let url = URL.init(string: passedExercise.imageLink[count]) {
                imageView.sd_setImage(with: url, completed: { (image, error, cacheType, imageURL) in
                    if error != nil {
                        print("Image View Error: \(error.debugDescription)")
                    }
                })
            }
            scrollView.addSubview(imageView)
            print("Scrollview subcviews ", scrollView.subviews)
        }
        
        pageControls.numberOfPages = passedExercise.imageLink.count
        
        let pageControlSize = pageControls.sizeThatFits(stackView.bounds.size)
        pageControls.frame = CGRect(x: 0, y: stackView.bounds.height - pageControlSize.height, width: stackView.bounds.width, height: pageControlSize.height)
        
        pageControls.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
        pageControls.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        stackView.addSubview(pageControls)
        
        //scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(passedExercise.imageLink.count)), height: scrollView.frame.size.height)
    }
    
    @objc func didChangePage(sender: MDCPageControl){
        var offset = scrollView.contentOffset
        offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width;
        scrollView.setContentOffset(offset, animated: true)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControls.scrollViewDidScroll(scrollView)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControls.scrollViewDidScroll(scrollView)
        
        //let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        //pageControl.currentPage = Int(pageNumber)
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControls.scrollViewDidEndScrollingAnimation(scrollView)
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
    
    func prefetchCurrExerciseImage(){
        for il in passedExercise.imageLink {
            if let url = URL.init(string: il) {
                imageurl.append(url)
            }
        }
        if let url = URL.init(string: passedExercise.muscleImg!) {
            imageurl.append(url)
        }
        
        SDWebImagePrefetcher.shared().prefetchURLs(imageurl, progress: nil, completed: { finishedCount, skippedCount in
            print("Prefetch complete!")
        })    }

}
