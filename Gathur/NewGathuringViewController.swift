//
//  NewGathuring.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/6/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class NewGathuringViewController : UIViewController {

    var newGathuring : GathurObj?
    
    @IBOutlet weak var gathurDescription: UITextField!
    @IBOutlet weak var friends: UITextField!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var gathurName: UITextField!
    
    @IBAction func cancel(sender: AnyObject) {
        let view : GathuringViewController = self.presentingViewController as! GathuringViewController
            newGathuring?.title = gathurName.text!
        //Check for location
        if(location.text != nil){
            newGathuring?.location = location.text!
        }
        //How should friends be saved? In a list? Do we search current friends like FB does to add them to the list?
        
        //How to save user info when logged in ?
       // newGathuring?.username =
        
        newGathuring?.description = gathurDescription.text!
        
            view.gathurList?.append(newGathuring!)
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
        })
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    
    @IBAction func post(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

