//
//  OrderConfirmationViewController.swift
//  BobaRun
//
//  Created by Hoa Pham on 5/2/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit

class OrderConfirmationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var order: Order!
    var room: Room!
    var user: User!
    var roomId: String!
    var button : Bool = false
    var tableView : UITableView!
    let formViewCellReuseIdentifier = "formViewCellReuseIdentifier"
    let footerHeight = CGFloat(80)
    let submitButtonHeight = CGFloat(50)

    init(order: Order, room: Room, user: User, confirmButton: Bool) {
        self.order = order
        self.room = room
        self.roomId = room.roomID
        self.user = user
        self.button = confirmButton
        super.init(nibName: nil, bundle: nil)
    }
    
    init(order: Order, roomId: String, user: User, confirmButton: Bool) {
        self.order = order
        self.roomId = roomId
        self.user = user
        self.button = confirmButton
        super.init(nibName: nil, bundle: nil)
    }

    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        let tableFrame = button ? CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight) : self.view.frame
        tableView = UITableView(frame: tableFrame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: formViewCellReuseIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        if (self.button) {
            let footerView: UIView = UIView(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width, footerHeight))
            footerView.backgroundColor = UIColor(red: 248/255, green: 241/255, blue: 243/255, alpha: 1)
            self.view.addSubview(footerView)
            
            let confirmButton: UIButton = UIButton(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width-30, submitButtonHeight))
            confirmButton.center = footerView.center
            confirmButton.setTitle("Confirm", forState: UIControlState.Normal)
            confirmButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
            confirmButton.addTarget(self, action: #selector(OrderConfirmationViewController.selectedConfirmButton(_:)), forControlEvents: .TouchUpInside)
            confirmButton.layer.cornerRadius = 5
            self.view.addSubview(confirmButton)
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value2, reuseIdentifier: formViewCellReuseIdentifier)
        
        switch (indexPath.row) {
        case OrderSection.TeaType.rawValue:
            cell.textLabel!.text = "Tea Type:"
            cell.detailTextLabel!.text = order.teaType
            break
        case OrderSection.SugarLevel.rawValue:
            cell.textLabel!.text = "Sugar Level:"
            cell.detailTextLabel!.text = order.sugarLevel
            break
        case OrderSection.IceLevel.rawValue:
            cell.textLabel!.text = "Ice Level:"
            cell.detailTextLabel!.text = order.iceLevel
            break
        case OrderSection.Toppings.rawValue:
            cell.textLabel!.text = "Toppings:"
            for topping in order.toppings {
                if cell.detailTextLabel!.text == nil {
                    cell.detailTextLabel!.text = topping
                } else {
                    cell.detailTextLabel!.text! = cell.detailTextLabel!.text! + ", " + topping
                }
            }
            break
        case OrderSection.Price.rawValue:
            cell.textLabel!.text = "Price:"
            cell.detailTextLabel!.text = "$" + String(format: "%.2f", order.price)
        default:
            cell.textLabel!.text = "Other"
        }
        
        cell.selectionStyle = .None
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func constructOrderString(order: Order) -> String {
        var order_string = ""
        order_string = order_string + order.teaType + ", " + order.sugarLevel + ", " + order.iceLevel + ", " + "false"
        for topping in order.toppings {
            order_string = order_string + " ," + topping
        }
        
        // encode special characters
        order_string = order_string.stringByReplacingOccurrencesOfString("%", withString: "%25", options: NSStringCompareOptions.LiteralSearch, range: nil)
        order_string = order_string.stringByReplacingOccurrencesOfString("&", withString: "%26", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        return order_string
    }
    
    func selectedConfirmButton(sender: UIButton!) {
        // TODO: add to master page
        let order_string = constructOrderString(order)
        print (order_string)
        if (self.roomId == "") {
            self.roomId = self.room.roomID!
        }
        BobaRunAPI.bobaRunSharedInstance.addMemberToRoom(self.roomId!, memberId: "\(self.user.id!)", drink: order_string, price: order.price) { (json: JSON) in
            print ("saving drink")
            if let creation_error = json["error"].string {
                if creation_error == "true" {
                    print ("drink failed to save")
                }
            else {
        dispatch_async(dispatch_get_main_queue(),{
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Success!"
            alertView.message = "Your drink has successfully been sent!"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        })
            }
        }
        }
        self.navigationController?.popToRootViewControllerAnimated(true)

    }
}

