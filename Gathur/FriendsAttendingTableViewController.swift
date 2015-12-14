//
//  FriendsAttendingTableViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 12/11/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FriendsAttendingTableViewController: UITableViewController {
    
    var eventid = 0
    var currentInvitedUsers :[String] = []
    var currUser = ""
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let token = NSUserDefaults.standardUserDefaults().stringForKey("token")!
        

        let headers = ["Authorization ": "Token " + token]
        
        // Get all friends attending
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/invitations/event",
            parameters: ["event_id":self.eventid], headers: headers) .responseJSON
            { response in debugPrint(response)
                if let JSON = response.result.value {
                    for(var i = 0; i < JSON.count; i++){
                        let item = JSON[i]
                        // Add users to array
                        self.currentInvitedUsers.append(item["display_name"] as! String)
                    }
                    self.table.reloadData()
                }
        }
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
        return currentInvitedUsers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendsIdentifier", forIndexPath: indexPath) as! FriendsListTableViewCell
        cell.name.text = currentInvitedUsers[indexPath.row]
        cell.profPic.image = UIImage(named: "DefaultPic")
        return cell
    }
    
}
