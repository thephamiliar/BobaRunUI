//
//  BobaRunAPI.swift
//  BobaRunUI
//
//  Created by Joanna Chen on 5/12/16.
//  Copyright © 2016 Jessica Pham. All rights reserved.
//

import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void


class BobaRunAPI: NSObject {
    
    let baseUrl = "http://localhost:5000/"
    
    class var bobaRunSharedInstance : BobaRunAPI {
        struct Static {
            static var token : dispatch_once_t = 0
            static var instance : BobaRunAPI? = nil
        }
        
        dispatch_once(&Static.token) {
            Static.instance = BobaRunAPI()
        }
        return Static.instance!
    }
    
    func createHTTPPostRequest (request: NSMutableURLRequest, onCompletion: (JSON) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
            if (data != nil) {
            }
            if let jsonData = data {
                let json:JSON = JSON(data: jsonData)
                onCompletion(json)
            } else {
                onCompletion(nil)
            }
            
        }
        task.resume()
    }
    
    
    // =============
    // USER CALLS
    // =============
    func createUser(username: String, password: String, email: String, onCompletion: (JSON) -> Void) {
        
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)user/create")!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username + "&password=" + password + "&email=" + email
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    func loginUser(username: String, password: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)login")!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username + "&password=" + password
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    func getUser(username: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)user/show/username")!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
        
    }
    
    func getNumbers(username: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)user/show/numbers")!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    // =============
    // FRIEND CALLS
    // =============
    func getFriends(username: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)friend/show/username")!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    func getFriendsUsingId(id: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)friend/show/id")!)
        request.HTTPMethod = "POST"
        let postString = "id=" + id
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    func addFriend(username: String, friendName: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)friend/show/id")!)
        request.HTTPMethod = "POST"
        let postString = "username=" + username + "&friend_username=" + friendName
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    func addFriendUsing(id: String, friendId: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)friend/show/id")!)
        request.HTTPMethod = "POST"
        let postString = "id=" + id + "&friend_id=" + friendId
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    // =============
    // ROOM CALLS
    // =============
    func createNewRoom(roomName: String, runnerId: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)room/create")!)
        request.HTTPMethod = "POST"
        let postString = "room_name=" + roomName + "&runner_id=" + runnerId
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    func deleteRoom(roomId: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)room/delete")!)
        request.HTTPMethod = "POST"
        let postString = "room_id=" + roomId
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    func addMemberToRoom(roomId: String, memberId: String, drink: String, price: Double, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)room_member/create")!)
        request.HTTPMethod = "POST"
        let p = String(format:"%.1f", price)
        let postString = "room_id=" + roomId + "&member_id=" + memberId + "&drink=" + drink + "&price=" + p
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
    
    
    
    // =============
    // MENU CALLS
    // =============
    func getMenuWithYelpID(yelp_id: String, onCompletion: (JSON) -> Void) {
        let request = NSMutableURLRequest(URL: NSURL(string: "\(baseUrl)menu/show")!)
        request.HTTPMethod = "POST"
        let postString = "yelp_id=" + yelp_id
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        createHTTPPostRequest(request, onCompletion: onCompletion)
    }
    
}