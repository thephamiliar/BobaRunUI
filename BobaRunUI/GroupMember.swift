//
//  RoomMember.swift
//  BobaRunUI
//
//  Created by Joanna Chen on 5/20/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import Foundation

// this class is used as an intermediate object to parse the JSON from
// groupmembers into the group object created on the swift end

class GroupMember: NSObject {
    var group_id: String?
    var username: String?
    
    override init () {
        
    }
    
    init(json: JSON) {
        username = json["username"].stringValue
        group_id = json["g_id"].stringValue
    }
}