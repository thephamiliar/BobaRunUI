//
//  JoinRoomViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/26/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class JoinRoomViewController: UIViewController {
    var roomIDTextView : UITextField!
    var joinRoomButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        navigationItem.title = "Join Room"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        roomIDTextView = UITextField(frame: CGRectMake(0, self.view.frame.height/2 - 20, 150, 40))
        roomIDTextView.center.x = self.view.center.x
        roomIDTextView.placeholder = "Room Invite Code"
        roomIDTextView.borderStyle = UITextBorderStyle.Line
        roomIDTextView.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1).CGColor
        roomIDTextView.layer.cornerRadius = 5
        self.view.addSubview(roomIDTextView)
        
        joinRoomButton = UIButton(frame: CGRectMake(0, self.view.frame.height/2 + 40, 150, 50))
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
        let orderFormViewController = OrderFormViewController()
        orderFormViewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(orderFormViewController, animated: true)
    }

}
