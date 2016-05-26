//
//  Room.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/4/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import Foundation

class Room: NSObject {
    var roomID: String?
    var roomName: String?
    var runner_id: Int?
    var roomTimeStamp: String = ""
    var runner: User = User()
    var confirmed: Bool = false
    
    override init () {
        
    }
    
    init(json: JSON) {
        roomID = json["room_id"].stringValue
        roomName = json["room_name"].stringValue
        runner_id = json["runner_id"].intValue
        
    }
}