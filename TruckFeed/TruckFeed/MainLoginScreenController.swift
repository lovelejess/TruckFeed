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
            
            { (result, error) in
                if(error != nil){
                    NSLog("An error occured logging in: \(error)")
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
            NSLog("Retrieving access token: \(accessToken)")
            self.truckOwner.setFBAccessToken(accessToken)
            
            let facebookRequestOperation = BlockOperation(block: {
                let fbAccessToken:String = FacebookAPI.requestFacebookCredentials()
                NSLog("retrieveUserAccessInfoFromFBRequest - retrieved result successfully. ID:  \(fbAccessToken)")
                self.truckOwner.setUserAccessInfoFromFBRequest(fbAccessToken)
                let facebookPageResponse = FacebookAPI.retrieveFBPageIDFromFBRequest(userAccessInfo: self.truckOwner.getFBAccessToken())
                self.truckOwner.setFBPageID(self.parsePageIDFromResponse(facebookPageResponse: facebookPageResponse))
                self.truckOwner.setTruckOwnerName(self.parseNameFromResponse(facebookPageResponse: facebookPageResponse))
                NSLog("presentFacebookLoginWebView - fbAccessUserId: \(self.truckOwner.fbAccessUserID) :: \(self.truckOwner.getUserAccessInfo())")
            })
            let presentUserViewOperation = BlockOperation(block: {
                self.presentMasterViewController(self)
            })
            
            FacebookAPI.setFacebookRequestOperationsQueue(facebookRequestOperation, presentUserViewOperation: presentUserViewOperation )
            User.setIsLoggedIn(isLoggedIn: true)
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
    
    private func parseNameFromResponse(facebookPageResponse: NSArray) -> String {
        var name = ""
        if let data = facebookPageResponse.firstObject as AnyObject? {
            if let parsedName = data.value(forKey: "name") as? String {
                NSLog("getFBPageID - retrieved name successfully. name:  \(parsedName)")
                name = parsedName
            }
        }
        return name
    }
    
    private func parsePageIDFromResponse(facebookPageResponse: NSArray) -> String {
        var id = ""
        if let data = facebookPageResponse.firstObject as AnyObject? {
            if let parsedID = data.value(forKey: "id") as? String {
                NSLog("getFBPageID - retrieved id successfully. ID:  \(id)")
                id = parsedID
            }
        }
        return id
    }
    
}
