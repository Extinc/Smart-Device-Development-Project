//
//  WorkoutViewController.swift
//  Smart Device Developement Project
//
//  Created by lim kei yiang on 15/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import MaterialComponents
import FirebaseAuth
import Cards

class WorkoutViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    var exerciseCat: [ExerciseCategory]?
    var catID : Int = 0
    var exercise: [Exercise]?
    var nameToPass: String?
    var idToPass: Int?
    var a = AuthenticateUser.getUID()
    var cardTitles = ["Home", "Category"]
    
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var cardView1: MDCCard!
    @IBOutlet weak var cardView2: MDCCard!
    @IBOutlet weak var cardView1ImageView: UIImageView!
    @IBOutlet weak var cardView2ImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelAll: UILabel!
    @IBOutlet weak var labelPersonal: UILabel!
    
    
    func getUID()->String{
        var uid: String!
        if Auth.auth().currentUser!.uid.isEmpty == false && Auth.auth().currentUser!.uid != nil {
            uid = Auth.auth().currentUser!.uid
        }
        return uid
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        exerciseCat = ExerciseDataManager.loadCategory()
        
        centerLabel(label: labelAll, anchorView: cardView1)
        centerLabel(label: labelPersonal, anchorView: cardView2)
    }
    
    func testCardColorThemer() {
        
        let colorScheme = MDCSemanticColorScheme()
        colorScheme.surfaceColor = .white
        cardView1.backgroundColor = .white
        cardView1.setBorderColor(UIColor.blue, for: cardView1.state)
        
        MDCCardsColorThemer.applySemanticColorScheme(colorScheme, to: cardView1)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // ****************************************************************************
    // For table
    // ****************************************************************************

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return (exerciseCat?.count)!
        return cardTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let txtColor = UIColor.white
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkoutCustomCardCell
            cell.card.title = cardTitles[indexPath.row]
            cell.card.textColor = txtColor
            cell.card.itemTitle = ""
            cell.card.itemSubtitle = ""
            cell.card.titleSize = 32
            cell.card.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellCat", for: indexPath) as! WorkoutCustomCardCell
            cell.card.title = cardTitles[indexPath.row]
            // Below is image for category
            cell.card.backgroundImage = UIImage(named: "blog-fitnovatives-63015")
            cell.card.textColor = txtColor
            cell.card.itemTitle = ""
            cell.card.itemSubtitle = ""
            cell.card.titleSize = 32
            cell.card.delegate = self

            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView(frame: .zero)
    }
    
    // ****************************************************************************
    
    
    
    
    // ****************************************************************************
    //
    // ****************************************************************************
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /*
        if segue.identifier == "catCellClick" {
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destination as! WorkoutOfCatViewController
            if let cell = sender as? WorkoutCustomViewCell {
                
                idToPass = exerciseCat?[(tableView.indexPath(for: cell)?.row)!].id
                nameToPass = ((cell.cellLabel)!.text)!
                // your new view controller should have property that will store passed value
                viewController.passedId = idToPass
                viewController.passedName = nameToPass

                print(idToPass)
            }
        }*/
        if segue.identifier == "allCardViewClick" {
            var viewController = segue.destination as! WorkoutOfCatViewController
            
            // your new view controller should have property that will store passed value
            viewController.passedName = "All"
        } else if segue.identifier == "homeCardClick" {
            var viewController = segue.destination as! WorkoutOfCatViewController
            
            // your new view controller should have property that will store passed value
            viewController.passedName = "Home"
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
    
    func centerLabel(label: UILabel, anchorView: UIView){
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: anchorView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: anchorView.centerYAnchor).isActive = true
        label.textAlignment = .center
    }
}

extension WorkoutViewController: CardDelegate{
    func cardHighlightDidTapButton(card: CardHighlight, button: UIButton) {
        if card.title == "Home" {
            performSegue(withIdentifier: "homeCardClick", sender: self)
        } else if card.title == "Category" {
            performSegue(withIdentifier: "catCardClick", sender: self)
        }
    }
}
