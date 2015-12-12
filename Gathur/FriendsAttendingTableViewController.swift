//
//  FriendsAttendingTableViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 12/11/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class FriendsAttendingTableViewController: UITableViewController {
   
    var gathurObj = GathurObj()
    
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
        return gathurObj.friends.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("friendsIdentifier", forIndexPath: indexPath) as! FriendsListTableViewCell
        print(gathurObj.title)
        cell.name.text = gathurObj.friends[indexPath.row].firstName! + " " + gathurObj.friends[indexPath.row].lastName!
        cell.profPic.image = gathurObj.friends[indexPath.row].profilePic
        return cell
    }

}
