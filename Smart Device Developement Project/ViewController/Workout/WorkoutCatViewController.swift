//
//  WorkoutCatViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 22/7/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit

class WorkoutCatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var exCat: [ExerciseCategory]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        exCat = ExerciseDataManager.loadCategory()
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

}

extension WorkoutCatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exCat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell", for: indexPath) as! WorkoutCustomCardCell
        
        cell.card.title = exCat[indexPath.row].name!
        cell.card.textColor = .white
        cell.card.itemTitle = ""
        cell.card.itemSubtitle = ""
        if cell.card.title == "Chest" {
            cell.card.backgroundImage = UIImage(named: "10-best-chest-exercises-for-building-muscle-v2-1-700xh")
        } else if cell.card.title == "Forearms" {
            cell.card.backgroundImage = UIImage(named: "forearm-workout-and-exercises-main")
        } else if cell.card.title == "Lats" {
            cell.card.backgroundImage = UIImage(named: "back-workout242")
        } else if cell.card.title == "Middle Back" {
            cell.card.backgroundImage = UIImage(named: "middleback")
        }else if cell.card.title == "Lower Back" {
            cell.card.backgroundImage = UIImage(named: "lowerback")
        }else if cell.card.title == "Neck" {
            cell.card.backgroundImage = UIImage(named: "neck")
        }else if cell.card.title == "Quadriceps" {
            cell.card.backgroundImage = UIImage(named: "Quadricep")
        }else if cell.card.title == "Hamstrings" {
            cell.card.backgroundImage = UIImage(named: "Hamstring")
        }else if cell.card.title == "Calves" {
            cell.card.backgroundImage = UIImage(named: "Calves")
        }else if cell.card.title == "Triceps" {
            cell.card.backgroundImage = UIImage(named: "tricep")
        }else if cell.card.title == "Traps" {
            cell.card.backgroundImage = UIImage(named: "traps")
        }else if cell.card.title == "Shoulders" {
            cell.card.backgroundImage = UIImage(named: "Shoulders")
        }else if cell.card.title == "Abdominals" {
            cell.card.backgroundImage = UIImage(named: "Abdominals")
        }else if cell.card.title == "Glutes" {
            cell.card.backgroundImage = UIImage(named: "glute")
        }else if cell.card.title == "Biceps" {
            cell.card.backgroundImage = UIImage(named: "bicep")
        }else if cell.card.title == "Adductors" {
            cell.card.backgroundImage = UIImage(named: "adductor")
        }else if cell.card.title == "Abductors" {
            cell.card.backgroundImage = UIImage(named: "abductor")
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
}

