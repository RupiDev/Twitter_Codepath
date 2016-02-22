//
//  Tweet.swift
//  Twitter
//
//  Created by Rupin Bhalla on 2/14/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

class Tweet: NSObject
{
    var author: User?
    var text: String?
    var createdAtString: String?
    var createdAt: NSDate?
    var currentTime: NSDate?
    var currentTimeString: String?
    var tweetID: Int?
    var retweetCount: Int?
    var favoriteCount: Int?
    var likeBool: Bool?

    //var test: String?
    
    init(dictionary: NSDictionary)
    {
        author = User(dictionary: (dictionary["user"] as? NSDictionary)!)
        text = dictionary["text"] as? String
        createdAtString = dictionary["created_at"] as? String
        tweetID = dictionary["id"] as? Int;
        
        // Need to format
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        createdAt = formatter.dateFromString(createdAtString!);
        
        currentTime = NSDate();
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        currentTimeString = formatter.stringFromDate(createdAt!)
        
        retweetCount = dictionary["retweet_count"] as? Int
        favoriteCount = dictionary["favorite_count"] as? Int
        
        likeBool = dictionary["favorited"] as? Bool
        

        
        
        
        
    }
    
    class func tweetsWithArray(array: [NSDictionary]) -> [Tweet]
    {
        var tweets = [Tweet]()
        
        for dictionary in array
        {
            tweets.append(Tweet(dictionary: dictionary));
        }
        return tweets;
    }
    
    func differenceTime() -> String
    {
        let elapsedTime = NSDate().timeIntervalSinceDate(createdAt!)
        let time_in_int = NSInteger(elapsedTime)
        let (year, month, day, hours, minutes, seconds) = secondsToHoursMinutesSeconds(time_in_int)
        
        if(year >= 1)
        {
            return ("\(year) years")
        }
        else if(month >= 1)
        {
            return ("\(month) months")
        }
        else if(day >= 1)
        {
            return("\(day) days")
        }
        else if(hours >= 1)
        {
            return("\(hours) hrs")
        }
        else if(minutes > 1)
        {
            return("\(minutes) min")
        }
        else if(seconds > 1)
        {
            return("\(seconds) sec")
        }
        else
        {
            return ""
        }
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int, Int, Int, Int)
    {
        return (seconds / 31536000, seconds / 2628000, seconds / (3600 * 24), seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    
}
