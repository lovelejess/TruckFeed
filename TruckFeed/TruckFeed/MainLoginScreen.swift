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
    
    var truckOwner = TruckOwner.sharedInstance
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
        self.navigationItem.title = "TruckFeed"
        self.view.addSubview(createButton("LOG IN WITH FACEBOOK", onClick: #selector(MainLoginScreen.loginWithFacebookButton), frame: CGRect(x: 90, y: 500, width: 200, height: 50)))
    }
    
    func loginWithFacebookButton()
    {
        FBLoginManager.logInWithPublishPermissions(["publish_actions", "manage_pages"],
                                                   fromViewController: self,
                                                   handler:
            
                                                    { (response:FBSDKLoginManagerLoginResult!, error: NSError!) in
                                                        if(error != nil){
                                                            NSLog("An error occured logging in: \(error)")
                                                        }
                                                        else if(response.isCancelled){
                                                            NSLog("Facebook Login was cancelled")
                                                        }
                                                        else {
                                                            if let accessToken = FBSDKAccessToken.currentAccessToken().tokenString {
                                                                NSLog("Retrieving access token: \(accessToken)")
                                                                self.truckOwner.setFBAccessToken(accessToken)
                                                                self.executeFacebookRequestOperations()
                                                                self.setFacebookLoggedIn()
                                                            }
                                                        }
                                                    })
    }
    
    func executeFacebookRequestOperations() {
        let queue = NSOperationQueue()
        let facebookRequestOperation = NSBlockOperation(block: {
            self.truckOwner.requestFacebookCredentials()
            NSLog("presentFacebookLoginWebView - fbAccessUserId: \(self.truckOwner.fbAccessUserID) :: \(self.truckOwner.getUserAccessInfo())")
        })
        let presentDashboardViewOperation = NSBlockOperation(block: {
            self.presentDashboardViewController(self)
        })
        presentDashboardViewOperation.addDependency(facebookRequestOperation)
        queue.addOperation(facebookRequestOperation)
        queue.addOperation(presentDashboardViewOperation)
    }

    func presentDashboardViewController(sender: AnyObject){
        NSLog("presentDashboardViewController: for user: \(self.truckOwner.getTruckOwnerName())")
        if let dashboardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DashboardViewController") as? DashboardViewController {
            self.presentViewController(dashboardViewController, animated: true, completion:
                {
                    NSLog("Presenting Dashboard View Controller for user: \(self.truckOwner.getTruckOwnerName())")
                    dashboardViewController.truckOwner = self.truckOwner
            })
        }
    }
    
    func setFacebookLoggedIn()
    {
        let path = NSBundle.mainBundle().pathForResource("App", ofType: "plist")
        let dict = NSMutableDictionary(contentsOfFile: path!)
        dict?.setValue(true, forKey: "LoggedIn")
        dict?.writeToFile(path!, atomically: false)
        NSLog("Setting App.plist file to :\(NSMutableDictionary(contentsOfFile: path!)))")
    }
}
