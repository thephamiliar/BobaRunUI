//
//  PayOrderViewController.swift
//  BobaRun
//
//  Created by Hoa Pham on 5/2/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit

class PayOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var order: Order!
    var tableView : UITableView!
    let formViewCellReuseIdentifier = "formViewCellReuseIdentifier"
    let footerHeight = CGFloat(80)
    let submitButtonHeight = CGFloat(50)
    
    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }
    
    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        let tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: tableFrame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: formViewCellReuseIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        let footerView: UIView = UIView(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width, footerHeight))
        footerView.backgroundColor = UIColor(red: 248/255, green: 241/255, blue: 243/255, alpha: 1)
        self.view.addSubview(footerView)
        
        let payButton: UIButton = UIButton(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width-30, submitButtonHeight))
        payButton.center = footerView.center
        payButton.setTitle("Pay Now", forState: UIControlState.Normal)
        payButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        payButton.addTarget(self, action: #selector(PayOrderViewController.selectedPayButton(_:)), forControlEvents: .TouchUpInside)
        payButton.layer.cornerRadius = 5
        self.view.addSubview(payButton)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
    
    func selectedPayButton(sender: UIButton!) {
        // TODO: backend set order to "paid"
        BobaRunAPI.bobaRunSharedInstance.markOrderAsPaid("\(self.order.id)!") { (json: JSON) in
            print ("paying for drink")
            if let creation_error = json["error"].string {
                if creation_error == "true" {
                    print ("could not set drink paid to true for this order")
                }
                else {
                    print ("successfully paid for drink")
                }
            }
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}

