//
//  GathurObj.swift
//  Gathur
//
//  Created by Kathryn Ager on 11/12/15.
//  Copyright © 2015 Kathryn Ager. All rights reserved.
//

import Foundation

struct GathurObj {
    var title : String?
    var friends : [Profile]
    var location : String?
    var description : String?
    var profile : Profile?
    var userID : Int?
    var startDate : NSDate?
    var endDate : NSDate?
    var comments : [String]
    
    init(){
        comments = []
        friends = []
    }
    
    init(title : String, profile : Profile){
        self.title = title
        self.profile = profile
        self.startDate = NSDate()
        self.endDate = NSDate()
        friends = []
        comments = []

    }
    init(title : String, profile : Profile, location : String, description : String){
        self.title = title
        self.profile = profile
        self.location = location
        self.description = description
        self.startDate = NSDate()
        self.endDate = NSDate()
        friends = []
        comments = []

    }
    
    
}

