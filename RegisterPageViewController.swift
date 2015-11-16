//
//  RegisterPageViewController.swift
//  Gathur
//
//  Created by Jiqing Xu on 11/15/15.
//  Copyright © 2015 Jiqing Xu. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {
    
    
    @IBOutlet weak var lastnameText: UITextField!
    
    @IBOutlet weak var fristnameText: UITextField!

    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
  
    @IBAction func RegisterButton(sender: AnyObject) {
        let lastname = lastnameText.text
        let fristname = fristnameText.text
        let username = usernameText.text
        let emailaddress = emailText.text
        let password = passwordText.text
        
        if(lastname!.isEmpty || fristname!.isEmpty || username!.isEmpty || emailaddress!.isEmpty || password!.isEmpty)
            
        {
            //dispaly alert message
            
            displayAlertMessage("All fields are required")
            return
            
        }
        
        //Store data
        NSUserDefaults.standardUserDefaults().setObject(username, forKey: "username")
        NSUserDefaults.standardUserDefaults().setObject(lastname, forKey: "lastname")
        NSUserDefaults.standardUserDefaults().setObject(fristname, forKey: "fristname")
        NSUserDefaults.standardUserDefaults().setObject(emailaddress, forKey: "emailaddress")
        NSUserDefaults.standardUserDefaults().setObject(password, forKey: "password")
        
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        
        //Display alert message with confirmation.
        
        let myAlert = UIAlertController(title: "Congratulations", message:"Registration is successful.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default){ action in
            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated:true, completion:nil)
    }
    
    func displayAlertMessage(userMessage:String)
    {
        let myAlert = UIAlertController(title: "Alert", message:userMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        myAlert.addAction(okAction)
        
        self.presentViewController(myAlert, animated:true, completion:nil)

    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
