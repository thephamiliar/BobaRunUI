//
//  CreateRoomViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/26/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class CreateRoomViewController: UIViewController, UITextFieldDelegate {
    var roomNameTextView : UITextField!
    var createRoomButton : UIButton!
    var user = User()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.roomNameTextView.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Room Creation"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        roomNameTextView = UITextField(frame: CGRectMake(0, self.view.frame.height/2 - 60, 150, 40))
        roomNameTextView.center.x = self.view.center.x
        roomNameTextView.placeholder = "Room Name"
        roomNameTextView.borderStyle = UITextBorderStyle.RoundedRect
        roomNameTextView.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).CGColor
        roomNameTextView.layer.cornerRadius = 5
        self.view.addSubview(roomNameTextView)
        
        createRoomButton = UIButton(frame: CGRectMake(0, self.view.frame.height/2, 150, 50))
        createRoomButton.center.x = self.view.center.x
        createRoomButton.setTitle("Create Room", forState: UIControlState.Normal)
        createRoomButton.addTarget(self, action: #selector(CreateRoomViewController.selectedCreateButton(_:)), forControlEvents: .TouchUpInside)
        createRoomButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        createRoomButton.layer.cornerRadius = 5
        self.view.addSubview(createRoomButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectedCreateButton(sender: UIButton!) {
        let roomName = roomNameTextView.text
        let shopViewController = ShopViewController(roomName: roomName!, user: user)
        shopViewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(shopViewController, animated: true)
    
    }

}
