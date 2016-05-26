//
//  Order.swift
//  BobaRun
//
//  Created by Hoa Pham on 5/2/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import Foundation

struct Order {
    var user: User = User()
    var teaType: String = ""
    var sugarLevel: String = ""
    var iceLevel: String = ""
    var toppings: [String] = []
    var paid: Bool = false
}