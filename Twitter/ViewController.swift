//
//  ViewController.swift
//  Twitter
//
//  Created by Rupin Bhalla on 2/9/16.
//  Copyright © 2016 Rupin Bhalla. All rights reserved.
//

import UIKit
import BDBOAuth1Manager



class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onLogin(sender: AnyObject)
    {
        TwitterClient.sharedInstance.loginWithCompletion()
        {
            (user: User?, error) in
            if (user != nil)
            {
                self.performSegueWithIdentifier("loginSegue", sender: self)
            }
            else
            {
                // handle login error
            }
            
        }
        
        
    }

}

