//
//  WorkoutStartViewController.swift
//  Smart Device Developement Project
//
//  Created by ITP312 on 17/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MZTimerLabel
import AVKit
import MaterialComponents
class WorkoutStartViewController: UIViewController,UIScrollViewDelegate {
    
    var passedExercise: Exercise!
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    @IBOutlet weak var timerLabel: MZTimerLabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var playVideo: UIBarButtonItem!
    
    @IBOutlet weak var playBtn: MDCFlatButton!
    
    @IBAction func playVideoClick(_ sender: Any) {
        if let path = URL(string: passedExercise.videoLink!)
        {
            let video = AVPlayer(url: path)
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion:
                {
                    video.play()
            })
        }
    }

    @IBAction func startClick(_ sender: Any) {
       timerLabel.start()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.'
        timerLabel.delegate = self
        timerLabel.timerType = MZTimerLabelTypeTimer
        timerLabel.timeFormat = "mm:ss"
        timerLabel.setCountDownTime(TimeInterval(2))

        scrollView.delegate = self
        let contentSize = CGSize(width: scrollView.bounds.width * CGFloat(passedExercise.imageLink.count+1),
                                 height: scrollView.bounds.height)
        scrollView.contentSize = contentSize

        
        addImagetoPaging()
        
        LifestyleTheme.styleBtn2(btn: playBtn, title: "Begin", pColor: Colors.PrimaryDarkColor())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    
    @objc func didChangePage(sender: MDCPageControl){
        var offset = scrollView.contentOffset
        offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width;
        scrollView.setContentOffset(offset, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //pageControls.scrollViewDidScroll(scrollView)
        
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        //pageControls.scrollViewDidEndScrollingAnimation(scrollView)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "tableViewEmbed2" {
            var viewController = segue.destination as! WorkoutDetailInfoViewController
            viewController.passedExercise = passedExercise
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func addImagetoPaging(){
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
            //print("Scrollview subcviews ", scrollView.subviews)
        }
        //scrollingPageControl.pageCount = passedExercise.imageLink.count
        
        //pageControls.numberOfPages = passedExercise.imageLink.count
        //let pageControlSize = pageControls.sizeThatFits(stackView.bounds.size)
        //pageControls.frame = CGRect(x: 0, y: stackView.bounds.height - pageControlSize.height, width: stackView.bounds.width, height: pageControlSize.height)
        
        // pageControls.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
        //pageControls.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        //stackView.addSubview(pageControls)
    }
    
}

extension WorkoutStartViewController: MZTimerLabelDelegate {
    func timerLabel(_ timerLabels: MZTimerLabel!, countingTo time: TimeInterval, timertype timerType: MZTimerLabelType) {
        if timerLabels.isEqual(timerLabel) && time < 10 {
            self.timerLabel.timeLabel.textColor = UIColor.red
        }
    }
    func timerLabel(_ timerLabel: MZTimerLabel!, finshedCountDownTimerWithTime countTime: TimeInterval) {
        print("FINISH")
//        let storyboard = UIStoryboard(name: "WorkoutModal", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "WorkoutModalViewController")
//        self.present(controller, animated: true) {
//        }
        if let vc = UIStoryboard(name: "Workout", bundle: nil).instantiateViewController(withIdentifier: "WorkoutModal") as? WorkoutModalViewController
        {
            if let passedName = passedExercise.name {
                vc.passedExerciseName = passedName
            }
            if let passedType: String = ExerciseDataManager.getCategory(catid: passedExercise.category!){
                vc.passedType = passedType
            }
            vc.modalPresentationStyle = .overCurrentContext
            present(vc, animated: true, completion: nil)
        }
    }
    
}
