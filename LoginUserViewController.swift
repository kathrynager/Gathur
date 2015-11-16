//
//  LoginUserViewController.swift
//  Gathur
//
//  Created by Jiqing Xu on 11/15/15.
//  Copyright © 2015 Jiqing Xu. All rights reserved.
//

import UIKit

class LoginUserViewController: UIViewController {

    @IBOutlet weak var usernameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
  
    @IBAction func LoginButton(sender: AnyObject) {
        let username = usernameText.text
        let password = passwordText.text
        
        
        let usernameStored = NSUserDefaults.standardUserDefaults().stringForKey("username")
        let passwordStored = NSUserDefaults.standardUserDefaults().stringForKey("password")
        
        if(usernameStored == username)
        {
            if(passwordStored == password){
                //login is successful
                
                
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedin")
                NSUserDefaults.standardUserDefaults().synchronize()
                
                
                
                self.dismissViewControllerAnimated(true, completion: nil)
                
                
             
            

                
                let myAlert = UIAlertController(title: "Congratulations", message:"Welcome back to Gathur!", preferredStyle: UIAlertControllerStyle.Alert)
                
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
                    self.dismissViewControllerAnimated(true, completion: nil)
                    
                }
                
                myAlert.addAction(okAction)
                
                self.presentViewController(myAlert, animated:true, completion:nil)
                
                
                
                
            }

        }
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}