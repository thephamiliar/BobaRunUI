//
//  HomePageViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/4/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    var groups : [Group]!
    let homePageViewCellReuseIdentifier = "homePageViewCellReuseIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        navigationItem.title = "Groups"
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewGroup:")
        self.navigationItem.rightBarButtonItem = addButton
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        nav?.titleTextAttributes = titleDict as [NSObject : AnyObject]
        
        // TODO: populate groups from Backend
        var testGroup = Group()
        testGroup.groupName = "CSM117 :D"
        testGroup.groupTimeStamp = "05/04/16"
        groups = [testGroup]
        
        tableView = UITableView()
//        var tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: homePageViewCellReuseIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: homePageViewCellReuseIdentifier)
        
        cell.textLabel!.text = groups[indexPath.row].groupName
        cell.detailTextLabel!.text = groups[indexPath.row].groupTimeStamp
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderViewController = OrderViewController()
        self.navigationController?.pushViewController(orderViewController, animated: true)
    }

    func addNewGroup(sender: AnyObject) {
        let newGroupViewController = NewGroupViewController()
        self.navigationController?.pushViewController(newGroupViewController, animated: true)
    }
}

