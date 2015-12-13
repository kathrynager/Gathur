//
//  GathurDetailsViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/19/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit
import Alamofire

class GathurDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var currentEventLoc = ""
    var currentEventEndTime = ""
    var currentEventPub = ""
    var currentEventid = 0
    var currentEventCreatedTime = ""
    var currentEventTitle = ""
    var currentEventStartTime = ""
    var currentEventUserId = "" //username
    var currentEventUpdatedTime = ""
    var currentEventDes = ""
    var currentEventRealUserId = 0
    
    
    //comment table vars for JSON
    var currentmsg:[String] = []
    var currentname:[String] = []
    
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDatelabel: UILabel!
    @IBAction func back(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        let view : GathuringTableView = self.navigationController?.topViewController as! GathuringTableView
        
    }
    
    @IBOutlet weak var attendees: UIButton!
    @IBOutlet weak var comment: UITextField!
    @IBAction func post(sender: AnyObject) {
        if(comment.text != nil){
            var message = comment.text
            let eventid = currentEventid
            let usertoken = NSUserDefaults.standardUserDefaults().stringForKey("token")!
            let headers = ["Authorization ": "Token " + usertoken]
            
            Alamofire.request(.POST, "https://gathur.herokuapp.com/api/messages",
                parameters:["event_id": eventid,"text": message!],headers: headers)
                .responseJSON
                { response in
                    print(response.request)  // original URL request
                    print(response.response) // URL response
                    print(response.data)     // server data
                    print(response.result)   // result of response serialization
                    
                    if let JSON = response.result.value {
                        print("JSON: \(JSON)")
                        self.comment.text?.removeAll()
                        
                        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/messages",
                            parameters:["event_id": eventid],headers: headers)
                            .responseJSON
                            { response in
                                print(response.request)  // original URL request
                                print(response.response) // URL response
                                print(response.data)     // server data
                                print(response.result)   // result of response serialization
                                
                                if let JSON = response.result.value {
                                    self.currentmsg = [String](count: JSON.count, repeatedValue: "")
                                    self.currentname = [String](count: JSON.count, repeatedValue: "")
                                    // put JSON contents into readable arrays for Swift
                                    for(var i = 0; i < JSON.count; i++){
                                        let item = JSON[i]
                                        
                                        self.currentname[i] = item["display_name"] as! String
                                        self.currentmsg[i] = item["text"] as! String
                                    }
                                    self.commentsTable.reloadData()
                                }
                        }
                    }
            }
        }
        self.commentsTable.reloadData()
    }
    // Add user to attending list and change attend button between unattend & attend
    @IBAction func attend(sender: AnyObject) {
        //        if(gathurObj.friends.isEmpty){
        //            gathurObj.friends.append(currUser)
        //             attendButtonTitle.setTitle("Unattend", forState: .Normal)
        //            currUser.eventsAttending.append(gathurObj)
        //        }
        //        else{
        //            var alreadyAttending = false
        //            for i in 0..<gathurObj.friends.count {
        //                if(gathurObj.friends[i].username == currUser.username){
        //                    gathurObj.friends.removeAtIndex(i)
        //                    alreadyAttending = true
        //                     attendButtonTitle.setTitle("Attend", forState: .Normal)
        //                }
        //            }
        //            if(alreadyAttending == false){
        //                gathurObj.friends.append(currUser)
        //                attendButtonTitle.setTitle("Unattend", forState: .Normal)
        //                currUser.eventsAttending.append(gathurObj)
        //
        //            }
        //            else{
        //                for i in 0..<currUser.eventsAttending.count{
        //                    if currUser.eventsAttending[i].title == gathurObj.title{
        //                        currUser.eventsAttending.removeAtIndex(i)
        //                    }
        //                }
        // }
        // }
        self.viewDidLoad()
    }
    @IBOutlet weak var nameGathurProfile: UILabel!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var gathurTitle: UILabel!
    @IBOutlet weak var gathurDescription: UILabel!
    @IBOutlet weak var attendButtonTitle: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        
        commentsTable.delegate = self
        commentsTable.dataSource = self
        
        // Format the date to acceptable viewing string
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.ShortStyle
        formatter.timeStyle = NSDateFormatterStyle.ShortStyle
       // formatter.dateFormat = "E, dd MMM yyyy HH:mm:ss Z"
//        var index = currentEventStartTime.rangeOfString("T", options: nil)?.startIndex
//        
//        var substring2 = string2.substringToIndex(index!)
//        var date = formatter.dateFromString(currentEventStartTime)
//        let startDate = formatter.stringFromDate(date!)
        
        
        gathurTitle.text = currentEventTitle
        gathurDescription.text = currentEventDes
    //    startDatelabel.text = startDate
        endDateLabel.text = currentEventEndTime
        profilePic.image = UIImage(named: "DefaultPic")
        nameGathurProfile.text = currentEventUserId
        
        // Adjust title for Attendee(s)
        //        if(gathurObj.friends.count == 1){
        //            attendees.setTitle("\(gathurObj.friends.count) Attendee", forState: .Normal)
        //
        //        }
        //        else{
        //            attendees.setTitle("\(gathurObj.friends.count) Attendees", forState: .Normal)
        //        }
        
        // Adjust button title unattend or attend
        //        var alreadyAttending = false
        //        for i in 0..<gathurObj.friends.count {
        //            if(gathurObj.friends[i].username == currUser.username){
        //                alreadyAttending = true
        //                attendButtonTitle.setTitle("Unattend", forState: .Normal)
        //            }
        //        }
        //        if(alreadyAttending == false){
        //            attendButtonTitle.setTitle("Attend", forState: .Normal)
        //
        //        }
        
        let eventid = currentEventid
        let usertoken = NSUserDefaults.standardUserDefaults().stringForKey("token")!
        let headers = ["Authorization ": "Token " + usertoken]
        
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/messages",
            parameters:["event_id": eventid],headers: headers)
            .responseJSON
            { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    self.currentmsg = [String](count: JSON.count, repeatedValue: "")
                    self.currentname = [String](count: JSON.count, repeatedValue: "")
                    // put JSON contents into readable arrays for Swift
                    for(var i = 0; i < JSON.count; i++){
                        let item = JSON[i]
                        
                        self.currentname[i] = item["display_name"] as! String
                        self.currentmsg[i] = item["text"] as! String
                    }
                    self.commentsTable.reloadData()
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(self.currentmsg.count == 0){
            return 0
        }
        else{
            return self.currentmsg.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentIdentifier", forIndexPath: indexPath) as! CommentsTableViewCell
        cell.comment.text = self.currentmsg[indexPath.row]
        cell.user.text = self.currentname[indexPath.row]
        cell.profPic.image = UIImage(named: "DefaultPic.jpg")!
        
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "attendeesIdentifier"){
            let targetController = segue.destinationViewController as! FriendsAttendingTableViewController
            // targetController.gathurObj = gathurObj
        }
    }
}
