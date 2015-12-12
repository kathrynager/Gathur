//
//  TableViewCell.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/12/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var gathurObj = GathurObj()
    var currUser = Profile()
    
//    @IBOutlet weak var attendTitle: UIButton!
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet weak var gathurTitle: UILabel!
    @IBOutlet weak var username: UILabel!
       var profile: Profile?
//    @IBAction func attend(sender: AnyObject) {
//        if(gathurObj.friends.isEmpty){
//            gathurObj.friends.append(currUser)
//            attendTitle.setTitle("Unattend", forState: .Normal)
//        }
//        else{
//            var alreadyAttending = false
//            for i in 0..<gathurObj.friends.count {
//                if(gathurObj.friends[i].username == currUser.username){
//                    gathurObj.friends.removeAtIndex(i)
//                    alreadyAttending = true
//                    attendTitle.setTitle("Attend", forState: .Normal)
//                }
//            }
//            if(alreadyAttending == false){
//                gathurObj.friends.append(currUser)
//                attendTitle.setTitle("Unattend", forState: .Normal)
//            } else{
//                for i in 0..<currUser.eventsAttending.count{
//                    if currUser.eventsAttending[i].title == gathurObj.title{
//                        currUser.eventsAttending.removeAtIndex(i)
//                    }
//                }
//            }
//        }
//    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
