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

class MainLoginScreenController: UIViewController {
    
    var truckOwner = TruckOwner.sharedInstance
    let FBLoginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TruckFeed"
        self.view.addSubview(ViewControllerItems.createButton("LOG IN WITH FACEBOOK", onClick: #selector(MainLoginScreenController.loginWithFacebook), frame: CGRect(x: 90, y: 500, width: 200, height: 50), target: self))
        self.view.addSubview(ViewControllerItems.createButton("CONTINUE AS A GUEST", onClick: #selector(MainLoginScreenController.presentTruckFeedController(_:)), frame: CGRect(x: 90, y: 570, width: 200, height: 50), target: self))
    }
    
    func loginWithFacebook()
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
                    self.handleLogin()
                }
        })
    }
    
    func handleLogin()
    {
        if let accessToken = FBSDKAccessToken.currentAccessToken().tokenString {
            NSLog("Retrieving access token: \(accessToken)")
            self.truckOwner.setFBAccessToken(accessToken)
            
            let facebookRequestOperation = NSBlockOperation(block: {
                self.truckOwner.requestFacebookCredentials()
                NSLog("presentFacebookLoginWebView - fbAccessUserId: \(self.truckOwner.fbAccessUserID) :: \(self.truckOwner.getUserAccessInfo())")
            })
            let presentUserViewOperation = NSBlockOperation(block: {
                self.presentMasterViewController(self)
            })
            
            FacebookCredentials.setFacebookRequestOperationsQueue(facebookRequestOperation, presentUserViewOperation: presentUserViewOperation )
            FacebookCredentials.setIsLoggedIn()
        }
    }
    
    func presentTruckFeedController(sender: AnyObject){
        if let truckFeedController = self.storyboard!.instantiateViewControllerWithIdentifier("TruckFeedController") as? TruckFeedController {
            self.presentViewController(truckFeedController, animated: true, completion:
                {
                    NSLog("Presenting Truck Feed Controller")
            })
        }
    }
    
    func presentMasterViewController(sender: AnyObject){
        if let viewController = self.storyboard!.instantiateViewControllerWithIdentifier("MasterTabViewController") as? MasterTabViewController {
            self.presentViewController(viewController, animated: true, completion:
                {
                    NSLog("Presenting Master View Controller")
            })
        }
    }
    
}
