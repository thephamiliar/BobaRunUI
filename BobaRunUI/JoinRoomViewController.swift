//
//  JoinRoomViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/26/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class JoinRoomViewController: UIViewController, UITextFieldDelegate {
    var roomIDTextView : UITextField!
    var joinRoomButton : UIButton!
    
    // todo: get user and room
    var room = Room()
    var user = User()
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.roomIDTextView.delegate = self
        // Do any additional setup after loading the view.
        navigationItem.title = "Join Room"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        roomIDTextView = UITextField(frame: CGRectMake(0, self.view.frame.height/2 - 60, 150, 40))
        roomIDTextView.center.x = self.view.center.x
        roomIDTextView.placeholder = "Room Invite Code"
        roomIDTextView.borderStyle = UITextBorderStyle.RoundedRect
        roomIDTextView.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).CGColor
        roomIDTextView.layer.cornerRadius = 5
        self.view.addSubview(roomIDTextView)
        
        joinRoomButton = UIButton(frame: CGRectMake(0, self.view.frame.height/2, 150, 50))
        joinRoomButton.center.x = self.view.center.x
        joinRoomButton.setTitle("Join Room", forState: UIControlState.Normal)
        joinRoomButton.addTarget(self, action: #selector(JoinRoomViewController.selectedJoinButton(_:)), forControlEvents: .TouchUpInside)
        joinRoomButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        joinRoomButton.layer.cornerRadius = 5
        self.view.addSubview(joinRoomButton)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectedJoinButton(sender: UIButton!) {
        let roomId = roomIDTextView.text
        // assume roomId is correct
        let orderFormViewController = OrderFormViewController(user: user, roomId: roomId!)
        
        orderFormViewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(orderFormViewController, animated: true)
    }

}
