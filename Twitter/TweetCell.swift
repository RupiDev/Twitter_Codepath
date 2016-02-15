//
//  TweetCell.swift
//  Twitter
//
//  Created by Rupin Bhalla on 2/14/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell
{
    @IBOutlet weak var profilePicImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    var tweet: Tweet!
    {
        didSet
        {
            nameLabel.text = tweet.author?.name
            bodyLabel.text = tweet.text;
            handleLabel.text = tweet.author?.screenName
            timeStamp.text = tweet.differenceTime();
            let url = NSURL(string: (tweet.author?.profileImageUrl)!)
            profilePicImage.setImageWithURL(url!)
        }
    }
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func likeIncrease(sender: AnyObject)
    {
        TwitterClient.sharedInstance.likeTweetWithId(tweet.tweetID!) { (tweets, error) -> () in
            
        }
    }
    @IBAction func reTweetIncrease(sender: AnyObject)
    {
        TwitterClient.sharedInstance.retweetWithId(tweet.tweetID) { (tweets, error) -> () in
            
        }
    }
}
