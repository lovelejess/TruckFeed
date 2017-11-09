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

class MainLoginScreenController: UIViewController, UIPopoverControllerDelegate, UIPopoverPresentationControllerDelegate {
    let FBLoginManager = FBSDKLoginManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TruckFeed"
        self.view.addSubview(ViewControllerItems.createButton("TRUCK OWNER", onClick: #selector(MainLoginScreenController.loginWithFacebook), frame: CGRect(x: 90, y: 500, width: 200, height: 50), target: self))
        self.view.addSubview(ViewControllerItems.createButton("TRUCK CONSUMER", onClick: #selector(MainLoginScreenController.presentTruckFeedController(_:)), frame: CGRect(x: 90, y: 570, width: 200, height: 50), target: self))
    }

    
    func loginWithFacebook()
    {
        FBLoginManager.logIn(withPublishPermissions: ["publish_actions", "manage_pages"],
                                                   from: self,
                                                   handler:
            
            { (result, error) in
                if(error != nil){
                    NSLog("An error occured logging in: \(error!)")
                }
                else if(result! as FBSDKLoginManagerLoginResult).isCancelled == true {
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
            NSLog("handleLogin - Retrieved user access token: \(accessToken)")
            User.setFBAccessToken(accessToken)
            
            let setFBUserInfoOperation = BlockOperation(block: {
                FacebookAPI.setFBUserInfo()
            })
            
            let presentUserViewOperation = BlockOperation(block: {
                self.presentMasterViewController(self)
            })
            
            let presentVerifyTruckOwnerOperation = BlockOperation(block: {
//                self.presentVerifyTruckAlertView()
                self.presentVerifyTruckOwnerController(self)
            })
            
            FacebookAPI.setFacebookRequestOperationsQueue(setFBUserInfoOperation: setFBUserInfoOperation, presentUserViewOperation: presentVerifyTruckOwnerOperation )
            
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
    
    func presentVerifyTruckOwnerController(_ sender: AnyObject){
        if let viewController = self.storyboard!.instantiateViewController(withIdentifier: "VerifyTruckOwnerController") as? VerifyTruckOwnerController {
            self.present(viewController, animated: true, completion:
                {
                    NSLog("Presenting Verify Truck Owner Controller")
            })
        }
    }
    
}
