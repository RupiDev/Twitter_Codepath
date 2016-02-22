//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Rupin Bhalla on 2/21/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController
{

    var tweet: Tweet!
    var user: User!
    
    @IBOutlet weak var backgroundPic: UIImageView!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var numOfTweets: UILabel!
    @IBOutlet weak var numOfFollowing: UILabel!
    @IBOutlet weak var numOfFollowers: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var url = NSURL(string: (tweet.author?.profileImageUrl)!)
        profilePic.setImageWithURL(url!)
        
        if let backgroundStringUrl = tweet.author?.backgroundImageUrl
        {
            var backgroundUrl = NSURL(string: backgroundStringUrl)
            backgroundPic.setImageWithURL(backgroundUrl!)
        }
        else
        {
            let defaultImage = UIImage(named: "twitterLogoBanner.png")
            backgroundPic.image = defaultImage
        }
        
        let numT = (tweet.author?.numTweets)!
        numOfTweets.text = "\(numT)"
        
        let nFing = (tweet.author?.numFollowing)!
        numOfFollowing.text = "\(nFing)"
        
        let nErs = (tweet.author?.numFollowing)!
        numOfFollowers.text = "\(nErs)"
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
