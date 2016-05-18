//
//  OrderFormViewController.swift
//  BobaRun
//
//  Created by Hoa Pham on 4/17/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit

// TODO: confirm required fields before going to confirmation page
// TODO: editable table row for toppings

enum OrderSection : Int {
    case TeaType = 0
    case SugarLevel
    case IceLevel
    case Toppings
}

class OrderFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var menuItems: [String] = []
    var menuPrices: [String] = []
    var menu = [String:[Drink]]()
    var toppingItems: [String] = []
    var toppingPrices: [String] = []
    var selectedType : NSIndexPath?
    var selectedSugarLevel : UIButton?
    var selectedIceLevel : UIButton?
    let formViewCellReuseIdentifier = "formViewCellReuseIdentifier"
    let buttonHeight = CGFloat(35)
    let buttonWidth = CGFloat(50)
    let buttonPadding = CGFloat(20)
    let footerHeight = CGFloat(80)
    let submitButtonHeight = CGFloat(50)
    
    var tableView : UITableView!
    
    override func viewWillAppear(animated: Bool) {
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
        
        let submitButton: UIButton = UIButton(frame: CGRectMake(0, CGRectGetMaxY(tableFrame), self.view.frame.width-30, submitButtonHeight))

        submitButton.center = footerView.center
        submitButton.setTitle("Submit", forState: UIControlState.Normal)
        submitButton.backgroundColor = UIColor(red: 127/255, green: 72/255, blue: 140/255, alpha: 1)
        submitButton.addTarget(self, action: #selector(OrderFormViewController.selectedSubmitButton(_:)), forControlEvents: .TouchUpInside)
        submitButton.layer.cornerRadius = 5
        self.view.addSubview(submitButton)
        BobaRunAPI.bobaRunSharedInstance.getMenuWithYelpID("CoCo Westwood") { (json: JSON) in
            print ("getting menu")
            if let creation_error = json["error"].string {
                if creation_error == "true" {
                    print ("No menu available.")
                }
                else {
                    print ("populating menu")
                    if let results = json["result"].array {
                        for entry in results {
                            if let category = entry["category"].string {
                                if (self.menu[category] != nil) {
                                    self.menu[category]!.append(Drink(json: entry))
                                }
                                else {
                                    var temp = [Drink]()
                                    temp.append(Drink(json: entry))
                                    self.menu[category] = temp
                                }
                                
                                if (category != "Toppings") {
                                    let drink_temp = Drink(json: entry)
                                    self.menuItems.append(drink_temp.name!)
                                    self.menuPrices.append("$" + String(drink_temp.price!))
                                }
                                
                            }
                        }
                        let temp = self.menu["Toppings"]
                        for drink in temp! {
                            self.toppingItems.append(drink.name!)
                            self.toppingPrices.append("$" + String(drink.price!))
                        }
                        dispatch_async(dispatch_get_main_queue(),{
                            self.tableView.reloadData()
                        })

                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        navigationItem.title = "BobaRun"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        nav?.titleTextAttributes = (titleDict as! [String : AnyObject])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionHeader = ""
        
        switch (section) {
        case OrderSection.TeaType.rawValue:
            sectionHeader = "Type"
            break
        case OrderSection.SugarLevel.rawValue:
            sectionHeader = "Sugar Level"
            break
        case OrderSection.IceLevel.rawValue:
            sectionHeader = "Ice Level"
            break
        case OrderSection.Toppings.rawValue:
            sectionHeader = "Toppings"
            break
        default:
            sectionHeader = "Other"
            break
        }
        
        return sectionHeader
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var numRows = 0
        
        switch (section) {
        case OrderSection.TeaType.rawValue:
            numRows = menuItems.count
            break
        case OrderSection.SugarLevel.rawValue, OrderSection.IceLevel.rawValue:
            numRows = 1
            break
        case OrderSection.Toppings.rawValue:
            numRows = toppingItems.count
            break
        default:
            numRows = 0
            break
        }
        
        return numRows
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: formViewCellReuseIdentifier)
        
        switch (indexPath.section) {
        case OrderSection.TeaType.rawValue:
            cell.textLabel?.text = menuItems[indexPath.row] as? String
            cell.detailTextLabel?.text = menuPrices[indexPath.row] as? String
            break
        case OrderSection.SugarLevel.rawValue:
            generatePercentageButtons(OrderSection.SugarLevel, cell: cell)
            break
        case OrderSection.IceLevel.rawValue:
            generatePercentageButtons(OrderSection.IceLevel, cell: cell)
            break
        case OrderSection.Toppings.rawValue:
            cell.textLabel?.text = toppingItems[indexPath.row]
            cell.detailTextLabel?.text = toppingPrices[indexPath.row]
            break
        default:
            cell.textLabel?.text = "Other"
        }
        
        cell.selectionStyle = .None
        return cell
    }
    
    func generatePercentageButtons(section: OrderSection, cell: UITableViewCell) {
        var buttonNum = 0
        var currXPos = CGFloat(0)
        
        while buttonNum <= 100 {
            let button: PercentageButton = PercentageButton(frame: CGRectMake(currXPos + buttonPadding, cell.bounds.minY+5, buttonWidth, buttonHeight))
            button.setTitle(String(buttonNum) + "%", forState: UIControlState.Normal)
            button.tag = section.rawValue
            button.addTarget(self, action: #selector(OrderFormViewController.selectedButton(_:)), forControlEvents: .TouchUpInside)
            cell.contentView.addSubview(button)
            
            buttonNum += 25
            currXPos = button.frame.maxX
        }
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if indexPath.section == 3 {
            return true
        } else if indexPath.section == 0 && selectedType != indexPath {
            if selectedType != nil {
                tableView.deselectRowAtIndexPath(selectedType!, animated: false)
                tableView.cellForRowAtIndexPath(selectedType!)?.accessoryType = UITableViewCellAccessoryType.None
            }
            tableView.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
            tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
            selectedType = indexPath
            return false
        }
        return false
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.cellForRowAtIndexPath(indexPath)?.accessoryType = UITableViewCellAccessoryType.None
    }
    
    func selectedButton(sender: UIButton!) {
        if sender.selected {
            sender.backgroundColor = UIColor.whiteColor()
            sender.selected = false
            if sender.tag == OrderSection.SugarLevel.rawValue {
                selectedSugarLevel = nil
            } else {
                selectedIceLevel = nil
            }
        } else {
            if sender.tag == OrderSection.SugarLevel.rawValue {
                selectedSugarLevel?.backgroundColor = UIColor.whiteColor()
                selectedSugarLevel?.selected = false
                selectedSugarLevel = sender
            } else {
                selectedIceLevel?.backgroundColor = UIColor.whiteColor()
                selectedIceLevel?.selected = false
                selectedIceLevel = sender
            }
            sender.backgroundColor = UIColor(red: 127/255, green: 72/255, blue: 140/255, alpha: 1)
            sender.selected = true
        }
    }
    
    func selectedSubmitButton(sender: UIButton!) {
        var order = Order()
        let tableSelections = tableView.indexPathsForSelectedRows!
            for indexPath in tableSelections {
                if indexPath.section == OrderSection.TeaType.rawValue {
                    let selectedCell = tableView.cellForRowAtIndexPath(indexPath )
                    order.teaType = selectedCell!.textLabel!.text!
                } else if indexPath.section == OrderSection.Toppings.rawValue {
                    let selectedCell = tableView.cellForRowAtIndexPath(indexPath )
                    order.toppings.append(selectedCell!.textLabel!.text!)
                }
        }
        order.sugarLevel = selectedSugarLevel!.titleLabel!.text!
        order.iceLevel = selectedIceLevel!.titleLabel!.text!
        
        // TODO: Send order to database (roomid, member, drink)
        
        let confirmationViewController = OrderConfirmationViewController(order: order)
        self.navigationController?.pushViewController(confirmationViewController, animated: true)
    }
    
}

