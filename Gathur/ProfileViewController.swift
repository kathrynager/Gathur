//
//  ProfileViewController.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/12/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var userGathurings: UITableView!
    
    var user  = Profile()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        
        name.text = user.firstName! + user.lastName!
        userDescription.text = user.description!
        location.text = user.location!
        profilePic.image = UIImage(named:"Cat.jpg")
        
        //load user gathurings
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
