//
//  RoomSelectionViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/26/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class RoomSelectionViewController: UIViewController {
    var createRoomButton : UIButton!
    var joinRoomButton : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Room Selection"
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        createRoomButton = UIButton(frame: CGRectMake(0, self.view.frame.height/2 - 70, 150, 50))
        createRoomButton.center.x = self.view.center.x
        createRoomButton.setTitle("Create Room", forState: UIControlState.Normal)
        createRoomButton.addTarget(self, action: #selector(RoomSelectionViewController.selectedCreateButton(_:)), forControlEvents: .TouchUpInside)
        createRoomButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        createRoomButton.layer.cornerRadius = 5
        self.view.addSubview(createRoomButton)
        
        joinRoomButton = UIButton(frame: CGRectMake(0, self.view.frame.height/2 + 20, 150, 50))
        joinRoomButton.center.x = self.view.center.x
        joinRoomButton.setTitle("Join Room", forState: UIControlState.Normal)
        joinRoomButton.addTarget(self, action: #selector(RoomSelectionViewController.selectedJoinButton(_:)), forControlEvents: .TouchUpInside)
        joinRoomButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        joinRoomButton.layer.cornerRadius = 5
        self.view.addSubview(joinRoomButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectedCreateButton(sender: UIButton!) {
        let newRoomViewController = CreateRoomViewController()
        newRoomViewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(newRoomViewController, animated: true)
    }
    
    func selectedJoinButton(sender: UIButton!) {
        let joinRoomViewController = JoinRoomViewController()
        joinRoomViewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(joinRoomViewController, animated: true)
    }

}
