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
    var attendees = []
    var currentInvitedUsers :[String] = []
    
    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
  
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
