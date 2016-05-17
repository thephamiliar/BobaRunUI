//
//  ProfileViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/4/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    var user : User!
    let userViewCellReuseIdentifier = "userViewCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        navigationItem.title = "Profile"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        nav?.titleTextAttributes = (titleDict as! [String : AnyObject])
        
        // TODO: populate user from backend
        user = User()
        user.firstName = "Jessica"
        user.lastName = "Pham"
        user.userName = "jmpham613"
        user.email = "jessicaminhuyen@yahoo.com"
        user.image = UIImage(named: "faithfulness")!
        
        tableView = UITableView()
        //        var tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: userViewCellReuseIdentifier)
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
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return (section == 0) ? CGFloat(250) : CGFloat(30)
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(red: 239/250, green: 239/250, blue: 244/250, alpha: 1)

        if (section == 0) {
            view.frame = CGRectMake(0, 0, self.view.frame.width, CGFloat(200))
            let imageView = UIImageView(image: user.image)
            imageView.frame = CGRectMake((self.view.frame.size.width/2) - (user.image.size.width/2), 50, user.image.size.width, user.image.size.height)
            view.addSubview(imageView)
            
            let nameLabel = UILabel(frame: CGRectMake(0, imageView.frame.maxY, self.view.frame.width, 40))
            nameLabel.text = user.firstName + " " + user.lastName;
            nameLabel.textAlignment = NSTextAlignment.Center
            view.addSubview(nameLabel)
        }
        
        return view
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (section == 0) ? 2 : 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: userViewCellReuseIdentifier)
        
        if (indexPath.section == 0) {
            if (indexPath.row == 0) {
                cell.textLabel!.text = "Username"
                cell.detailTextLabel!.text = user.userName
                cell.imageView!.image = user.image
            } else {
                cell.textLabel!.text = "Email"
                cell.detailTextLabel!.text = user.email
                cell.imageView!.image = user.image
            }
        } else {
            cell.textLabel!.text = "Change Password"
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell.imageView!.image = user.image
        }
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderViewController = OrderViewController()
        self.navigationController?.pushViewController(orderViewController, animated: true)
    }

}
