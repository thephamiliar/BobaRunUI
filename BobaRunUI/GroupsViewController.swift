//
//  GroupsViewController.swift
//  BobaRunUI
//
//  Created by Hoa Pham on 5/16/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import UIKit

class GroupsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var collectionView: UICollectionView!
    var groups : [Group]!
    let groupViewCellReuseIdentifier = "groupViewCellReuseIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Groups"
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(GroupsViewController.addNewGroup(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        // TODO: populate groups from Backend
        let testFriend = User()
        testFriend.firstName = "Jessica"
        testFriend.lastName = "Pham"
        testFriend.username = "jmpham613"
        testFriend.image = UIImage(named: "faithfulness")!
        let testFriend2 = User()
        testFriend2.firstName = "Joanna"
        testFriend2.lastName = "Chen"
        testFriend2.username = "jchen94"
        testFriend2.image = UIImage(named: "faithfulness")!
        let testFriend3 = User()
        testFriend3.firstName = "Nick"
        testFriend3.lastName = "Yu"
        testFriend3.username = "nyu"
        testFriend3.image = UIImage(named: "faithfulness")!
        let testFriend4 = User()
        testFriend4.firstName = "Louis"
        testFriend4.lastName = "Truong"
        testFriend4.username = "ltroung"
        testFriend4.image = UIImage(named: "faithfulness")!
        var testGroup = Group()
        testGroup.groupName = "CSM117 :D"
        testGroup.groupTimeStamp = "05/16/16"
        testGroup.users = [testFriend, testFriend2, testFriend3, testFriend4]
        testGroup.image = UIImage(named: "love")!
        groups = [testGroup]
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 130, height: 150)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.registerClass(GroupCollectionViewCell.self, forCellWithReuseIdentifier: groupViewCellReuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        self.view.addSubview(collectionView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(groupViewCellReuseIdentifier, forIndexPath: indexPath) as! GroupCollectionViewCell
        
        cell.groupLabel!.text = groups[indexPath.row].groupName
        cell.imageView!.image = groups[indexPath.row].image
        cell.imageView!.layer.masksToBounds = true;
        cell.groupTimeStampLabel!.text = groups[indexPath.row].groupTimeStamp
        
        let users = groups[indexPath.row].users
        cell.groupMembers!.text = users[0].firstName
        if (users.count > 1) {
            var index = 1
            while (index < 8 && index < users.count) {
                cell.groupMembers!.text = cell.groupMembers!.text! + ", " + (users[index].firstName! as String)
                index += 1
            }
        }
        if (users.count > 8) {
            cell.groupMembers!.text = cell.groupMembers!.text! + " +" + String(users.count-8)
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let groupViewController = GroupViewController()
        groupViewController.group = groups[indexPath.row]
        groupViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(groupViewController, animated: true)
    }
    
    func addNewGroup(sender: AnyObject) {
        let newGroupViewController = NewGroupViewController()
        newGroupViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(newGroupViewController, animated: true)
    }
}
