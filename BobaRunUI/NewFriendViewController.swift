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
        
        friendUsernameTextView = UITextField(frame: CGRectMake(0, self.view.frame.height/2 - 60, 150, 40))
        friendUsernameTextView.center.x = self.view.center.x
        friendUsernameTextView.placeholder = "Friend's Username"
        friendUsernameTextView.borderStyle = UITextBorderStyle.RoundedRect
        friendUsernameTextView.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).CGColor
        friendUsernameTextView.layer.cornerRadius = 5
        self.view.addSubview(friendUsernameTextView)
        
        addFriendButton = UIButton(frame: CGRectMake(0, self.view.frame.height/2, 150, 50))
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
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        BobaRunAPI.bobaRunSharedInstance.addFriend(prefs.valueForKey("USERNAME") as! String, friendName: self.friendUsernameTextView.text!) { (json: JSON) in
            print ("adding friend")
            if let creation_error = json["error"].string {
                if creation_error == "true" {
                    print ("could not retrieve friends")
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Error"
                    alertView.message = "Could not find User with username: " + self.friendUsernameTextView.text!
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                }
                else {
                    dispatch_async(dispatch_get_main_queue(),{
                        let alertView:UIAlertView = UIAlertView()
                        alertView.title = "Success!"
                        alertView.message = self.friendUsernameTextView.text! + " added to friends list"
                        alertView.delegate = self
                        alertView.addButtonWithTitle("OK")
                        alertView.show()
                    })
                }
            }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)

    }
    
}
