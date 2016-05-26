//
//  Group.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/16/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import Foundation
import UIKit

class Group: NSObject {
    var groupID: String?
    var groupName: String?
    var users: [User]?
    var groupTimeStamp: String?
    var image: UIImage?
    
    override init () {
        
    }
    
    init(json: JSON) {
        image = (json["image"] != nil) ? UIImage(named: json["image"].stringValue) : UIImage(named: "faithfulness")
        groupName = json["group_name"].stringValue
        groupID = json["g_id"].stringValue
        users = []
        
    }
}