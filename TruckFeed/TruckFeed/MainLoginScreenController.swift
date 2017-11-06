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
        let popoverContent = self.storyboard!.instantiateViewController(withIdentifier: "VerifyTruckOwnerController") as! VerifyTruckOwnerController
        popoverContent.modalPresentationStyle = .popover
        if let popover = popoverContent.popoverPresentationController {
            popover.sourceView = self.view
            popover.permittedArrowDirections = UIPopoverArrowDirection.init(rawValue: 0)
            popover.sourceRect = CGRect(x: self.view.bounds.width/2, y: self.view.bounds.height/2, width: 1, height: 1)
            popoverContent.preferredContentSize = CGSize(width: 300, height: 400)
            popover.delegate = self
        }
        
        self.present(popoverContent, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.none
    }
    
    
    func presentVerifyTruckAlertView() {
        if let _: AnyClass = NSClassFromString("UIAlertController") {
            let myAlert: UIAlertController = UIAlertController(title: "Verify Food Truck", message: "Select the name of the food truck linked to your Facebook Page account", preferredStyle: .actionSheet)
            
            let action1 = UIAlertAction(title: "Action 1", style: .default, handler: { (action) -> Void in
                print("ACTION 1 selected!")
                self.presentMasterViewController(self)
            })
            
            let action2 = UIAlertAction(title: "Action 2", style: .default, handler: { (action) -> Void in
                print("ACTION 2 selected!")
                self.presentMasterViewController(self)
            })
            
            let action3 = UIAlertAction(title: "Action 3", style: .default, handler: { (action) -> Void in
                print("ACTION 3 selected!")
                self.presentMasterViewController(self)
            })
            
            let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: { (action) -> Void in })
            myAlert.view.layer.cornerRadius = 25
            myAlert.addAction(action1)
            myAlert.addAction(action2)
            myAlert.addAction(action3)
            myAlert.addAction(cancel)

            self.present(myAlert, animated: true, completion: nil)
        }
    }
    
}
