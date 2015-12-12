//
//  NewGathurViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/15/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit
import Alamofire

class NewGathurViewController: UIViewController {
    
    var newGathur = GathurObj()
    var currUser = Profile()

    @IBOutlet weak var gathurTitle: UITextField!
    @IBOutlet weak var gathurDescription: UITextField!
    @IBOutlet weak var friends: UITextField!
    @IBOutlet weak var location: UITextField!
    
    @IBAction func post(segue:UIStoryboardSegue) {

        navigationController?.popViewControllerAnimated(true)
        let view : GathuringTableView = self.navigationController?.topViewController as! GathuringTableView
        
        newGathur.title = gathurTitle.text!
        newGathur.location = location.text!
//        newGathur.friends.append(currUser)
        
        newGathur.description = gathurDescription.text!
        newGathur.profile = currUser
        print(currUser.firstName)
        
//        let useremail = NSUserDefaults.standardUserDefaults().stringForKey("username")! + "@wisc.edu"
//        let userps = NSUserDefaults.standardUserDefaults().stringForKey("password")!
        
        let eventtitle = gathurTitle.text
        let eventloc = location.text!
        let eventstarttime = "2015-12-12T03:09:28.974Z"
        let eventendtime = "2015-12-12T03:09:58.974Z"
        let eventdes = gathurDescription.text!
        let usertoken = "59f7513b635c46679322e0c1fcfe7963"
        let headers = ["Authorization ": "Token " + usertoken]
        
        Alamofire.request(.POST, "https://gathur.herokuapp.com/api/events",
            
            parameters:["title": eventtitle!, "location": eventloc, "start_time":eventstarttime, "end_time":eventendtime,
                
                "description":eventdes], headers: headers).responseJSON
            
            { response in debugPrint(response)
                if let JSON = response.result.value {
                
                print("JSON: \(JSON)")
                
                }
                
        }
        currUser.gathurList.append(newGathur)
        view.gathurList.append(newGathur)
        view.currUser = currUser
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            view.table.reloadData()
        })
        self.navigationController!.popViewControllerAnimated(true)
    }
}