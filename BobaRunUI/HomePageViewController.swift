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
    var rooms = [Room]()
    let homePageViewCellReuseIdentifier = "homePageViewCellReuseIdentifier"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        navigationItem.title = "Rooms"
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(HomePageViewController.addNewRoom(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        nav?.titleTextAttributes = (titleDict as! [String : AnyObject])
        
        // TODO: populate groups from Backend
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        BobaRunAPI.bobaRunSharedInstance.getUserRooms(prefs.valueForKey("USERNAME") as! String) { (json: JSON) in
            print ("getting my rooms")
            if let creation_error = json["error"].string {
                if creation_error == "true" {
                    print ("could not retrieve rooms")
                }
                else {
                    if let results = json["result"].array {
                        self.rooms.removeAll()
                        for entry in results {
                            self.rooms.append(Room(json: entry))
                        }
                        dispatch_async(dispatch_get_main_queue(),{
                            self.tableView.reloadData()
                        })
                    }
                }
            }
        }
        
        tableView = UITableView()
//        var tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: homePageViewCellReuseIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            // TODO: any user specific details here
            // self.usernameLabel.text = prefs.valueForKey("USERNAME") as NSString
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: homePageViewCellReuseIdentifier)
        
        cell.textLabel!.text = rooms[indexPath.row].roomName
        // cell.detailTextLabel!.text = rooms[indexPath.row].roomTimeStamp
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderViewController = OrderViewController()
        self.navigationController?.pushViewController(orderViewController, animated: true)
    }

    func addNewRoom(sender: AnyObject) {
        let newRoomViewController = NewRoomViewController()
        self.navigationController?.pushViewController(newRoomViewController, animated: true)
    }
}

