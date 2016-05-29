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
    case Price
}

class OrderFormViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var menuItems: [Drink] = []
    var filteredDrinks = [Drink]()
    var menu = [String:[Drink]]()
    var toppingItems: [Drink] = []
    var selectedType : NSIndexPath?
    var selectedSugarLevel : UIButton?
    var selectedIceLevel : UIButton?
    let formViewCellReuseIdentifier = "formViewCellReuseIdentifier"
    let searchController = UISearchController(searchResultsController: nil)
    let buttonHeight = CGFloat(30)
    let buttonWidth = CGFloat(40)
    let buttonPadding = CGFloat(20)
    let footerHeight = CGFloat(80)
    let submitButtonHeight = CGFloat(50)
    var room : Room = Room()
    var user : User = User()
    var roomId : String = ""
    
    var tableView : UITableView!
    
    init(user: User, room: Room) {
        self.room = room
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    init(user: User, roomId: String) {
        self.roomId = roomId
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required  init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewWillAppear(animated: Bool) {
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
                                    self.menuItems.append(drink_temp)
                                    // self.menuItems.append(drink_temp.name!)
                                    // self.menuPrices.append("$" + String(format: "%.2f", drink_temp.price!))
                                }
                                
                            }
                        }
                        let temp = self.menu["Toppings"]
                        for drink in temp! {
                            self.toppingItems.append(drink)
                            // self.toppingPrices.append("$" + String(format: "%.2f", drink.price!))
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
        submitButton.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
        submitButton.addTarget(self, action: #selector(OrderFormViewController.selectedSubmitButton(_:)), forControlEvents: .TouchUpInside)
        submitButton.layer.cornerRadius = 5
        self.view.addSubview(submitButton)
        
        searchController.searchBar.scopeButtonTitles = ["Milk Tea", "Fruity", "Yakult", "Slushies"]
        searchController.searchBar.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationItem.title = "BobaRun"
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
            if searchController.active && searchController.searchBar.text != "" {
                numRows = filteredDrinks.count
            } else {
                numRows = menuItems.count
            }
            
            break
        case OrderSection.SugarLevel.rawValue, OrderSection.IceLevel.rawValue:
            numRows = 1
            break
        case OrderSection.Toppings.rawValue:
            numRows = toppingItems.count+1
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
            let drink: Drink
            if searchController.active && searchController.searchBar.text != "" {
                drink = filteredDrinks[indexPath.row]
            } else {
                drink = menuItems[indexPath.row]
            }
            cell.textLabel?.text = drink.name! as? String
            cell.detailTextLabel?.text = "$" + String(format: "%.2f", drink.price!)
            break
        case OrderSection.SugarLevel.rawValue:
            generatePercentageButtons(OrderSection.SugarLevel, cell: cell)
            break
        case OrderSection.IceLevel.rawValue:
            generatePercentageButtons(OrderSection.IceLevel, cell: cell)
            break
        case OrderSection.Toppings.rawValue:
            if (indexPath.row < toppingItems.count) {
                cell.textLabel?.text = toppingItems[indexPath.row].name
                cell.detailTextLabel?.text = "$" + String(format: "%.2f", toppingItems[indexPath.row].price!)
            } else {
                cell.textLabel?.text = "None"
                cell.detailTextLabel?.text = "$0.00"
            }
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
            let button: PercentageButton = PercentageButton(frame: CGRectMake(currXPos + buttonPadding, cell.bounds.minY+8, buttonWidth, buttonHeight))
            button.setTitle(String(buttonNum) + "%", forState: UIControlState.Normal)
            button.titleLabel!.font = UIFont.systemFontOfSize(UIFont.smallSystemFontSize())
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
            sender.backgroundColor = UIColor(red: 0, green: 122/255, blue: 1, alpha: 1)
            sender.selected = true
        }
    }
    
    func selectedSubmitButton(sender: UIButton!) {
        let order = Order()
        order.price = 0.0
        let tableSelections = tableView.indexPathsForSelectedRows
        if (tableSelections != nil && selectedSugarLevel != nil && selectedIceLevel != nil) {
            for indexPath in tableSelections! {
                    if indexPath.section == OrderSection.TeaType.rawValue {
                        let drink: Drink
                        if searchController.active && searchController.searchBar.text != "" {
                            drink = filteredDrinks[indexPath.row]
                        } else {
                            drink = menuItems[indexPath.row]
                        }
                        order.teaType = drink.name!
                        order.price = order.price + drink.price!
                    } else if indexPath.section == OrderSection.Toppings.rawValue {
                        if (indexPath.row < toppingItems.count) {
                            order.toppings.append(toppingItems[indexPath.row].name!)
                            order.price = order.price + toppingItems[indexPath.row].price!

                        } else {
                            order.toppings.append("None")
                        }
                    }
            }
            order.sugarLevel = selectedSugarLevel!.titleLabel!.text!
            order.iceLevel = selectedIceLevel!.titleLabel!.text!
            if (self.roomId == "") {
                let confirmationViewController = OrderConfirmationViewController(order: order, room: room, user: user, confirmButton: true)
                self.navigationController?.pushViewController(confirmationViewController, animated: true)
            }
            else {
                let confirmationViewController = OrderConfirmationViewController(order: order, roomId: roomId, user: user, confirmButton: true)
                self.navigationController?.pushViewController(confirmationViewController, animated: true)
            }

        } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Order Incomplete!"
            alertView.message = "Please fill out complete form."
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
        }
    }
    
    func categoryMatcher(drinkCategory: String, scope: String) -> Bool {
        // ["Milk Tea", "Fruity", "Yakult", "Slushies"]
        if (scope == "Milk Tea") {
            return drinkCategory == "Tea & Milk Tea" || drinkCategory == "Whipped Cream" || drinkCategory == "Tea Latte" || drinkCategory == "Chocolate" || drinkCategory == "Fresh Milk"
        }
    
        if (scope == "Fruity") {
            return drinkCategory == "Fresh Fruit" || drinkCategory == "Mixed Juice"
        }
        
        if (scope == "Yakult") {
            return drinkCategory == "Yakult"
        }
        
        if (scope == "Slushies") {
            return drinkCategory == "Slush & Smoothie"
        }
        return true
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredDrinks = menuItems.filter { drink in
            let categoryMatch = (scope == "All") || categoryMatcher(drink.category!, scope: scope)
            return categoryMatch && drink.name!.lowercaseString.containsString(searchText.lowercaseString)
        }
        tableView.reloadData()
    }
    
}



extension OrderFormViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension OrderFormViewController: UISearchBarDelegate {
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
