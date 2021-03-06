//
//  User.swift
//  Twitter
//
//  Created by Rupin Bhalla on 2/14/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotication = "userDidLoginNotification"
let userDidLogoutNotication = "userDidLogoutNotification"

class User: NSObject
{
    var name: String?
    var screenName: String?
    var profileImageUrl: String?
    var tagline: String?
    var dictionary: NSDictionary
    var backgroundImageUrl: String?
    var numTweets: Int?
    var numFollowing: Int?
    var numFollowers: Int?
    
    init(dictionary: NSDictionary)
    {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        profileImageUrl = dictionary["profile_image_url"] as? String
        tagline = dictionary["description"] as? String;
        
        numFollowers = dictionary["followers_count"] as! Int
        numFollowing = dictionary["friends_count"] as! Int
        numTweets = dictionary["statuses_count"] as! Int
        
        if let testUrl = dictionary["profile_banner_url"] as? String
        {
            backgroundImageUrl = testUrl
        }
    }
    
    func logout()
    {
        User.currentUser = nil;
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotication, object: nil)
        
        
        
    }
    
    class var currentUser: User?
    {
        get
        {
            if _currentUser == nil
            {
                let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil
                {
                    let dictionary: NSDictionary?
                    do
                    {
                        try dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as? NSDictionary
                        _currentUser = User(dictionary: dictionary!)
                    }
                    catch
                    {
                        print(error)
                    }
                }
            }
            return _currentUser
        }
        set(user)
        {
            _currentUser = user
            if let _ = _currentUser
            {
                var data: NSData?
                do
                {
                    try data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: .PrettyPrinted)
                    NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
                }
                catch
                {
                    print(error)
                }
            }
        }
    }
}
