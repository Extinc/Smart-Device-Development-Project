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
    var mainevents:EKEvent!
    var maineventStore: EKEventStore!
    @IBOutlet weak var lblday: UILabel!
    @IBOutlet weak var daypicker: UIPickerView!
    @IBOutlet weak var buttonCreate: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    @IBOutlet weak var distanceslider: UISlider!
    var savedevent = ""
    var savedevevntstore =  ""
    var username = "john"
    let picker = UIDatePicker()
    //Get slider value
    @IBAction func slider(_ sender: UISlider) {
        
        lblDistance.text = String(String(format : "%.1f",sender.value))
    }
    
 let day : [String] = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]

    override func viewDidLoad() {
        super.viewDidLoad()
        CheckCurrentSchedule()
        
        createDatePicker()
        // Do any additional setup after loading the view.
    }
    
    func CheckCurrentSchedule()
    {
        if(RunningDataManager.checkUserScheduleExist(username) == true)
        {
           
            let CurrentSchedule = RunningDataManager.loadScheduleInformation(username)
            self.buttonCreate.isHidden = true
            self.buttonDelete.isHidden = false
            
            self.lblday.text = CurrentSchedule.day!
            
            
            self.lblProgress.text = CurrentSchedule.progress!
            
            self.lblDistance.text = CurrentSchedule.trainingdistance!
            
            self.lblNumber.text = CurrentSchedule.numberoftimes!
            lblNumber.isEnabled = false
            
            self.datePickerTxt.text = CurrentSchedule.startDate!
            self.datePickerTxt.isEnabled = false
          
            
            daypicker.isHidden = true
            daypicker.isUserInteractionEnabled = false
            
            distanceslider.isUserInteractionEnabled = false
            
            
            
        }
        else{
            self.buttonCreate.isHidden = false
            self.buttonDelete.isHidden = true
            self.datePickerTxt.isHidden = false
            
            lblNumber.isEnabled = true
            
            datePickerTxt.isEnabled = true
            
            daypicker.isUserInteractionEnabled = true
            
            distanceslider.isUserInteractionEnabled = true
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return day.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return day[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblday.text = day[row]
    }
    
    //Creating DatePicker
    func createDatePicker(){
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        datePickerTxt.inputAccessoryView = toolbar
        datePickerTxt.inputView = picker
        
        
    }    //DatePicker done button
    @objc func donePressed(){
        
        datePickerTxt.text = "\(picker.date)"
        view.endEditing(true)
    }
    
    //Creating Alert
    func createAlert (title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func deleteAlert ( title:String, message:String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
      
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            self.deleteEvent()
            
            
        }))
        
        alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: {(action) in alert.dismiss(animated: true, completion: nil)
            
        }))
        
         self.present(alert, animated: true, completion: nil)
        
    }
  
    //Create Event in Calendar
    @IBAction func btnCreate(_ sender: Any) {
        
      //  let dateFormatter = DateFormatter()
      //  dateFormatter.date(from: "yyyy-MM-dd'T'HH:mm:ssZ")
     //   let dateString: Date = dateFormatter.date(from: self.datePickerTxt.text!)!
     //  let dateFormatter = DateFormatter()
      //  dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
      //  let startdate: Date = dateFormatter.date(from: self.datePickerTxt.text!)!
        
      
        let eventStore:EKEventStore = EKEventStore()
        eventStore.requestAccess(to: .event, completion:{(granted, error) in
            if(granted) && (error == nil)
            {
                print("granted \(granted)")
                print("error \(error)")
               
                //Create Event on the Calendar
                let event:EKEvent = EKEvent(eventStore: eventStore)
                event.title = self.lblDistance.text! + "KM Run/Jogging"
                event.startDate = self.picker.date
                event.endDate = self.picker.date
                event.notes = "Weekly Run/Joggin Training"
                event.calendar = eventStore.defaultCalendarForNewEvents
                
                //Set alarm for the event
                let alarm = EKAlarm(relativeOffset: -3600.0)
                event.addAlarm(alarm)
                
                var recurringrule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.saturday)], daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil
                    , daysOfTheYear: nil, setPositions: nil
                    , end: EKRecurrenceEnd.init(occurrenceCount: Int(self.lblNumber.text!)!)
                )
                
                //Set Recurring Rule For eg. When the user choose 10 time of running session it will repeat 10 time
                if(self.lblday.text! == "Sunday")
                {
                  recurringrule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.saturday)], daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil
                , daysOfTheYear: nil, setPositions: nil
                    , end: EKRecurrenceEnd.init(occurrenceCount: Int(self.lblNumber.text!)!)
                    )
                }
                else if(self.lblday.text! == "Monday"){
                     recurringrule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.monday)], daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil
                        , daysOfTheYear: nil, setPositions: nil
                        , end: EKRecurrenceEnd.init(occurrenceCount: Int(self.lblNumber.text!)!)
                    )
                }
                else if(self.lblday.text! == "Tuesday"){
                     recurringrule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.tuesday)], daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil
                        , daysOfTheYear: nil, setPositions: nil
                        , end: EKRecurrenceEnd.init(occurrenceCount: Int(self.lblNumber.text!)!)
                    )
                }
                else if(self.lblday.text! == "Wednesday"){
                     recurringrule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.wednesday)], daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil
                        , daysOfTheYear: nil, setPositions: nil
                        , end: EKRecurrenceEnd.init(occurrenceCount: Int(self.lblNumber.text!)!)
                    )
                }
                else if(self.lblday.text! == "Thursday"){
                    let recurringrule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.thursday)], daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil
                        , daysOfTheYear: nil, setPositions: nil
                        , end: EKRecurrenceEnd.init(occurrenceCount: Int(self.lblNumber.text!)!)
                    )
                }
                else if(self.lblday.text! == "Friday"){
                    let recurringrule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.friday)], daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil
                        , daysOfTheYear: nil, setPositions: nil
                        , end: EKRecurrenceEnd.init(occurrenceCount: Int(self.lblNumber.text!)!)
                    )
                }
                else{
                     recurringrule = EKRecurrenceRule(recurrenceWith: .daily, interval: 1, daysOfTheWeek: [EKRecurrenceDayOfWeek.init(EKWeekday.saturday)], daysOfTheMonth: nil, monthsOfTheYear: nil, weeksOfTheYear: nil
                        , daysOfTheYear: nil, setPositions: nil
                        , end: EKRecurrenceEnd.init(occurrenceCount: Int(self.lblNumber.text!)!)
                    )
                }
                
                event.recurrenceRules = [recurringrule]
                
                do{
                    try eventStore.save(event, span: .thisEvent)
                    
                   self.savedevent = event.eventIdentifier
                  self.savedevevntstore = eventStore.eventStoreIdentifier
                   self.mainevents = event
                   self.maineventStore = eventStore
                }catch let error as NSError{
                    print("error : \(error)")
                }
                self.createAlert(title: "Schedule Created", message: "Check Your Calendar for created events")
                
                
                let newSchedule = Schedule(self.datePickerTxt.text!,self.lblday.text!,self.lblDistance.text!,self.lblNumber.text!,self.lblProgress.text!,self.username,self.savedevevntstore,self.savedevent)
                RunningDataManager.insertOrReplaceSchedule(schedule: newSchedule)
                
            //	 self.CheckCurrentSchedule()
               
                
            }
            else {
                print("error : \(error)")
            }
        //    [self.view .setNeedsDisplay()]
        
        })
        
     
    }
    // Delete Event from calendar
    
    @IBAction func btnDelete(_ sender: Any) {
        deleteAlert(title: "Delete Schedule", message: "Are u going to forfeit this schedule!?")
        
        
    }
    
    
    
    func deleteEvent(){
        let currentschedule = RunningDataManager.loadScheduleInformation(username)
        let eventstore  = EKEventStore()
        let event = eventstore.event(withIdentifier: currentschedule.eventsaved!)
      
        do{
            try eventstore.remove(event!,span:EKSpan.thisEvent,commit:true)
        }catch{
            print("Error while deleting event: \(error.localizedDescription)")
        }
        if(RunningDataManager.forfeitSchedule(username) == true)
        {
            self.createAlert(title: "Forfeit", message: "Event has been deleted from your calendar")
        }
        self.CheckCurrentSchedule()
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
