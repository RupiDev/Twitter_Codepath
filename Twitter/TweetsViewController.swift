//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Rupin Bhalla on 2/14/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    var isMoreDataLoading: Bool!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        
        TwitterClient.sharedInstance.homeTimelineWithParams(nil) { (tweets, error) -> () in
            self.tweets = tweets
            self.tableView.reloadData();
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogout(sender: AnyObject)
    {
        User.currentUser!.logout();
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        if let tweets = tweets
        {
            return tweets.count;
        }
        else
        {
            return 0;
        }
    }
 
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TweetCell;
        
        var tweet = tweets![indexPath.row]
        
        cell.tweet = tweet;
                
        return cell;
        
    }

    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        var tweet: Tweet
        if segue.identifier == "TweetsToDetail"
        {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            tweet = tweets![(indexPath?.row)!]
        
            let detailsViewController = segue.destinationViewController as! DetailsViewController
            detailsViewController.tweet = tweet
            
            print("\n \n \n \n \n")
            print("HELLO")
        }
        
        if segue.identifier == "timelineToProfile"
        {
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! UITableViewCell
            
            let indexPath = tableView.indexPathForCell(cell)
            tweet = tweets![(indexPath?.row)!]
            let profileViewController = segue.destinationViewController as? ProfileViewController
            profileViewController!.tweet = tweet
            
            
            
        }
        //detailsViewController.movies = movie
        
    }
    
    
   
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
