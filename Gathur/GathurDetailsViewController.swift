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
    
    var currUser = ""
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
    var currentInvitedUsers :[String] = []
    
    //comment table vars for JSON
    var currentmsg:[String] = []
    var currentname:[String] = []
    
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDatelabel: UILabel!
    @IBOutlet weak var attendees: UIButton!
    @IBOutlet weak var comment: UITextField!
    @IBOutlet weak var nameGathurProfile: UILabel!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var gathurTitle: UILabel!
    @IBOutlet weak var gathurDescription: UILabel!
    @IBOutlet weak var attendButtonTitle: UIButton!
    
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
        
        let token = NSUserDefaults.standardUserDefaults().stringForKey("token")!

        let eventid = currentEventid
        let headers = ["Authorization ": "Token " + token]
        
        var currentevent = ""
        var currentacceptstatus = true;
        
        Alamofire.request(.POST, "https://gathur.herokuapp.com/api/invitations/toggle",parameters: ["event_id":eventid],headers: headers) .responseJSON
            { response in
                debugPrint(response)
                if let JSON = response.result.value {
                    currentevent = JSON["display_name"] as! String
                    currentacceptstatus = JSON["accepted"] as! Bool
                    print(currentacceptstatus)
                    
//                    if(currentacceptstatus == true){
//                        self.attendButtonTitle.setTitle("Attend", forState: .Normal)
//                    }
//                    else{
//                        self.attendButtonTitle.setTitle("Unattend", forState: .Normal)
//                    }
                }
        }
        self.viewDidLoad()
    }
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()        
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
        let token = NSUserDefaults.standardUserDefaults().stringForKey("token")!
        
        let eventid = currentEventid
        let headers = ["Authorization ": "Token " + token]
        
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
                    self.commentsTable.reloadData() //reload table
                }
        }
        // Get all friends attending
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/invitations/event",
            parameters: ["event_id":eventid], headers: headers) .responseJSON
            { response in debugPrint(response)
                if let JSON = response.result.value {
                    self.currentInvitedUsers = [String](count: JSON.count, repeatedValue: "")
                    for(var i = 0; i < JSON.count; i++){
                        let item = JSON[i]
                        // Add users to array
                        self.currentInvitedUsers[i] = item["display_name"] as! String
                    }
                    var boolAttend = false
                    for(var i = 0; i < self.currentInvitedUsers.count; i++){
                        if(self.currentInvitedUsers[i] == self.currUser){
                            boolAttend = true
                        }
                    }
                    print(self.currentInvitedUsers.count)
                    
                    let widthConstraint = NSLayoutConstraint(item: self.attendees, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: 200)
                    self.attendees.titleLabel?.text = "\(self.currentInvitedUsers.count) Attendees"
                            self.attendees.addConstraint(widthConstraint)
//                        if(boolAttend == false){
//                        self.attendButtonTitle.titleLabel?.text = "Attend"
//                        if(self.currentInvitedUsers.count == 1){
//                            self.attendees.titleLabel?.text = "\(self.currentInvitedUsers.count) Attendee"
//                            
//                        }else if(self.currentInvitedUsers.isEmpty){
//                            self.attendees.titleLabel?.text = "0 Attendees"
//                        }
//                        else{
//                            self.attendees.titleLabel?.text = "\(self.currentInvitedUsers.count) Attendees"
//                        }
//                    }
//                    else{
//                        self.attendButtonTitle.titleLabel?.text = "Unattend"
//                        if(self.currentInvitedUsers.count == 1){
//                            self.attendees.titleLabel?.text = "\(self.currentInvitedUsers.count) Attendee"
//                            self.attendees.addConstraint(widthConstraint)
//
//                            
//                        }else if(self.currentInvitedUsers.isEmpty){
//                            self.attendees.titleLabel?.text = "0 Attendees"
//                            self.attendees.addConstraint(widthConstraint)
//
//                        }
//                        else{
//                            self.attendees.titleLabel?.text = "\(self.currentInvitedUsers.count) Attendees"
//                            self.attendees.addConstraint(widthConstraint)
//
//
//                    }
//                                }
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
    // Segue prep
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "attendeesIdentifier"){
            let targetController = segue.destinationViewController as! FriendsAttendingTableViewController
            targetController.eventid = currentEventid
            targetController.currentInvitedUsers = self.currentInvitedUsers
        }
    }
}
