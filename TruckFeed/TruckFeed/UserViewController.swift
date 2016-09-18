//
//  UserViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/4/15.
//  Copyright (c) 2015 LoveLeJess. All rights reserved.
//

import UIKit
import FBSDKLoginKit

public class UserViewController: UIViewController, UINavigationBarDelegate {

    var truckOwner = TruckOwner.sharedInstance

    override public func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: self.truckOwner.getTruckOwnerName())
        let viewWindow = UserView()
        self.view.opaque = false
        self.view.tintColor = mainColor;
        self.view.addSubview(viewWindow)
        self.view.addSubview(navigationBar)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }

    func presentMainLoginScreen(sender: AnyObject){
        NSLog(" facebookLogout - entering presentMainLoginScreen")
        if let MainLoginScreenController = self.storyboard?.instantiateViewControllerWithIdentifier("MainLoginScreen") as? MainLoginScreenController {
            self.presentViewController(MainLoginScreenController, animated: true, completion:
                {
                    NSLog("facebookLogout - Presenting MainLoginScreen")
            })
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
