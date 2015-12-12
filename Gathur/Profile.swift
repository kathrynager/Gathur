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
    var friendsList : [Profile]?
    var gathurList : [GathurObj]
    var eventsAttending : [GathurObj]

    init(){
        self.profilePic = UIImage(named: "DefaultPic")
        self.gathurList = []
        self.friendsList = []
        self.eventsAttending = []
    }
    init(firstName : String, lastName : String, username : String, password : String){
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
        self.profilePic = UIImage(named: "DefaultPic")
        self.gathurList = []
        self.friendsList = []
        self.eventsAttending = []

    }
    init(firstName : String, lastName : String, username : String, description : String, location : String, password : String){
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.description = description
        self.location = location
        self.password = password
        self.profilePic = UIImage(named: "DefaultPic")
        self.gathurList = []
        self.friendsList = []
        self.eventsAttending = []

    }
    init(firstName : String, lastName : String, username : String, description : String, location : String, password : String, profilePic : UIImage){
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.description = description
        self.location = location
        self.password = password
        self.profilePic = profilePic
        self.gathurList = []
        self.friendsList = []
        self.eventsAttending = []

    }
    init(firstName : String, lastName : String, username : String, description : String, location : String, password : String, profilePic : UIImage, friendsList : [Profile], gathurList : [GathurObj]){
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.description = description
        self.location = location
        self.password = password
        self.profilePic = profilePic
        self.friendsList = friendsList
        self.gathurList = gathurList
        self.eventsAttending = []

    }

}

