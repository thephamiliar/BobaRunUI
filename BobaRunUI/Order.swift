//
//  Order.swift
//  BobaRun
//
//  Created by Hoa Pham on 5/2/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import Foundation

class Order: NSObject {
    var user: User = User()
    var teaType: String = ""
    var sugarLevel: String = ""
    var iceLevel: String = ""
    var toppings: [String] = []
    var paid: Bool = false
    
    var username : String = ""
    var roomId : String = ""
    var userId : Int = -1
    var price : Double = 2.0
    var drinkPurchased : Bool = false
    var id : String = ""
    
    init(json: JSON) {
        let order = json["drink"].stringValue
        var order_array = order.componentsSeparatedByString(",");
        teaType = order_array[0];
        sugarLevel = order_array[1];
        iceLevel = order_array[2];
        if (order_array[3] == "true") {
            paid = true;
        }
        else {
            paid = false;
        }
        
        let subarray = order_array[4...order_array.count - 1]
        toppings = [] + subarray

        price = json["price"].doubleValue
        roomId = json["room_id"].stringValue
        userId = json["room_members_id"].intValue
        drinkPurchased = json["drink_purchased"].boolValue
        paid = json["runner_paid"].boolValue
        id = json["id"].stringValue
    }
 
    override init() {}
    
    init(order: String) {
        var order_array = order.componentsSeparatedByString(",");
        teaType = order_array[0];
        sugarLevel = order_array[1];
        iceLevel = order_array[2];
        if (order_array[3] == "true") {
            paid = true;
        }
        else {
            paid = false;
        }
        let size = order_array.count
        let subarray = order_array[4...size]
        toppings = [] + subarray
    }
}