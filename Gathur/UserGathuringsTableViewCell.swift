//
//  UserGathuringsTableViewCell.swift
//  Gathur
//
//  Created by Kathryn Ager on 12/9/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class UserGathuringsTableViewCell: UITableViewCell {

    var currUser = Profile()
    var gathurObj = GathurObj()
    
    @IBOutlet weak var attendTitle: UIButton!
    @IBOutlet weak var gathuring: UILabel!
    @IBAction func attend(sender: AnyObject) {
        if(gathurObj.friends.isEmpty){
            gathurObj.friends.append(currUser)
            attendTitle.setTitle("Unattend", forState: .Normal)
        }
        else{
            var alreadyAttending = false
            for i in 0..<gathurObj.friends.count {
                if(gathurObj.friends[i].username == currUser.username){
                    gathurObj.friends.removeAtIndex(i)
                    alreadyAttending = true
                    attendTitle.setTitle("Attend", forState: .Normal)
                }
            }
            if(alreadyAttending == false){
                gathurObj.friends.append(currUser)
                attendTitle.setTitle("Unattend", forState: .Normal)
            } else{
                for i in 0..<currUser.eventsAttending.count{
                    if currUser.eventsAttending[i].title == gathurObj.title{
                        currUser.eventsAttending.removeAtIndex(i)
                    }
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
   }
