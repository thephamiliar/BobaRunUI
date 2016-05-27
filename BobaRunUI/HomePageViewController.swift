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
    var runnerRooms = [Room]()
    var memberRooms = [Room]()
    var user = User()

    let homePageViewCellReuseIdentifier = "homePageViewCellReuseIdentifier"
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = "Rooms"
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(HomePageViewController.addNewRoom(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        // TODO: populate groups from Backend
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        let isLoggedIn:Int = prefs.integerForKey("ISLOGGEDIN") as Int
        if (isLoggedIn != 1) {
            self.performSegueWithIdentifier("goto_login", sender: self)
        } else {
            // TODO: any user specific details here
            // self.usernameLabel.text = prefs.valueForKey("USERNAME") as NSString
            let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
            if (self.user.id == nil) {
                BobaRunAPI.bobaRunSharedInstance.getUser(prefs.valueForKey("USERNAME") as! String) { (json: JSON) in
                    print ("getting user info")
                    if let creation_error = json["error"].string {
                        if creation_error == "true" {
                            print ("could get user info")
                        }
                        else {
                            if let results = json["result"].array {
                                for entry in results {
                                    self.user = (User(json: entry))
                                    // self.user.image = UIImage(named: "faithfulness")!
                                }
                                dispatch_async(dispatch_get_main_queue(),{
                                    self.tableView.reloadData()
                                })
                            }
                        }
                    }
                }
            
            
                BobaRunAPI.bobaRunSharedInstance.getUserRooms(prefs.valueForKey("USERNAME") as! String) { (json: JSON) in
                    print ("getting my rooms")
                    if let creation_error = json["error"].string {
                        if creation_error == "true" {
                            print ("could not retrieve rooms")
                        }
                        else {
                            if let results = json["runner_rooms"].array {
                                self.runnerRooms.removeAll()
                                for entry in results {
                                    self.runnerRooms.append(Room(json: entry))
                                }
                                dispatch_async(dispatch_get_main_queue(),{
    //                                self.runnerRooms.sortInPlace({ $0.roomTimeStamp > $1.roomTimeStamp })
                                    self.tableView.reloadData()
                                    })
                            }
                            if let results = json["member_rooms"].array {
                                self.memberRooms.removeAll()
                                for entry in results {
                                    self.memberRooms.append(Room(json: entry))
                                }
                                dispatch_async(dispatch_get_main_queue(),{
                                    //                                self.rooms.sortInPlace({ $0.roomTimeStamp > $1.roomTimeStamp })
                                    self.tableView.reloadData()
                                })
                            }
                            
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Runner Rooms" : "Member Rooms" 
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? runnerRooms.count : memberRooms.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: homePageViewCellReuseIdentifier)
        
        if (indexPath.section == 0){
            cell.textLabel!.text = runnerRooms[indexPath.row].roomName
        } else {
            cell.textLabel!.text = memberRooms[indexPath.row].roomName
        }
        // cell.detailTextLabel!.text = rooms[indexPath.row].roomTimeStamp
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var room = Room()
        if (indexPath.section == 0){
            room = runnerRooms[indexPath.row]
        } else {
            room = memberRooms[indexPath.row]
        }
        let orderViewController = OrderViewController(room: room, user: user)

        orderViewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(orderViewController, animated: true)
    }

    func addNewRoom(sender: AnyObject) {
        let roomSelectionViewController = RoomSelectionViewController()
        roomSelectionViewController.hidesBottomBarWhenPushed = true;
        self.navigationController?.pushViewController(roomSelectionViewController, animated: true)
    }
}

