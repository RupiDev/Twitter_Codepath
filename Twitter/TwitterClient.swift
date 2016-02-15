//
//  TwitterClient.swift
//  Twitter
//
//  Created by Rupin Bhalla on 2/9/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "mmPURpKi4bXej5Xea4LdYoWEm";
let twitterConsumerSecret = "jJ7vnppa8T0CtykJtsOvmAC6AiMpDo5NJPpwEeMvA1azOncfhg";
let twitterBaseURL = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager
{
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: TwitterClient
    {
        struct Static
        {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) ->())
    {
        GET("1.1/statuses/home_timeline.json", parameters: params, success: { (NSURLSessionDataTask, response: AnyObject?) -> Void in
            
            //print("home timeline: \(response)");
            var tweets = Tweet.tweetsWithArray(response as! [NSDictionary]);
            completion(tweets: tweets, error: nil)
            
            for tweet in tweets
            {
                print("text: \(tweet.text), created: \(tweet.createdAt)");
            }
            
            
            },
        failure: { (NSURLSessionDataTask, error) -> Void in
                
            print("error getting home timeline");
            //self.loginCompletion?(user: nil, error: error)
            completion(tweets: nil, error: error)

            
        })
    }
    
    func loginWithCompletion(completion: (user: User?, error: NSError?) -> ())
    {
        loginCompletion = completion;
        
        
        // Fetch Request Token & redirect to authorization page
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken();
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            
            print("Got the request token");
            var authurl = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authurl!);
            
            })
            { (error) -> Void in
                print("Error getting the request token \(error)")
                self.loginCompletion?(user: nil, error: error)
                
        }
        
    }
    
    func openURL(url: NSURL)
    {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            
            print("got the access token");
            
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (NSURLSessionDataTask, response: AnyObject?) -> Void in
                
                //print("user: \(response)");
                var user = User(dictionary: response as! NSDictionary)
                User.currentUser = user
                //print("user: \(user.name)")
                self.loginCompletion?(user: user, error: nil)
                
                },
                failure: { (NSURLSessionDataTask, error) -> Void in
                    
                    print("error getting the current user");
                    self.loginCompletion?(user: nil, error: error)

                    
            })
            
            
            
        }) { (error) -> Void in
            print("Fail to recieve access token");
            self.loginCompletion?(user: nil, error: error)

                
                
        }

    }
    
    /*func like(id: Int?, completion: (tweets: [Tweet]?, error: NSError?) -> ())
    {
        POST("1.1/favorites/create.json?=\(id)", parameters: nil, success: { (NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("success liking")
            
            },
            failure: { (NSURLSessionDataTask, error) -> Void in
                
                print("failure in liking");
                print(id);
                print("1.1/favorites/create.json?=\(id)")
                //self.loginCompletion?(user: nil, error: error)
                
        })
    }*/
    
    func likeTweetWithId(id: Int?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        POST("1.1/favorites/create.json?id=\(id!)", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("success liking")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error liking\(id!)")
        })
    }
    
    func retweetWithId(id: Int?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\(id!).json", parameters: nil, success: { (operation: NSURLSessionDataTask!, response: AnyObject?) -> Void in
            print("success retweet")
            }, failure: { (operation: NSURLSessionDataTask?, error: NSError!) -> Void in
                print("error retweet\(id!)")
        })
    }
    
    
    
    
    
    
}
