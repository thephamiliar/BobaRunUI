//
//  OrderViewTableViewCell.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/17/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class OrderViewTableViewCell: UITableViewCell {
    var userLabel : UILabel!
    var priceLabel : UILabel!
    var teaTypeLabel : UILabel!
    var sugarLevelLabel : UILabel!
    var iceLevelLabel : UILabel!
    var toppingsLabel : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        
        userLabel = UILabel(frame: CGRect(x: 20, y: 5, width: 100, height: 20))
        contentView.addSubview(userLabel)
        
        priceLabel = UILabel(frame: CGRect(x: 150, y: 5, width: 100, height: 20))
        priceLabel.textAlignment = .Right
        contentView.addSubview(priceLabel)
        
        teaTypeLabel = UILabel(frame: CGRect(x: 20, y: 30, width: 200, height: 15))
        teaTypeLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        contentView.addSubview(teaTypeLabel)
        
        sugarLevelLabel = UILabel(frame: CGRect(x: 20, y: 45, width: 200, height: 15))
        sugarLevelLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        contentView.addSubview(sugarLevelLabel)
        
        iceLevelLabel = UILabel(frame: CGRect(x: 20, y: 60, width: 200, height: 15))
        iceLevelLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        contentView.addSubview(iceLevelLabel)
        
        toppingsLabel = UILabel(frame: CGRect(x: 20, y: 75, width: 200, height: 15))
        toppingsLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        contentView.addSubview(toppingsLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
