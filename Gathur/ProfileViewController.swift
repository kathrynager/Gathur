//
//  ProfileViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/12/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProfileViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userGathurings: UITableView!
    
    var user  = Profile()
    var userAuth = ""
    var profList : [Profile] = []
    var username = ""
    
    // Parsed JSON arrays
    var currentEventLoc = [String]()
    var currentEventEndTime:[String] = []
    var currentEventid = [Int]()
    //    var currentEventCreatedTime:[String] = []
    var currentEventTitle:[String] = []
    var currentEventStartTime:[String] = []
    //    var currentEventUpdatedTime:[String] = []
    var currentEventDes:[String] = []
    
    var currentUserId:[String] = []
    
    
    var userID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = username
        profilePic.image = UIImage(named:"DefaultPic.jpg")
        
        // Get user's gathurings
       let authToken = NSUserDefaults.standardUserDefaults().stringForKey("token")!
        let headers = ["Authorization ": "Token " + authToken]

        var i = 0;
        
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/events", parameters:["user_id": userID], headers: headers)
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
                   // self.currentUserId = [String](count: JSON.count, repeatedValue: "")

                    // currentEventCreatedTime = [String](count: JSON.count, repeatedValue: "")
                    //  currentEventUpdatedTime = [String](count: JSON.count, repeatedValue: "")
                    
                    for(i = 0; i < JSON.count;i++){
                        let item = JSON[i]
                        
                        self.currentEventid[i] = item["id"] as! Int
                        self.currentEventStartTime[i] = item["start_time"] as! String
                        self.currentEventEndTime[i] = item["end_time"] as! String
                        self.currentEventTitle[i] = item["title"] as! String
                        self.currentEventDes[i] = item["description"] as! String
                        self.currentEventLoc[i] = item["location"] as! String
                       /// self.currentUserId[i] = item["user_id"] as! String
                        //  currentEventCreatedTime[i] = item["created_at"] as! String
                        //  currentEventUpdatedTime[i] = item["updated_at"] as! String
                    }
                    self.userGathurings.reloadData()

                }
                for(i = 0; i < self.currentEventid.count; i++){
                    print("This is the \(i) th event")
                    print(self.currentEventid[i])
                    print(self.currentEventStartTime[i])
                    print(self.currentEventEndTime[i])
                    print(self.currentEventTitle[i])
                    print(self.currentEventDes[i])
                    print(self.currentEventLoc[i])
                    //print(currentEventCreatedTime[i])
                    //print(currentEventUpdatedTime[i])
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentEventTitle.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userGathurCells", forIndexPath: indexPath) as! UserGathuringsTableViewCell
        print(currentEventTitle[indexPath.row])
        cell.gathuring.text = currentEventTitle[indexPath.row]

        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailsIdentifier"){
            if let indexPath = self.userGathurings.indexPathForSelectedRow{
                let targetController = segue.destinationViewController as! GathurDetailsViewController
                targetController.currentEventTitle = currentEventTitle[indexPath.row]
                targetController.currentEventLoc = currentEventLoc[indexPath.row]
                targetController.currentEventEndTime = currentEventEndTime[indexPath.row]
                targetController.currentEventid = currentEventid[indexPath.row]
               // targetController.currentEventCreatedTime = currentEventCreatedTime[indexPath.row]
                targetController.currentEventStartTime = currentEventStartTime[indexPath.row]
               // targetController.currentEventUserId = currentEventUserId[indexPath.row]
               // targetController.currentEventUpdatedTime = currentEventUpdatedTime[indexPath.row]
                targetController.currentEventDes = currentEventDes[indexPath.row]
                       }
    }
    }
}
