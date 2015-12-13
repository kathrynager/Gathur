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
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userGathurings: UITableView!
    
    var user  = Profile()
    var userAuth = ""
    var profList : [Profile] = []
    var currUser = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    
        name.text = user.firstName! + " " + user.lastName!
        userDescription.text = user.description!
        location.text = user.location!
        profilePic.image = UIImage(named:"DefaultPic.jpg")
        
        // Get user's gathurings
       let authToken = NSUserDefaults.standardUserDefaults().stringForKey("token")!
        let headers = ["Authorization ": "Token " + authToken]
        
        Alamofire.request(.GET, "https://gathur.herokuapp.com/api/events", headers: headers).responseJSON
            
            { response in debugPrint(response)
                if  response.result.isSuccess {
                    let json = response.result.value
                    print("JSON: \(json)")
//                    for (_,_):(String, JSON) in json {
//                        //Do something you want
//                    }
                }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return user.gathurList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userGathurCells", forIndexPath: indexPath) as! UserGathuringsTableViewCell
        
        cell.gathuring.text = user.gathurList[indexPath.row].title
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailsIdentifier"){
            if let indexPath = self.userGathurings.indexPathForSelectedRow{
                let selectedEvent = user.gathurList[indexPath.row]
                let targetController = segue.destinationViewController as! GathurDetailsViewController
                       }
    }
    }
}
