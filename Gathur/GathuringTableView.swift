//
//  Gathurings.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/12/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class GathuringTableView: UITableViewController {
    
    //until database implemented list of events
    var gathurList : [GathurObj] = []
    //
    //    let test = {
    //        var profOne = Profile( firstName: "Kathryn", lastName: "Ager", username: "kmager", description: "HELLO" , location: "Madison", password: "mypass")
    //    var one = GathurObj(title: "FUN", profile: profOne)
    //
    //    }
    // test()
    
    
    @IBAction func newGathuring(sender: AnyObject) {
    }
    
    @IBOutlet var table: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        if(gathurList.isEmpty){
            let profOne = Profile( firstName: "Kathryn", lastName: "Ager", username: "kmager", description: "HELLO" , location: "Madison", password: "mypass", profilePic: UIImage(named: "Cat.jpg")!)
            let profTwo = Profile(firstName: "Person", lastName: "Two", username: "two", description: "Student" , location: "Madison", password: "mypass", profilePic: UIImage(named: "Cat.jpg")!)
            let profThree = Profile(firstName: "Harry", lastName: "Potter", username: "HPott", description: "School of Wizardry" , location: "Hogwarts", password: "mypass", profilePic: UIImage(named: "Cat.jpg")!)
            let profFour = Profile(firstName: "Voldemort", lastName: "Riddle", username: "Tom", description: "" , location: "", password: "mypass",profilePic: UIImage(named: "Cat.jpg")!)
            
            
            let one = GathurObj(title: "FUN", profile: profOne)
            let two = GathurObj(title: "Study Group", profile: profTwo, location: "Madison", description: "So fun")
            let three = GathurObj(title: "Quiditch", profile: profThree, location: "Hogwarts", description: "Watch")
            let four = GathurObj(title: "Death Eaters party", profile: profFour, location: "Voldemorts House", description: "Fun")
            gathurList.append(one)
            gathurList.append(two)
            gathurList.append(three)
            gathurList.append(four)
        }
        else{
            table.reloadData()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
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
        return gathurList.count
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("gathurCell", forIndexPath: indexPath) as! TableViewCell
        
        // Configure the cell...
        cell.gathurTitle.text = gathurList[indexPath.row].title
        cell.profilePic.image = gathurList[indexPath.row].profile?.profilePic
        cell.username.text = gathurList[indexPath.row].profile?.username
        
        return cell
    }
    
//    var tapGesture = UITapGestureRecognizer(target: s, action: "tapRecognizer")
//    self.view.addGestureRecognizer(tapGesture)
//    
//    func tapRecognizer(){
//        
//    }
    
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
        if(segue.identifier == "profileView"){
                if let indexPath = self.table.indexPathForSelectedRow{
                let selectedEvent = gathurList[indexPath.row]
            let targetController = segue.destinationViewController as! ProfileViewController
                targetController.user = selectedEvent.profile!
                targetController.name.text = (selectedEvent.profile?.firstName)! + " " + (selectedEvent.profile?.lastName)!
                targetController.userDescription.text = selectedEvent.profile?.description
                targetController.location.text = selectedEvent.profile?.location
            }
        }
        else if(segue.identifier == "details"){
            if let indexPath = self.table.indexPathForSelectedRow{
                let selectedEvent = gathurList[indexPath.row]
                let targetController = segue.destinationViewController as! GathurDetailsViewController
                
                if(selectedEvent.description != nil){
                targetController.gathurDescriptionS = selectedEvent.description!
                }
                targetController.gathurTitleS = selectedEvent.title!
            }
        }
    }
}