//
//  ScheduleViewController.swift
//  Smart Device Developement Project
//
//  Created by Ang Bryan on 15/6/18.
//  Copyright © 2018 ITP312. All rights reserved.
//

import UIKit
import EventKit

class ScheduleViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var datePickerTxt: UITextField!
    @IBOutlet weak var lblProgress: UITextField!
    @IBOutlet weak var lblNumber: UITextField!
    
    let picker = UIDatePicker()
    //Get slider value
    @IBAction func slider(_ sender: UISlider) {
        
        lblDistance.text = String(String(format : "%.1f",sender.value))
    }
    
 let day : [String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createDatePicker()

        // Do any additional setup after loading the view.
    }
    
    func createDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        datePickerTxt.inputAccessoryView = toolbar
        datePickerTxt.inputView = picker
        
     
    }
    
    @objc func donePressed(){
        
        datePickerTxt.text = "\(picker.date)"
        view.endEditing(true)
    }
    
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //Create Event in Calendar
    @IBAction func btnCreate(_ sender: Any) {
        
       let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
      
        let eventStore:EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event, completion:{(granted, error) in
            if(granted) && (error == nil)
            {
                print("granted \(granted)")
                print("error \(error)")
               
                //Create Event on the Calendar
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = self.lblDistance.text! + "KM Run/Jogging"
                event.startDate = Date()
                event.endDate = Date()
                event.notes = "Weekly Run/Joggin Training"
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                //Set alarm for the event
                let alarm = EKAlarm(relativeOffset: -3600.0)
                event.addAlarm(alarm)
                
                //Set Recurring Rule For eg. When the user choose 10 time of running session it will repeat 10 time
                
                let recurringrule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.saturday)], daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil
                , daysOfTheYear: nil, setPositions: nil
                    , end: EKRecurrenceEnd.init(occurrenceCount: Int(self.lblNumber.text!)!)
                )
                
                event.recurrenceRules = [recurringrule]
                
                
                
                do{
                    try eventStore.save(event, span: .thisEvent)  
                }catch let error as NSError{
                    print("error : \(error)")
                }
                self.createAlert(title: "Schedule Created", message: "Check Your Calendar for created events")
                
            }
            else {
                print("error : \(error)")
            }
        })
    }
    // Add alarm to event
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return day.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return day[row]
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
