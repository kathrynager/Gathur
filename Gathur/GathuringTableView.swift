//
//  Gathurings.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/12/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class GathuringTableView: UITableViewController {
    
    var currUser = ""
    var currentEventLoc = [String]()
    var currentEventEndTime:[String] = []
    var currentEventPub = NSObject()
    var currentEventid = [Int]()
    var currentEventCreatedTime:[String] = []
    var currentEventTitle:[String] = []
    var currentEventStartTime:[String] = []
    var currentEventUserId:[String] = []
    var currentEventUpdatedTime:[String] = []
    var currentEventDes:[String] = []
    var currentEventRealUserId:[Int] = []
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)

        var i = 0;
        var j = 0;
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/events/all")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {

                    self.currentEventid = [Int](count: JSON.count, repeatedValue: 0)
                    self.currentEventStartTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventEndTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventTitle = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventDes = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventLoc = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventUserId = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventCreatedTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventUpdatedTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventRealUserId = [Int](count: JSON.count, repeatedValue: 0)
                    
                    for(i = 0; i < JSON.count;i++){
                        let item = JSON[i]
                        
                        self.currentEventid[i] = item["id"] as! Int
                        self.currentEventStartTime[i] = item["start_time"] as! String
                        self.currentEventEndTime[i] = item["end_time"] as! String
                        self.currentEventTitle[i] = item["title"] as! String
                        self.currentEventDes[i] = item["description"] as! String
                        self.currentEventLoc[i] = item["start_time"] as! String
                        self.currentEventUserId[i] = item["creator_name"] as! String
                        self.currentEventCreatedTime[i] = item["created_at"] as! String
                        self.currentEventUpdatedTime[i] = item["updated_at"] as! String
                        self.currentEventRealUserId[i] = item["user_id"] as! Int
                    }
                }
                self.table.reloadData()
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        table.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currentEventTitle.count
        
    }
    
    var index = 0
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gathurCell", forIndexPath: indexPath) as! TableViewCell
        cell.profilePic.tag = indexPath.row;
        
        
        cell.profilePic.userInteractionEnabled = true
        let tapped:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "TappedOnImage:")
        tapped.numberOfTapsRequired = 1
        cell.profilePic.addGestureRecognizer(tapped)
        
        // Configure the cell...
        cell.gathurTitle.text = currentEventTitle[indexPath.row]
        cell.profilePic.image = UIImage(named: "DefaultPic")
        cell.username.text = currentEventUserId[indexPath.row]

        return cell
    }
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        var i = 0;
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/events/all")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    //                    print("JSON: \(JSON)")
                    //                    print(JSON.count)
                    self.currentEventid = [Int](count: JSON.count, repeatedValue: 0)
                    self.currentEventStartTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventEndTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventTitle = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventDes = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventLoc = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventUserId = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventCreatedTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventUpdatedTime = [String](count: JSON.count, repeatedValue: "")
                    self.currentEventRealUserId = [Int](count: JSON.count, repeatedValue: 0)
                    
                    for(i = 0; i < JSON.count;i++){
                        let item = JSON[i]
                        
                        self.currentEventid[i] = item["id"] as! Int
                        self.currentEventStartTime[i] = item["start_time"] as! String
                        self.currentEventEndTime[i] = item["end_time"] as! String
                        self.currentEventTitle[i] = item["title"] as! String
                        self.currentEventDes[i] = item["description"] as! String
                        self.currentEventLoc[i] = item["start_time"] as! String
                        self.currentEventUserId[i] = item["creator_name"] as! String
                        self.currentEventCreatedTime[i] = item["created_at"] as! String
                        self.currentEventUpdatedTime[i] = item["updated_at"] as! String
                        self.currentEventRealUserId[i] = item["user_id"] as! Int

                        // self.currentEventPub = item["public"] as! NSObject
                    }
                }
        }
        
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func TappedOnImage(sender:UITapGestureRecognizer){
        print(sender.view?.tag)
        index = (sender.view?.tag)!
        let authToken = NSUserDefaults.standardUserDefaults().stringForKey("token")!
        let headers = ["Authorization ": "Token " + authToken]
        var currentuserfn = ""
        var currentuserls = ""
        var currentuseremail = ""
        var currentuserphone = ""
        
        
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/users/me", headers: headers)
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    currentuserfn = JSON["first_name"] as! String
                    currentuserls  = JSON["last_name"] as! String
                    currentuseremail = JSON["email"] as! String
                    currentuserphone = JSON["phone"] as! String
                    
                    print("This is me")
                    print(currentuserfn)
                    print(currentuserls)
                    print(currentuseremail)
                    print(currentuserphone)
                }
                if(self.currentEventUserId[self.index] == (currentuserfn + " " + currentuserls)){
                    self.currUser = currentuserfn + " " + currentuserls
                    self.performSegueWithIdentifier("userProfileIdentifier", sender: self)
                }
                else{
                    self.performSegueWithIdentifier("profileSegue", sender: self)
                }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    
    //MARK: - Navigation
    //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //Get the new view controller using segue.destinationViewController.
        //Pass the selected object to the new view controller.
        if(segue.identifier == "profileSegue"){
            let indexPath = index
            let targetController = segue.destinationViewController as! ProfileViewController
            targetController.username = currentEventUserId[indexPath]
            targetController.userID = currentEventRealUserId[indexPath]
            
        }
        else if(segue.identifier == "userProfileIdentifier"){
            let indexPath = index
            let targetController = segue.destinationViewController as! UserProfileVC
            targetController.userID = currentEventRealUserId[indexPath]
            targetController.currUser = self.currUser
        
        }
        else if(segue.identifier == "details"){
            if let indexPath = self.table.indexPathForSelectedRow{
                let targetController = segue.destinationViewController as! GathurDetailsViewController
                targetController.currentEventTitle = currentEventTitle[indexPath.row]
                targetController.currentEventLoc = currentEventLoc[indexPath.row]
                targetController.currentEventEndTime = currentEventEndTime[indexPath.row]
                targetController.currentEventid = currentEventid[indexPath.row]
                targetController.currentEventCreatedTime = currentEventCreatedTime[indexPath.row]
                targetController.currentEventStartTime = currentEventStartTime[indexPath.row]
                targetController.currentEventUserId = currentEventUserId[indexPath.row]
                targetController.currentEventUpdatedTime = currentEventUpdatedTime[indexPath.row]
                targetController.currentEventDes = currentEventDes[indexPath.row]
                targetController.currUser = self.currUser
            }
        }
        else if(segue.identifier == "signOutIdentifier"){
            if let navController = self.navigationController {
                navigationController?.popViewControllerAnimated(true)
                navController.popViewControllerAnimated(true)
            }
        }
        else if(segue.identifier == "newGathuringVC"){
            let targetController = segue.destinationViewController as! NewGathurViewController
        }
    }
}