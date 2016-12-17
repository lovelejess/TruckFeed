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
        FBLoginManager.logIn(withPublishPermissions: ["publish_actions", "manage_pages"],
                                                   from: self,
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
        if let accessToken = FBSDKAccessToken.current().tokenString {
            NSLog("Retrieving access token: \(accessToken)")
            self.truckOwner.setFBAccessToken(accessToken)
            
            let facebookRequestOperation = BlockOperation(block: {
                self.truckOwner.requestFacebookCredentials()
                NSLog("presentFacebookLoginWebView - fbAccessUserId: \(self.truckOwner.fbAccessUserID) :: \(self.truckOwner.getUserAccessInfo())")
            })
            let presentUserViewOperation = BlockOperation(block: {
                self.presentMasterViewController(self)
            })
            
            FacebookCredentials.setFacebookRequestOperationsQueue(facebookRequestOperation, presentUserViewOperation: presentUserViewOperation )
            FacebookCredentials.setIsLoggedIn()
        }
    }
    
    func presentTruckFeedController(_ sender: AnyObject){
        if let truckFeedController = self.storyboard!.instantiateViewController(withIdentifier: "TruckFeedController") as? TruckFeedController {
            self.present(truckFeedController, animated: true, completion:
                {
                    NSLog("Presenting Truck Feed Controller")
            })
        }
    }
    
    func presentMasterViewController(_ sender: AnyObject){
        if let viewController = self.storyboard!.instantiateViewController(withIdentifier: "MasterTabViewController") as? MasterTabViewController {
            self.present(viewController, animated: true, completion:
                {
                    NSLog("Presenting Master View Controller")
            })
        }
    }
    
}
