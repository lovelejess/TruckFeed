//
//  LoginModalViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/4/15.
//  Copyright (c) 2015 LoveLeJess. All rights reserved.
//

import UIKit

public class LoginModalViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBAction func loginCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    override public func viewDidLoad() {
        super.viewDidLoad()
        let fbLoginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(fbLoginView)
        fbLoginView.center = self.view.center
        fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        fbLoginView.delegate = self
    }
    
    public func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        println("User Logged In")
    }
    
    public func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        println("User Logged Out")
    }

    override public func didReceiveMemoryWarning() {
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
