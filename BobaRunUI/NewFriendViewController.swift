//
//  NewFriendViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/26/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class NewFriendViewController: UIViewController {
    var friendUsernameTextView : UITextField!
    var addFriendButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Add Friend"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        friendUsernameTextView = UITextField(frame: CGRectMake(0, self.view.frame.height/2 - 20, 150, 40))
        friendUsernameTextView.center.x = self.view.center.x
        friendUsernameTextView.placeholder = "Friend's Username"
        friendUsernameTextView.borderStyle = UITextBorderStyle.Line
        friendUsernameTextView.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).CGColor
        friendUsernameTextView.layer.cornerRadius = 5
        self.view.addSubview(friendUsernameTextView)
        
        addFriendButton = UIButton(frame: CGRectMake(0, self.view.frame.height/2 + 40, 150, 50))
        addFriendButton.center.x = self.view.center.x
        addFriendButton.setTitle("Add Friend", forState: UIControlState.Normal)
        addFriendButton.addTarget(self, action: #selector(NewFriendViewController.selectedNewFriendButton(_:)), forControlEvents: .TouchUpInside)
        addFriendButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        addFriendButton.layer.cornerRadius = 5
        self.view.addSubview(addFriendButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectedNewFriendButton(sender: UIButton!) {
        // TODO: add new friend to backend
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}
