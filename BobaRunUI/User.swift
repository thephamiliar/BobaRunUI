//
//  Friend.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/10/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    var firstName: String?
    var lastName: String?
    var username: String?
    var password: String?
    var email: String?
    var venmo_id: String?
    var id: Int?
    var image: UIImage?
    
    override init () {
        
    }
    
    init(json: JSON) {
        image = UIImage()
        firstName = ""
        lastName = ""
        username = json["username"].stringValue
        password = json["password"].stringValue
        email = json["email"].stringValue
        venmo_id = json["venmo_id"].stringValue
        id = json["id"].intValue
    }
}