//
//  GroupViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/16/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class GroupViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    var group : Group!
    var friends : [User]!
    var user = User()
    let friendViewCellReuseIdentifier = "friendViewCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = group.groupName
        
        friends = group.users
        
        tableView = UITableView()
        //        var tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: friendViewCellReuseIdentifier)
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
        return friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(friendViewCellReuseIdentifier, forIndexPath: indexPath)
        
        cell.textLabel!.text = friends[indexPath.row].firstName! + " " + friends[indexPath.row].lastName!
        cell.imageView!.image = friends[indexPath.row].image
        cell.imageView!.layer.cornerRadius = 25;
        cell.imageView!.layer.masksToBounds = true;
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let profileViewController = ProfileViewController(user: user)
        profileViewController.user = friends[indexPath.row]
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
}
