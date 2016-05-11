//
//  PercentageButton.swift
//  BobaRun
//
//  Created by Hoa Pham on 5/1/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import Foundation
import UIKit

class PercentageButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setTitleColor(UIColor(red: 127/255, green: 72/255, blue: 140/255, alpha: 1), forState: .Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: .Selected)
        self.layer.borderColor = UIColor(red: 127/255, green: 72/255, blue: 140/255, alpha: 1).CGColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
}