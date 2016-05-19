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
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        navigationItem.title = "Orders"
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(OrderViewController.addNewOrder(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        nav?.titleTextAttributes = (titleDict as! [String : AnyObject])
        
        // TODO: populate orders from Backend
        var order1 = Order()
        order1.iceLevel = "50%"
        order1.toppings = ["Boba", "Pudding"]
        order1.sugarLevel = "50%"
        order1.teaType = "Milk Tea"
        let testFriend = User()
        testFriend.firstName = "Jessica"
        testFriend.lastName = "Pham"
        testFriend.userName = "jmpham613"
        testFriend.image = UIImage(named: "faithfulness")!
        order1.user = testFriend
        orders = [order1]
        
        tableView = UITableView()
        //        var tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: self.view.frame, style: UITableViewStyle.Plain)
        tableView.registerClass(OrderViewTableViewCell.self, forCellReuseIdentifier: orderViewCellReuseIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return CGFloat(100)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let order = orders[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier(orderViewCellReuseIdentifier) as! OrderViewTableViewCell
        cell.userLabel.text = order.user.username
        cell.priceLabel.text = "$3.25" // TODO : add price to orders
        cell.teaTypeLabel.text = "Tea Type: " + order.teaType
        cell.sugarLevelLabel.text = "Sugar Level: " + order.sugarLevel
        cell.iceLevelLabel.text = "Ice Level: " + order.iceLevel
        
        if (order.toppings.count > 0) {
            var toppingsText = "Toppings: " + order.toppings[0]
            var index = 1
            while (index < order.toppings.count) {
                toppingsText = toppingsText + ", " + order.toppings[index]
                index += 1
            }
            cell.toppingsLabel.text = toppingsText
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let order = orders[indexPath.row]
        let confirmationViewController = OrderConfirmationViewController(order: order)
        self.navigationController?.pushViewController(confirmationViewController, animated: true)
    }
    
    func addNewOrder(sender: AnyObject) {
        let orderFormViewController = OrderFormViewController()
        self.navigationController?.pushViewController(orderFormViewController, animated: true)
    }
}
