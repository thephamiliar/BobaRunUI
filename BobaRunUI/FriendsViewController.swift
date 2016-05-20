//
//  FriendsViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/4/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    var friends = [User]()
    let friendViewCellReuseIdentifier = "friendViewCellReuseIdentifier"
    
    override func viewWillAppear(animated: Bool) {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()

        BobaRunAPI.bobaRunSharedInstance.getFriends(prefs.valueForKey("USERNAME") as! String) { (json: JSON) in
            print ("getting friends")
            if let creation_error = json["error"].string {
                if creation_error == "true" {
                    print ("could not retrieve friends")
                }
                else {
                    if let results = json["result"].array {
                        self.friends.removeAll()
                        for entry in results {
                            self.friends.append(User(json: entry))
                        }
                        dispatch_async(dispatch_get_main_queue(),{
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        self.navigationItem.title = "Friends"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        nav?.titleTextAttributes = titleDict as! [String : AnyObject]
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.tableView = UITableView()
        //        var tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        self.tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.friendViewCellReuseIdentifier)
        self.tableView.allowsMultipleSelection = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
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
        
        // cell.textLabel!.text = friends[indexPath.row].firstName! + " " + friends[indexPath.row].lastName!
        cell.textLabel!.text = friends[indexPath.row].username
        cell.imageView!.image = friends[indexPath.row].image
        cell.imageView!.layer.cornerRadius = 25;
        cell.imageView!.layer.masksToBounds = true;
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderViewController = OrderViewController()
        self.navigationController?.pushViewController(orderViewController, animated: true)
    }
    
}

