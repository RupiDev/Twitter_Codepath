//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Rupin Bhalla on 2/18/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var tweetTextView: UITextView!
    @IBOutlet weak var countLabel: UIBarButtonItem!
    
    
    
    var user: User!
    var maxText: String!
    var reply_id: Int?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        nameLabel.text = User.currentUser?.name
        userNameLabel.text = User.currentUser?.screenName
        let url = NSURL(string: (User.currentUser?.profileImageUrl)!)
        profilePicImageView.setImageWithURL(url!)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        
    }
    @IBAction func endKeyboard(sender: AnyObject)
    {
        self.view.endEditing(true);
    }
    
    
    @IBAction func tweetPostAction(sender: AnyObject)
    {
        var post =  "?status=" + tweetTextView.text!.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)
        //?status=\(status)
        
        if(reply_id != nil)
        {
            post += "&in_reply_to_status_id=\(reply_id!)"
        }
        
        TwitterClient.sharedInstance.postTweet(post)
        
    }
    
    func textViewDidChange(textView: UITextView)
    {
        var characterCount = Int(textView.text.characters.count)
        
        countLabel.title = "\(140 - characterCount)"
        
        
        if(characterCount == 140)
        {
            maxText = textView.text;
        }
        
        if(characterCount > 140)
        {
            countLabel.title = "0"
            
            let alertController = UIAlertController(title: "Over 140 Characters", message: "Can't tweet more", preferredStyle: UIAlertControllerStyle.Alert)
            
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
            
            textView.text = maxText;
            
            
        }
        
        
        
        
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
