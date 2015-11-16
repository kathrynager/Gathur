//
//  NewGathurViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/15/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class NewGathurViewController: UIViewController {
    
    var newGathur : GathurObj?
    
    @IBOutlet weak var gathurTitle: UITextField!
    @IBAction func post(sender: AnyObject) {
        
        newGathur?.title = gathurTitle.text!
        newGathur?.location = location.text!
//        newGathur?.friends = friends.text!
        
        
        newGathur?.description = gathurDescription.text!
        
        
        let view : GathuringTableView = self.presentingViewController as! GathuringTableView
        view.gathurList?.append(newGathur!)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
           // view.table.reloadData()
        })
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBOutlet weak var gathurDescription: UITextField!
    @IBOutlet weak var friends: UITextField!
    @IBOutlet weak var location: UITextField!

    
    
}
