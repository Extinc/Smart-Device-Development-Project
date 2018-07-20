    //
    //  WorkoutOfCatViewController.swift
    //  Smart Device Developement Project
    //
    //  Created by ITP312 on 6/7/18.
    //  Copyright © 2018 ITP312. All rights reserved.
    //
    
    import UIKit
    import SDWebImage
    
    class WorkoutOfCatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
        var passedId: Int?
        var passedName: String?
        var searchActive : Bool = false
        var segmentHide: Bool!
        var exercise: [Exercise] = []
        var imageUrls: [URL] = []
        
        @IBOutlet weak var titleHeader: UINavigationItem!
        @IBOutlet weak var tableView: UITableView!
        @IBOutlet weak var searchBar: UISearchBar!
        @IBOutlet weak var difficultySegmentCtrl: UISegmentedControl!
        
        @IBAction func difficultyChange(_ sender: Any) {
            exercise = ExerciseDataManager.loadExerciseOfLevel(level: difficultySegmentCtrl.titleForSegment(at: difficultySegmentCtrl.selectedSegmentIndex)!)
            DispatchQueue.main.async {
                WorkoutImageDataManager.prefetchImage(exercise: self.exercise)
                self.tableView.reloadData()
            }
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Do any additional setup after loading the view.
            titleHeader.title = passedName
            tableView.delegate = self
            tableView.dataSource = self
            searchBar.delegate = self
            print("segmentHide: \(segmentHide)")
            if segmentHide == true{
                difficultySegmentCtrl.isHidden = true
            } else {
                difficultySegmentCtrl.isHidden = false
            }
            
            if self.passedName != "All" {
                if let passid: Int = self.passedId!{
                    print("passed id: ", passid)
                    exercise = ExerciseDataManager.loadExerciseOfCat(catID: passid)
                }
            } else {
                exercise = ExerciseDataManager.loadExerciseOfLevel(level: difficultySegmentCtrl.titleForSegment(at: difficultySegmentCtrl.selectedSegmentIndex)!)
            }
            
            DispatchQueue.main.async {
                self.prefetchImage()
            }
            
        }
        
        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        

        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        // ****************************************************************************
        // For Table
        // ****************************************************************************
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if searchActive {
                return 1
            }
            return exercise.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutListCustomCell
            if let url = URL.init(string: exercise[indexPath.row].imageLink[1]) {
                cell.imageView?.sd_setImage(with: url, completed: { (image, error, cacheType, imageURL) in
                    if error != nil {
                        print("Image View Error: \(error.debugDescription)")
                    }
                })
            }
            cell.exerciseLabel.text = exercise[indexPath.row].name
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 100
        }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showWorkoutDetail" {
                var viewController = segue.destination as! WorkoutDetailViewController
                if let cell = sender as? WorkoutListCustomCell {
                    print("Cell : ", exercise[(tableView.indexPath(for: cell)?.row)!].id)
                    viewController.passedExercise = exercise[(tableView.indexPath(for: cell)?.row)!]
                }
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
        
        func prefetchImage(){
            for i in self.exercise {
                for k in i.imageLink {
                    if let url = URL.init(string: k) {
                        self.imageUrls.append(url)
                    }
                }
            }
            
            SDWebImagePrefetcher.shared().prefetchURLs(self.imageUrls, progress: nil, completed: { finishedCount, skippedCount in
                print("Prefetch complete!")
            })
        }
        
    }
    
    extension WorkoutOfCatViewController: UISearchBarDelegate {
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchActive = true;
        }
        
        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            searchActive = false;
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false;
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false;
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            self.tableView.reloadData()
        }
        
    }
