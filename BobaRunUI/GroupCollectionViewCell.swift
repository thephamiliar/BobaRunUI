//
//  GroupCollectionViewCell.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/16/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {
    var groupLabel: UILabel!
    var groupTimeStampLabel: UILabel!
    var groupMembers: UILabel!
    var separator: UIView!
    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height/3))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        contentView.addSubview(imageView)
        
        groupLabel = UILabel(frame: CGRect(x: 0, y: imageView.frame.size.height, width: frame.size.width, height: frame.size.height/6))
        groupLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        groupLabel.textAlignment = .Center
        contentView.addSubview(groupLabel)
        
        groupTimeStampLabel = UILabel(frame: CGRect(x: 0, y: groupLabel.frame.maxY, width: frame.size.width, height: frame.size.height/6))
        groupTimeStampLabel.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        groupTimeStampLabel.textAlignment = .Center
        groupTimeStampLabel.font = groupTimeStampLabel.font.fontWithSize(10)
        contentView.addSubview(groupTimeStampLabel)
        
        separator = UIView(frame: CGRect(x: 10, y: groupTimeStampLabel.frame.maxY, width: frame.size.width-20, height: 1))
        separator.backgroundColor = UIColor.lightGrayColor()
        contentView.addSubview(separator)
        
        groupMembers = UILabel(frame: CGRect(x: 0, y: separator.frame.maxY, width: frame.size.width, height: frame.size.height/3))
        groupMembers.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
        groupMembers.textAlignment = .Center
        groupMembers.lineBreakMode = .ByWordWrapping
        groupMembers.font = groupMembers.font.fontWithSize(10)
        groupMembers.numberOfLines = 0
        contentView.addSubview(groupMembers)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
