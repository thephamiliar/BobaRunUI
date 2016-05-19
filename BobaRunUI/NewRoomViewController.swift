//
//  NewRoomViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/4/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit

class NewRoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var friendsList: [User]!
    var groupsList: [Group]!
    let newRoomViewCellReuseIdentifier = "newRoomViewCellReuseIdentifier"
    let buttonHeight = CGFloat(35)
    let buttonWidth = CGFloat(50)
    let buttonPadding = CGFloat(20)
    let footerHeight = CGFloat(80)
    let submitButtonHeight = CGFloat(50)
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navBar = self.navigationController?.navigationBar
        navBar!.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        navigationItem.title = "New Room"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navBar?.titleTextAttributes = (titleDict as! [String : AnyObject])
        
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
        friendsList = [testFriend, testFriend2, testFriend3, testFriend4] // TODO: get friends from WebAPI
        groupsList = [testGroup]    // TODO: get groups from WebAPI
        
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
        submitButton.backgroundColor = UIColor(red: 127/255, green: 72/255, blue: 140/255, alpha: 1)
        submitButton.addTarget(self, action: #selector(NewGroupViewController.selectedSubmitButton(_:)), forControlEvents: .TouchUpInside)
        submitButton.layer.cornerRadius = 5
        self.view.addSubview(submitButton)
    }
    
    override func viewDidAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        navigationItem.title = "New Group"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        nav?.titleTextAttributes = (titleDict as! [String : AnyObject])
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
            cell.detailTextLabel!.text = users[0].firstName
            if (users.count > 1) {
                var index = 1
                while (index < 8 && index < users.count) {
                    cell.detailTextLabel!.text = cell.detailTextLabel!.text! + ", " + (users[index].firstName! as String)
                    index += 1
                }
            }
            if (users.count > 8) {
                cell.detailTextLabel!.text = cell.detailTextLabel!.text! + " +" + String(users.count-8)
            }

        }
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    
    func selectedSubmitButton(sender: UIButton!) {
        // TODO: send new room to backend?
        // TODO: push notifications
        
        self.navigationController?.popViewControllerAnimated(true)
    }


}
