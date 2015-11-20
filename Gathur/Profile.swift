//
//  Profile.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/12/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import Foundation
import UIKit

struct Profile {
    var firstName : String?
    var lastName : String?
    var username : String?
    var description : String?
    var location : String?
    var password : String?
    var profilePic : UIImage?

    init(){
        
    }
    init(firstName : String, lastName : String, username : String, description : String, location : String, password : String, profilePic : UIImage){
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.description = description
        self.location = location
        self.password = password
        self.profilePic = profilePic
    }
}

