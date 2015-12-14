//
//  UserProfileVC.swift
//  Gathur
//
//  Created by Kathryn Ager on 12/13/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserProfileVC: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var attendingTable: UITableView!
    @IBOutlet weak var gathurPostsTable: UITableView!
    
    var userID = 0
    var currUser = ""
    
    // Parsed JSON arrays
    var currentEventLoc = [String]()
    var currentEventEndTime:[String] = []
    var currentEventid = [Int]()
    var currentEventTitle:[String] = []
    var currentEventStartTime:[String] = []
    var currentEventDes:[String] = []
    var currentUserId:[String] = []
    
    var attendLoc = [String]()
    var attendEndTime:[String] = []
    var attendid = [Int]()
    var attendTitle:[String] = []
    var attendStartTime:[String] = []
    var attendDes:[String] = []
    var attendUserId:[String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        nameLabel.text = currUser
        profilePic.image = UIImage(named: "DefaultPic")
        
        // Get user's postings
        let authToken = NSUserDefaults.standardUserDefaults().stringForKey("token")!
        let headers = ["Authorization ": "Token " + authToken]
        var i = 0;
        
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/events", parameters:["user_id": self.userID], headers: headers)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    //print("JSON: \(JSON)")
                    
                    self.currentEventid = [Int](count: JSON.count, repeatedValue: 0)
                    self.currentEventStartTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventEndTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventTitle = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventDes = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventLoc = [String](count: JSON.count, repeatedValue: "")
                    
                    for(i = 0; i < JSON.count;i++){
                        let item = JSON[i]
                        
                        self.currentEventid[i] = item["id"] as! Int
                        self.currentEventStartTime[i] = item["start_time"] as! String
                        self.currentEventEndTime[i] = item["end_time"] as! String
                        self.currentEventTitle[i] = item["title"] as! String
                        self.currentEventDes[i] = item["description"] as! String
                        self.currentEventLoc[i] = item["location"] as! String
                        self.currentUserId.append(item["creator_name"] as! String)
                    }
                    self.attendingTable.reloadData()
                    self.gathurPostsTable.reloadData()
                }
        }
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/invitations/accepted",  headers: headers)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    
                    for(i = 0; i < JSON.count;i++){
                        let item = JSON[i]
                        
                        self.attendUserId.append(item["creator_name"] as! String)
                        self.attendStartTime.append(item["start_time"] as! String)
                        self.attendEndTime.append(item["end_time"] as! String)
                        self.attendTitle.append(item["title"] as! String)
                        self.attendDes.append(item["description"] as! String)
                        self.attendLoc.append(item["location"] as! String)
                        self.attendid.append(item["id"] as! Int)
                        
                    }
                    self.attendingTable.reloadData()
                }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == attendingTable{
            return attendTitle.count
        }
        else{
            return currentEventTitle.count // my posts
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if (tableView == attendingTable){
            let cell = tableView.dequeueReusableCellWithIdentifier("rsvpCell", forIndexPath: indexPath) as! RsvpCell
            cell.profPic.image = UIImage(named: "DefaultPic")
            cell.titleLabel.text = attendTitle[indexPath.row]
            cell.usernameLabel.text = attendUserId[indexPath.row]
            return cell
            
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("gathurPostCell", forIndexPath: indexPath) as! UserGathurCell
            cell.titleLabel.text = currentEventTitle[indexPath.row]
            cell.profPic.image = UIImage(named: "DefaultPic")
            return cell
            
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    //Segue prep
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "myPostDetails"){
            if let indexPath = self.gathurPostsTable.indexPathForSelectedRow{
                let targetController = segue.destinationViewController as! GathurDetailsViewController
                targetController.currentEventTitle = currentEventTitle[indexPath.row]
                targetController.currentEventLoc = currentEventLoc[indexPath.row]
                targetController.currentEventEndTime = currentEventEndTime[indexPath.row]
                targetController.currentEventid = currentEventid[indexPath.row]
                targetController.currentEventStartTime = currentEventStartTime[indexPath.row]
                targetController.currentEventDes = currentEventDes[indexPath.row]
                targetController.currentEventUserId = currentUserId[indexPath.row]
                targetController.currUser = currUser

            }
        }
        else{
            if let indexPath = self.attendingTable.indexPathForSelectedRow{
                let targetController = segue.destinationViewController as! GathurDetailsViewController
                targetController.currentEventStartTime = attendStartTime[indexPath.row]
                targetController.currentEventTitle = attendTitle[indexPath.row]
                targetController.currentEventLoc = attendLoc[indexPath.row]
                targetController.currentEventEndTime = attendEndTime[indexPath.row]
                targetController.currentEventUserId = attendUserId[indexPath.row]
                targetController.currentEventDes = attendDes[indexPath.row]
                targetController.currentEventid = attendid[indexPath.row]
                targetController.currUser = currUser
            }
        }
    }
}
