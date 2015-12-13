//
//  UserProfileVC.swift
//  Gathur
//
//  Created by Kathryn Ager on 12/13/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UserProfileVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBOutlet weak var attendingTable: UITableView!
    
    @IBOutlet weak var gathurPostsTable: UITableView!
    
}
