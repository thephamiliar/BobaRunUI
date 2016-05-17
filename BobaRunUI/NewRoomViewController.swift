//
//  NewRoomViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/4/16.
//  Copyright (c) 2016 Jessica Pham. All rights reserved.
//

import UIKit

class NewRoomViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let navBar = self.navigationController?.navigationBar
        navBar!.barTintColor = UIColor(red: 98/255, green: 40/255, blue: 112/255, alpha: 1)
        navigationItem.title = "New Room"
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        navBar?.titleTextAttributes = (titleDict as! [String : AnyObject])
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
