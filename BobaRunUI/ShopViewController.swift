//
//  ShopViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/22/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class ShopViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView : UITableView!
    var shops = [String]()
    let shopViewCellReuseIdentifier = "shopViewCellReuseIdentifier"
    let buttonHeight = CGFloat(35)
    let buttonWidth = CGFloat(50)
    let buttonPadding = CGFloat(20)
    let footerHeight = CGFloat(80)
    let submitButtonHeight = CGFloat(50)
    
    override func viewWillAppear(animated: Bool) {
        // TODO: backend yelp api to get array of boba shop names
        
        tableView = UITableView()
        let tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: tableFrame, style: UITableViewStyle.Plain)
        tableView.registerClass(ShopTableViewCell.self, forCellReuseIdentifier: shopViewCellReuseIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let footerView: UIView = UIView(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width, footerHeight))
        footerView.backgroundColor = UIColor(red: 248/255, green: 241/255, blue: 243/255, alpha: 1)
        self.view.addSubview(footerView)
        
        let submitButton: UIButton = UIButton(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width-30, submitButtonHeight))
        
        submitButton.center = footerView.center
        submitButton.setTitle("Continue", forState: UIControlState.Normal)
        submitButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        submitButton.addTarget(self, action: #selector(ShopViewController.selectedContinueButton(_:)), forControlEvents: .TouchUpInside)
        submitButton.layer.cornerRadius = 5
        self.view.addSubview(submitButton)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.title = "Boba Shops"
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        //return shops.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(shopViewCellReuseIdentifier, forIndexPath: indexPath) as! ShopTableViewCell
    
        // TODO: shop object backend integration
        cell.shopImageView.image = UIImage(named: "love")
        cell.titleLabel.text = "Milk"
        cell.ratingLabel.text = "4/5"
        cell.addressLabel.text = "1435 Le Conte Ave ..."
        cell.descriptionLabel.text  = "Coffee & Tea ..."
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    func selectedContinueButton(sender: UIButton!) {
        let inviteViewController = NewRoomViewController()
        self.navigationController?.pushViewController(inviteViewController, animated: true)
    }
    
}
