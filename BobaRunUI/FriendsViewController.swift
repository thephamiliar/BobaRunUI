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
    let searchController = UISearchController(searchResultsController: nil)
    var filteredFriends = [User]()
    
    override func viewWillAppear(animated: Bool) {
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(FriendsViewController.addNewFriend(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
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
                            self.friends.sortInPlace({ $0.lastName < $1.lastName })
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
        self.navigationItem.title = "Friends"
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView = UITableView()
        //        var tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        self.tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.friendViewCellReuseIdentifier)
        self.tableView.allowsMultipleSelection = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.active && searchController.searchBar.text != "" {
            return filteredFriends.count
        }
        return friends.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(friendViewCellReuseIdentifier, forIndexPath: indexPath) 
        
        let friend: User
        if searchController.active && searchController.searchBar.text != "" {
            friend = filteredFriends[indexPath.row]
        } else {
            friend = friends[indexPath.row]
        }
        
         cell.textLabel!.text = friend.firstName! + " " + friend.lastName!
        // cell.textLabel!.text = friends[indexPath.row].username
        cell.imageView!.image = friend.image
        cell.imageView!.layer.cornerRadius = 25;
        cell.imageView!.layer.masksToBounds = true;
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let profileViewController = ProfileViewController(user: friends[indexPath.row])
        // profileViewController.user = friends[indexPath.row]
        self.navigationController?.pushViewController(profileViewController, animated: true)
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredFriends = friends.filter { friend in
            return friend.firstName!.lowercaseString.containsString(searchText.lowercaseString) || friend.lastName!.lowercaseString.containsString(searchText.lowercaseString)
        }
        
        tableView.reloadData()
    }
    
    func addNewFriend(sender: UIButton!) {
        let newFriendViewController = NewFriendViewController()
        newFriendViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newFriendViewController, animated: true)
    }
}

extension FriendsViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
