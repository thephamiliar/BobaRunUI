//
//  NewGroupNameViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/29/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class NewGroupNameViewController: UIViewController {
    var groupNameTextView : UITextField!
    var createGroupButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Room Creation"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        groupNameTextView = UITextField(frame: CGRectMake(0, self.view.frame.height/2 - 60, 150, 40))
        groupNameTextView.center.x = self.view.center.x
        groupNameTextView.placeholder = "Group Name"
        groupNameTextView.borderStyle = UITextBorderStyle.RoundedRect
        groupNameTextView.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).CGColor
        groupNameTextView.layer.cornerRadius = 5
        self.view.addSubview(groupNameTextView)
        
        createGroupButton = UIButton(frame: CGRectMake(0, self.view.frame.height/2, 150, 50))
        createGroupButton.center.x = self.view.center.x
        createGroupButton.setTitle("Create Group", forState: UIControlState.Normal)
        createGroupButton.addTarget(self, action: #selector(NewGroupNameViewController.selectedCreateButton(_:)), forControlEvents: .TouchUpInside)
        createGroupButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        createGroupButton.layer.cornerRadius = 5
        self.view.addSubview(createGroupButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectedCreateButton(sender: UIButton!) {
        let newGroupViewController = NewGroupViewController(groupName: groupNameTextView.text!)
        newGroupViewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(newGroupViewController, animated: true)
    }
}
