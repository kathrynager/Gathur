//
//  NewGathurViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/15/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class NewGathurViewController: UIViewController {
    
    var newGathur = GathurObj()
    
    @IBOutlet weak var gathurTitle: UITextField!
    @IBOutlet weak var gathurDescription: UITextField!
    @IBOutlet weak var friends: UITextField!
    @IBOutlet weak var location: UITextField!
    
    @IBAction func post(segue:UIStoryboardSegue) {
        
        
//        if((gathurTitle.text?.isEmpty) != nil){
//            let myColor : UIColor = UIColor( red: 1, green: 0, blue:0, alpha: 1.0 )
//            gathurTitle.layer.borderWidth = 2
//            gathurTitle.layer.borderColor = myColor.CGColor
//            return
//            
//        }
//        else{
        navigationController?.popViewControllerAnimated(true)
        let view : GathuringTableView = self.navigationController?.topViewController as! GathuringTableView
        
        newGathur.title = gathurTitle.text!
        newGathur.location = location.text!
        //newGathur?.friends = friends.text!
        newGathur.description = gathurDescription.text!
        view.gathurList.append(newGathur)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            view.table.reloadData()
        })
        self.navigationController!.popViewControllerAnimated(true)
     //   }
    }
}