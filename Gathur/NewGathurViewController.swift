//
//  NewGathurViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/15/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit
import Alamofire

class NewGathurViewController: UIViewController {
    
    var currUser = Profile()
    
    @IBOutlet weak var gathurTitle: UITextField!
    @IBOutlet weak var gathurDescription: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        
        //set end date picker to an hour later
        var todayDate = NSDate().dateByAddingTimeInterval(3600)
        endDatePicker.setDate(todayDate, animated: true)
    }
    
    @IBAction func post(segue:UIStoryboardSegue) {

        if(gathurTitle.text!.isEmpty || gathurDescription.text!.isEmpty || location.text!.isEmpty){
            let myAlert = UIAlertController(title: "Oops!", message:"All fields required", preferredStyle: UIAlertControllerStyle.Alert)
            let incorrectInfo = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
                //self.dismissViewControllerAnimated(true, completion: nil)
            }
            self.presentViewController(myAlert, animated:true, completion:nil)
            myAlert.addAction(incorrectInfo)
        
        }
        else{

        let authToken = NSUserDefaults.standardUserDefaults().stringForKey("token")!
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateFormatSeconds = NSDateFormatter()
        dateFormatSeconds.dateFormat = "HH:mm:ss"
        
        let eventtitle = gathurTitle.text!
        let eventloc = location.text!
        let eventstarttime = dateFormatter.stringFromDate(datePicker.date) + " " + dateFormatSeconds.stringFromDate(datePicker.date) + ".000000"

        // Check that end time is after start time
        var endDateTime = endDatePicker.date
        if(datePicker.date.earlierDate(endDatePicker.date) == endDatePicker.date) {
            //end date an hour after start
            var laterDate = datePicker.date.dateByAddingTimeInterval(3600)
            endDatePicker.setDate(laterDate, animated: true)
            endDateTime = endDatePicker.date
        }

        let eventendtime = dateFormatter.stringFromDate(endDateTime) + " " + dateFormatSeconds.stringFromDate(endDateTime) + ".000000"
        let eventdes = gathurDescription.text!
        
        let headers = ["Authorization ": "Token " + authToken]
        
        Alamofire.request(.POST, "https://gathur.herokuapp.com/api/events",
            
            parameters:["title": eventtitle, "location": eventloc, "start_time":eventstarttime, "end_time":eventendtime,
                
                "description":eventdes], headers: headers).responseJSON
            
            { response in debugPrint(response)
                if let JSON = response.result.value {
                    
                    print("JSON: \(JSON)")
                       self.navigationController!.popViewControllerAnimated(true)
                     let view : GathuringTableView = self.navigationController?.topViewController as! GathuringTableView
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        view.table.reloadData()
                    })
                 
                }
     
            }
        }
    }
    
}