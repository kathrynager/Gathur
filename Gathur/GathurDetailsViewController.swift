//
//  GathurDetailsViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/19/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class GathurDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var gathurObj = GathurObj()
    var currUser = Profile()
    
    @IBAction func back(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
        let view : GathuringTableView = self.navigationController?.topViewController as! GathuringTableView
        for i in 0..<view.gathurList.count{
            if view.gathurList[i].title == gathurObj.title{
                view.gathurList[i] = gathurObj
            }
        }
    }
    
    @IBOutlet weak var attendees: UIButton!
    @IBOutlet weak var comment: UITextField!
    @IBAction func post(sender: AnyObject) {
        if(comment.text != nil){
            gathurObj.comments.append(comment.text!)
            
            commentsTable.reloadData()
            comment.text?.removeAll()
        }
        
    }
    // Add user to attending list and change attend button between unattend & attend
    @IBAction func attend(sender: AnyObject) {
        if(gathurObj.friends.isEmpty){
            gathurObj.friends.append(currUser)
             attendButtonTitle.setTitle("Unattend", forState: .Normal)
            currUser.eventsAttending.append(gathurObj)
        }
        else{
            var alreadyAttending = false
            for i in 0..<gathurObj.friends.count {
                if(gathurObj.friends[i].username == currUser.username){
                    gathurObj.friends.removeAtIndex(i)
                    alreadyAttending = true
                     attendButtonTitle.setTitle("Attend", forState: .Normal)
                    
                }
            }
            if(alreadyAttending == false){
                gathurObj.friends.append(currUser)
                attendButtonTitle.setTitle("Unattend", forState: .Normal)
                currUser.eventsAttending.append(gathurObj)

            }
            else{
                for i in 0..<currUser.eventsAttending.count{
                    if currUser.eventsAttending[i].title == gathurObj.title{
                        currUser.eventsAttending.removeAtIndex(i)
                    }
                }
            }
        }
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
        print(currUser.firstName)
        print(gathurObj.title)
        commentsTable.delegate = self
        commentsTable.dataSource = self
        
        gathurTitle.text = gathurObj.title
        gathurDescription.text = gathurObj.description
        profilePic.image = gathurObj.profile?.profilePic
        nameGathurProfile.text = (gathurObj.profile?.firstName)! + " " + (gathurObj.profile?.lastName)!
       
        // Adjust title for Attendee(s)
        if(gathurObj.friends.count == 1){
            attendees.setTitle("\(gathurObj.friends.count) Attendee", forState: .Normal)

        }
        else{
            attendees.setTitle("\(gathurObj.friends.count) Attendees", forState: .Normal)
        }
        
        // Adjust button title unattend or attend
        var alreadyAttending = false
        for i in 0..<gathurObj.friends.count {
            if(gathurObj.friends[i].username == currUser.username){
                alreadyAttending = true
                attendButtonTitle.setTitle("Unattend", forState: .Normal)
            }
        }
        if(alreadyAttending == false){
            attendButtonTitle.setTitle("Attend", forState: .Normal)
 
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
        if((gathurObj.comments.isEmpty)){
            return 0
        }
        else{
            return gathurObj.comments.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("commentIdentifier", forIndexPath: indexPath) as! CommentsTableViewCell
        cell.comment.text = gathurObj.comments[indexPath.row]
        return cell
        
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "attendeesIdentifier"){
            let targetController = segue.destinationViewController as! FriendsAttendingTableViewController
            targetController.gathurObj = gathurObj
        }
    }
}
