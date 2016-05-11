//
//  OrderViewController.swift
//  BobaRun
//
//  Created by Hoa Pham on 5/2/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit
import CoreData

class OrderViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var tableView : UITableView!
    var orders : [Order]!
    let orderViewCellReuseIdentifier = "orderViewCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.hidesBottomBarWhenPushed = true
        var nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        navigationItem.title = "Orders"
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addNewOrder:")
        self.navigationItem.rightBarButtonItem = addButton
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        nav?.titleTextAttributes = titleDict as! [String : AnyObject]
        
        // TODO: populate groups from Backend
        orders = []
        
        tableView = UITableView()
        //        var tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: orderViewCellReuseIdentifier)
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
        return orders.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: orderViewCellReuseIdentifier)
        
        cell.textLabel!.text = orders[indexPath.row].user.userName
//        cell.detailTextLabel!.text = orders[indexPath.row].groupTimeStamp
        
        cell.selectionStyle = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let orderViewController = OrderViewController()
        self.navigationController?.pushViewController(orderViewController, animated: true)
    }
    
    func addNewOrder(sender: AnyObject) {
        let orderFormViewController = OrderFormViewController()
        self.navigationController?.pushViewController(orderFormViewController, animated: true)
    }
}

