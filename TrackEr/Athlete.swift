//
//  Athlete.swift
//  TrackEr
//
//  Created by Ashwin Aggarwal on 3/12/17.
//  Copyright © 2017 Ashwin Aggarwal. All rights reserved.
//

import UIKit

/*
 * This class represents an athlete with a name, grade, id, phone number, and a bio. This class is required to have coder and decoder initialization methods since it needs to be stored in NSKeyedArchiver. T
 */


class Athlete : NSObject, NSCoding {
    var name : String
    var grade : Int
    var id : Int
    var phone : Int
    var bio : String
    
    required init(name : String, grade : Int, id : Int, phone : Int, bio : String) {
        self.name = name
        self.grade = grade
        self.id = id
        self.phone = phone
        self.bio = bio
    }
    
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.grade = decoder.decodeInteger(forKey: "grade")
        self.id = decoder.decodeInteger(forKey: "id")
        self.phone = decoder.decodeInteger(forKey: "phone")
        self.bio = decoder.decodeObject(forKey: "bio") as? String ?? ""

    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(grade, forKey: "grade")
        coder.encode(id, forKey: "id")
        coder.encode(phone, forKey: "phone")
        coder.encode(bio, forKey: "bio")
    }
}
