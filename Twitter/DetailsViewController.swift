//
//  DetailsViewController.swift
//  Twitter
//
//  Created by Rupin Bhalla on 2/20/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController
{
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleNameLabel: UILabel!
    @IBOutlet weak var bodyText: UITextView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    
    var user: User!
    var tweet: Tweet!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let url = NSURL(string: (tweet.author?.profileImageUrl)!)
        profilePic.setImageWithURL(url!)
        
        nameLabel.text = tweet.author?.name
        handleNameLabel.text = tweet.author?.screenName
        
        
        retweetCount.text = String(tweet.retweetCount!)
        likeCount.text = String(tweet.favoriteCount!)
        bodyText.text = tweet.text
    
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        if segue.identifier == "toComposeFromDetail"
        {
            let reply_id = tweet.tweetID
            let vc = segue.destinationViewController as! ComposeViewController
            vc.reply_id = reply_id
            print(reply_id)
            "\n \n \n"
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    

    
   


}
