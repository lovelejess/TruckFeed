//
//  MainLoginScreen.swift
//  TruckFeed
//
//  Created by Jessica Le on 4/6/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit

class MainLoginScreen: UIViewController {
    
    var truckOwner:TruckOwner?
    let FBLoginManager = FBSDKLoginManager()
    
    func createButton(title: String, onClick: Selector, frame: CGRect) -> UIButton {
        let button = UIButton(type: UIButtonType.System)
        button.setTitle(title, forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Trebuchet MS", size: 14)
        button.tintColor = lightColor
        button.backgroundColor = darkColor
        button.addTarget(self, action: onClick, forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = frame
        button.setImage(UIImage(named: "facebookLogo.svg"), forState: UIControlState.Normal)
        
        return button
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        truckOwner?.userDefaults = NSUserDefaults.standardUserDefaults()
        self.navigationItem.title = "TruckFeed"
        self.truckOwner = TruckOwner()
        self.view.addSubview(createButton("LOG IN WITH FACEBOOK", onClick: #selector(MainLoginScreen.loginWithFacebookButton), frame: CGRect(x: 90, y: 500, width: 200, height: 50)))
    }
    
    func loginWithFacebookButton()
    {
        FBLoginManager.logInWithPublishPermissions(["publish_actions", "manage_pages"],
                                                   fromViewController: self, handler: { (response:FBSDKLoginManagerLoginResult!, error: NSError!) in
                                                    if(error != nil){
                                                        NSLog("An error occured logging in: \(error)")
                                                    }
                                                    else if(response.isCancelled){
                                                        NSLog("Facebook Login was cancelled")
                                                    }
                                                    else {
                                                        if let accessToken = FBSDKAccessToken.currentAccessToken().tokenString {
                                                            NSLog("Retrieving access token: \(accessToken)")
                                                            self.truckOwner?.setFBAccessToken(accessToken)
                                                            self.truckOwner?.retrieveUserAccessInfoFromFBRequest()
                                                            NSLog("presentFacebookLoginWebView - fbAccessUserId: \(self.truckOwner!.fbAccessUserID) :: \(self.truckOwner!.getUserAccessInfo())")
                                                            self.truckOwner?.retrieveFBPageIDFromFBRequest()
                                                            self.presentDashboardViewController(self)
                                                        }
                                                    }
        })
    }

    
    func presentDashboardViewController(sender: AnyObject){
        if let dashboardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DashboardViewController") as? DashboardViewController {
            self.presentViewController(dashboardViewController, animated: true, completion:
                {
                    dashboardViewController.truckOwner = self.truckOwner
            })
        }
    }

    
}
