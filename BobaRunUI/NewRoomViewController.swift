//
//  NewRoomViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/4/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit
import MessageUI

class NewRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate {
    // var friendsList: [User]!
    var friendsList = [User]()
    var numbers = [String]()
    var groupsList: [Group]!
    let newRoomViewCellReuseIdentifier = "newRoomViewCellReuseIdentifier"
    let buttonHeight = CGFloat(35)
    let buttonWidth = CGFloat(50)
    let buttonPadding = CGFloat(20)
    let footerHeight = CGFloat(80)
    let submitButtonHeight = CGFloat(50)
    let roomname = "TEST ROOM 1"
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        BobaRunAPI.bobaRunSharedInstance.getFriends(prefs.valueForKey("USERNAME") as! String) { (json: JSON) in
            print ("getting friends")
            if let creation_error = json["error"].string {
                if creation_error == "true" {
                    print ("could not retrieve friends")
                }
                else {
                    if let results = json["result"].array {
                        self.friendsList.removeAll()
                        for entry in results {
                            let temp_user = User(json: entry)
                            self.friendsList.append(temp_user)
//                            self.numbers.append(temp_user.phoneNumber!)
                        }
                        dispatch_async(dispatch_get_main_queue(),{
                            self.friendsList.sortInPlace({ $0.lastName < $1.lastName })
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        }
        let testFriend = User()
        testFriend.firstName = "Jessica"
        testFriend.lastName = "Pham"
        testFriend.username = "jmpham613"
        testFriend.image = UIImage(named: "faithfulness")!
        let testFriend2 = User()
        testFriend2.firstName = "Joanna"
        testFriend2.lastName = "Chen"
        testFriend2.username = "jchen94"
        testFriend2.image = UIImage(named: "faithfulness")!
        let testFriend3 = User()
        testFriend3.firstName = "Nick"
        testFriend3.lastName = "Yu"
        testFriend3.username = "nyu"
        testFriend3.image = UIImage(named: "faithfulness")!
        let testFriend4 = User()
        testFriend4.firstName = "Louis"
        testFriend4.lastName = "Truong"
        testFriend4.username = "ltroung"
        testFriend4.image = UIImage(named: "faithfulness")!
        var testGroup = Group()
        testGroup.groupName = "CSM117 :D"
        testGroup.groupTimeStamp = "05/16/16"
        testGroup.users = [testFriend, testFriend2, testFriend3, testFriend4]
        testGroup.image = UIImage(named: "love")!
//        friendsList = [testFriend, testFriend2, testFriend3, testFriend4] // TODO: get friends from WebAPI
        friendsList.sortInPlace({ $0.lastName < $1.lastName })
        groupsList = [testGroup]    // TODO: get groups from WebAPI
        groupsList.sortInPlace({ $0.groupName < $1.groupName })
        
        tableView = UITableView()
        let tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: tableFrame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: newRoomViewCellReuseIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let footerView: UIView = UIView(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width, footerHeight))
        footerView.backgroundColor = UIColor(red: 248/255, green: 241/255, blue: 243/255, alpha: 1)
        self.view.addSubview(footerView)
        
        let submitButton: UIButton = UIButton(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width-30, submitButtonHeight))
        submitButton.center = footerView.center
        submitButton.setTitle("Submit", forState: UIControlState.Normal)
        submitButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        submitButton.addTarget(self, action: #selector(NewGroupViewController.selectedSubmitButton(_:)), forControlEvents: .TouchUpInside)
        submitButton.layer.cornerRadius = 5
        self.view.addSubview(submitButton)
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationItem.title = "Invite Friends"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return (section == 0) ? "Friends" : "Groups"
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? friendsList.count : groupsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: newRoomViewCellReuseIdentifier)
        
        if (indexPath.section == 0) {
            cell.textLabel!.text = friendsList[indexPath.row].firstName! + " " + friendsList[indexPath.row].lastName!
            cell.imageView!.image = friendsList[indexPath.row].image
            cell.imageView!.layer.cornerRadius = 25;
            cell.imageView!.layer.masksToBounds = true;
        } else {
            cell.textLabel!.text = groupsList[indexPath.row].groupName
            cell.imageView!.image = groupsList[indexPath.row].image
            cell.imageView!.layer.cornerRadius = 25;
            cell.imageView!.layer.masksToBounds = true;
            
            let users = groupsList[indexPath.row].users
            cell.detailTextLabel!.text = users![0].firstName
            if (users!.count > 1) {
                var index = 1
                while (index < 8 && index < users!.count) {
                    cell.detailTextLabel!.text = cell.detailTextLabel!.text! + ", " + (users![index].firstName! as String)
                    index += 1
                }
            }
            if (users!.count > 8) {
                cell.detailTextLabel!.text = cell.detailTextLabel!.text! + " +" + String(users!.count-8)
            }

        }
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
        numbers.append(friendsList[indexPath.row].phoneNumber!)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    
    func selectedSubmitButton(sender: UIButton!) {
        // TODO: send new room to backend?
        // TODO: push notifications
        var messageVC = MFMessageComposeViewController()
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        BobaRunAPI.bobaRunSharedInstance.createNewRoomWithUserName(roomname, username: prefs.valueForKey("USERNAME") as! String){ (json: JSON) in
            print ("creating room")
            if let creation_error = json["error"].string {
                if creation_error == "true" {
                    print ("could not create room")
                }
                else {
                    if let results = json["result"].string {
                        print(results)
                        dispatch_async(dispatch_get_main_queue(),{
                            messageVC.body = "Room ID: \(results). Please enter this ID to join this room!";
                            messageVC.recipients = self.numbers
                            messageVC.messageComposeDelegate = self;
                            self.presentViewController(messageVC, animated: false, completion: nil)
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        }
        
        //        //need user input for roomname in argument below
        //        BobaRunAPI.bobaRunSharedInstance.createNewRoom(roomname, User.ID){ (json: JSON) in
        //
        //            if let creation_error = json["error"].string {
        //                if creation_error == "true" {
        //                    print ("could not create room")
        //                }
        //            else {
        //                    results = json["result"].array
        //                }
        //            }
        //        }
        
        
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        switch (result.rawValue) {
        case MessageComposeResultCancelled.rawValue:
            print("Message was cancelled")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed.rawValue:
            print("Message failed")
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent.rawValue:
            print("Message was sent")
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }


}
