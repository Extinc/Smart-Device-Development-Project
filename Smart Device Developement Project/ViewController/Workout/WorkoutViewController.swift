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

class WorkoutViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    
    var exerciseCat: [ExerciseCategory]?
    var catID : Int = 0
    var exercise: [Exercise]?
    var nameToPass: String?
    var idToPass: Int?
    var a = AuthenticateUser.getUID()
    
    @IBOutlet weak var stackview: UIStackView!
    @IBOutlet weak var cardView1: MDCCard!
    @IBOutlet weak var cardView2: MDCCard!
    @IBOutlet weak var cardView1ImageView: UIImageView!
    @IBOutlet weak var cardView2ImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
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
        return (exerciseCat?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkoutCustomViewCell
        
        cell.cellLabel.text = exerciseCat?[indexPath.row].name
        cell.idLabel.text = "\(exerciseCat?[indexPath.row].id)"
        let colorScheme = MDCSemanticColorScheme()
        colorScheme.surfaceColor = .white
        cell.card.backgroundColor = .gray
        cell.card.setBorderColor(UIColor.blue, for: cell.card.state)
        
        MDCCardsColorThemer.applySemanticColorScheme(colorScheme, to: cell.card)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // ****************************************************************************
    
    
    
    
    // ****************************************************************************
    //
    // ****************************************************************************
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
        }
        else if segue.identifier == "allCardViewClick" {
            var viewController = segue.destination as! WorkoutOfCatViewController
            
            // your new view controller should have property that will store passed value
            viewController.passedName = "All"
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
}
