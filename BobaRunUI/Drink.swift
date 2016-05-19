//
//  Drink.swift
//  BobaRunUI
//
//  Created by Joanna Chen on 5/18/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import Foundation

class Drink: NSObject {
    var name: String?
    var price: Double?
    var category: String?
    
    init(json: JSON) {
        name = json["name"].stringValue
        price = json["price"].doubleValue
        category = json["category"].stringValue
    }
    
}