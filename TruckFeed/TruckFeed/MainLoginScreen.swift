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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TruckFeed"
        self.view.addSubview(ViewControllerItems.createButton("LOG IN WITH FACEBOOK", onClick: #selector(MainLoginScreen.loginWithFacebookButton), frame: CGRect(x: 90, y: 500, width: 200, height: 50), target: self))
        self.view.addSubview(ViewControllerItems.createButton("CONTINUE AS A GUEST", onClick: #selector(MainLoginScreen.presentViewController(_:)), frame: CGRect(x: 90, y: 570, width: 200, height: 50), target: self))
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
        if let dashboardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DashboardViewController") as? DashboardViewController {
            self.presentViewController(dashboardViewController, animated: true, completion:
                {
                    NSLog("Presenting Dashboard View Controller for user: \(self.truckOwner.getTruckOwnerName())")
                    dashboardViewController.truckOwner = self.truckOwner
            })
        }
    }
    
    func presentViewController(sender: AnyObject){
        if let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("TruckFeedController") as? TruckFeedController {
            self.presentViewController(viewController, animated: true, completion:
                {
                    NSLog("Presenting Master View Controller")
            })
        }
    }

    
    func setFacebookLoggedIn()
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("App.plist")
        let dict = NSMutableDictionary(contentsOfFile: path)
        dict?.setValue(true, forKey: "LoggedIn")
        dict?.writeToFile(path, atomically: false)
        NSLog("Setting App.plist file to :\(NSMutableDictionary(contentsOfFile: path)))")
    }
}
