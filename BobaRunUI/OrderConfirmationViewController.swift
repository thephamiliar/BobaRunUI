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
    var tableView : UITableView!
    let formViewCellReuseIdentifier = "formViewCellReuseIdentifier"
    let footerHeight = CGFloat(80)
    let submitButtonHeight = CGFloat(50)

    init(order: Order) {
        self.order = order
        super.init(nibName: nil, bundle: nil)
    }

    required  init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    func configureView() {
        if let o = self.order {
            if let table = self.tableView {
                tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView()
        var tableFrame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height-footerHeight)
        tableView = UITableView(frame: tableFrame, style: UITableViewStyle.Plain)
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: formViewCellReuseIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        
        var footerView: UIView = UIView(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width, footerHeight))
        footerView.backgroundColor = UIColor(red: 248/255, green: 241/255, blue: 243/255, alpha: 1)
        self.view.addSubview(footerView)
        
        var confirmButton: UIButton = UIButton(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width-30, submitButtonHeight))
        confirmButton.center = footerView.center
        confirmButton.setTitle("Confirm", forState: UIControlState.Normal)
        confirmButton.backgroundColor = UIColor(red: 127/255, green: 72/255, blue: 140/255, alpha: 1)
        confirmButton.addTarget(self, action: "selectedConfirmButton:", forControlEvents: .TouchUpInside)
        confirmButton.layer.cornerRadius = 5
        self.view.addSubview(confirmButton)
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
            cell.textLabel!.text = "Ice Level"
            cell.detailTextLabel!.text = order.iceLevel
            break
        case OrderSection.Toppings.rawValue:
            cell.textLabel!.text = "Toppings"
            for topping in order.toppings {
                if cell.detailTextLabel!.text == nil {
                    cell.detailTextLabel!.text = topping
                } else {
                    cell.detailTextLabel!.text! = cell.detailTextLabel!.text! + ", " + topping
                }
            }
            break
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
    
    func selectedConfirmButton(sender: UIButton!) {
        // TODO: add to master page
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}

