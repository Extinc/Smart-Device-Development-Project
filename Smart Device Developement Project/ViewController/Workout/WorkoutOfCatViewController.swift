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
        var exercise: [Exercise] = []
        var imageUrls: [URL] = []
        var filtered: [Exercise] = []
        
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
            searchBar.scopeBarBackgroundImage = UIImage.imageWithColor(color: UIColor.white)
            
            if self.passedName != "All" {
                if self.passedName != "Home" {
                    if let passid: Int = self.passedId!{
                        print("passed id: ", passid)
                        exercise = ExerciseDataManager.loadExerciseOfCat(catID: passid)
                        filtered = exercise
                    }
                } else {
                    exercise = ExerciseDataManager.loadExercise()
                    filtered = exercise.filter({$0.equipment == ExerciseDataManager.getEquipID(name: "Body Only")})
                }
            } else {
                exercise = ExerciseDataManager.loadExercise()
                filtered = exercise.filter({$0.level == searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]})
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
        
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView(frame: .zero)
        }
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return filtered.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            var rowCount = indexPath.row
            /*
            if searchActive == false {
                //print("Search Active falase")
                let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutListCustomCell
                if let url = URL.init(string: exercise[rowCount].imageLink[1]) {
                    cell.imageView?.sd_setImage(with: url, completed: { (image, error, cacheType, imageURL) in
                        if error != nil {
                            print("Image View Error: \(error.debugDescription)")
                        }
                    })
                }
                cell.exerciseLabel.text = exercise[indexPath.row].name
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutListCustomCell

                if filtered.count > 0{
                    print("Filted results: \(filtered[rowCount].imageLink)")
                    if let url = URL.init(string: filtered[rowCount].imageLink[1]) {
                        cell.imageView?.sd_setImage(with: url, completed: { (image, error, cacheType, imageURL) in
                            if error != nil {
                                print("Image View Error: \(error.debugDescription)")
                            }
                        })
                    }
                }
                cell.exerciseLabel.text = filtered[indexPath.row].name
                return cell
            }*/
            let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath) as! WorkoutListCustomCell
            
            if filtered.count > 0{
                print("Filted results: \(filtered.count)")
                if let url = URL.init(string: filtered[rowCount].imageLink[1]) {
                    cell.imageView?.sd_setImage(with: url, completed: { (image, error, cacheType, imageURL) in
                        if error != nil {
                            print("Image View Error: \(error.debugDescription)")
                        }
                    })
                }
                    cell.exerciseLabel.text = filtered[indexPath.row].name
            }

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
    
    extension WorkoutOfCatViewController: UISearchBarDelegate{

        func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            if (searchBar.text?.isEmpty)! {
                 searchActive = false
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                 searchActive = true
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchActive = false
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            searchActive = true
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchActive = true
            filtered = exercise.filter({ (ex) -> Bool in
                switch searchBar.selectedScopeButtonIndex {
                case 0:
                    if searchText.isEmpty { return ex.level == searchBar.scopeButtonTitles![0] }
                    return (ex.name?.lowercased().contains(searchText.lowercased()))! && ex.level == searchBar.scopeButtonTitles![0]
                case 1:
                    if searchText.isEmpty { return ex.level == searchBar.scopeButtonTitles![1]}
                    return (ex.name?.lowercased().contains(searchText.lowercased()))! && ex.level == searchBar.scopeButtonTitles![1]
                case 2:
                    if searchText.isEmpty { return ex.level == searchBar.scopeButtonTitles![2]}
                    return (ex.name?.lowercased().contains(searchText.lowercased()))! && ex.level == searchBar.scopeButtonTitles![2]
                default:
                    if searchText.isEmpty { return ex.level == searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex] }
                    return (ex.name?.lowercased().contains(searchText.lowercased()))! && ex.level == searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
                }
            })
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
            
            filtered = exercise.filter({ (ex) -> Bool in
                switch selectedScope {
                case 0:
                    if (searchBar.text?.isEmpty)! { return ex.level == searchBar.scopeButtonTitles![0] }
                    return (ex.name?.lowercased().contains(searchBar.text!.lowercased()))! && ex.level == searchBar.scopeButtonTitles![0]
                case 1:
                    if (searchBar.text?.isEmpty)! { return ex.level == searchBar.scopeButtonTitles![1]}
                    return (ex.name?.lowercased().contains(searchBar.text!.lowercased()))! && ex.level == searchBar.scopeButtonTitles![1]
                case 2:
                    if (searchBar.text?.isEmpty)! { return ex.level == searchBar.scopeButtonTitles![2]}
                    return (ex.name?.lowercased().contains(searchBar.text!.lowercased()))! && ex.level == searchBar.scopeButtonTitles![2]
                default:
                    if (searchBar.text?.isEmpty)! { return ex.level == searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex] }
                    return (ex.name?.lowercased().contains(searchBar.text!.lowercased()))! && ex.level == searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
                }
            })
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    extension UIImage {
        class func imageWithColor(color: UIColor) -> UIImage {
            let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
            color.setFill()
            UIRectFill(rect)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            return image
        }
    }
