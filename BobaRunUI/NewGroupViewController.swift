//
//  NewGroupViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/17/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class NewGroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var friendsList = [User]()
    let friendViewCellReuseIdentifier = "friendViewCellReuseIdentifier"
    let buttonHeight = CGFloat(35)
    let buttonWidth = CGFloat(50)
    let buttonPadding = CGFloat(20)
    let footerHeight = CGFloat(80)
    let submitButtonHeight = CGFloat(50)
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsList = []// TODO: get friends from WebAPI
        
        tableView = UITableView()
        let tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: tableFrame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: friendViewCellReuseIdentifier)
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
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(friendViewCellReuseIdentifier, forIndexPath: indexPath)
        
        cell.textLabel!.text = friendsList[indexPath.row].firstName! + " " + friendsList[indexPath.row].lastName!
        cell.imageView!.image = friendsList[indexPath.row].image
        cell.imageView!.layer.cornerRadius = 25;
        cell.imageView!.layer.masksToBounds = true;
        
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
        // TODO: send new group to backend
        
        self.navigationController?.popViewControllerAnimated(true)
    }

}
