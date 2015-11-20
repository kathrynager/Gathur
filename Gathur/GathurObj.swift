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
    var friends : [String]?
    var location : String?
    var description : String?
    var likes : Int?
    var profile : Profile?
    var date : NSDate?
    
//    let dateFormatter = NSDateFormatter().dateFormat.
    
    init(){
        
    }
    
    init(title : String, profile : Profile){
        self.title = title
        self.profile = profile
        self.likes = 0
        self.date = NSDate()
    }
    init(title : String, profile : Profile, location : String, description : String){
        self.title = title
        self.profile = profile
        self.location = location
        self.description = description
        self.likes = 0
        self.date = NSDate()
    }
    
    
}

