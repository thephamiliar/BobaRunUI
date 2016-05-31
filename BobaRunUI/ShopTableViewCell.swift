//
//  ShopTableViewCell.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/29/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class ShopTableViewCell: UITableViewCell {
    var shopImageView: UIImageView!
    var titleLabel: UILabel!
    var ratingLabel: UILabel!
    var addressLabel: UILabel!
    var descriptionLabel: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let maxX = CGFloat(80)
        let labelWidth = CGFloat(400)
        
        shopImageView = UIImageView(frame: CGRectMake(10, 10, 70, 70))
        contentView.addSubview(shopImageView)
        
        titleLabel = UILabel(frame: CGRectMake(maxX, 10, labelWidth, 20))
        contentView.addSubview(titleLabel)
        
        ratingLabel = UILabel(frame: CGRectMake(maxX, titleLabel!.frame.maxY, labelWidth, 15))
        ratingLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        ratingLabel.textColor = UIColor.lightGrayColor()
        contentView.addSubview(ratingLabel)
        
        addressLabel = UILabel(frame: CGRectMake(maxX, ratingLabel!.frame.maxY, labelWidth, 15))
        addressLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        contentView.addSubview(addressLabel)
        
        descriptionLabel = UILabel(frame: CGRectMake(maxX, addressLabel!.frame.maxY, labelWidth, 15))
        descriptionLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        descriptionLabel.textColor = UIColor.lightGrayColor()
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
