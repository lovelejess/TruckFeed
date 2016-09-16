//
//  FacebookController.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/15/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import CoreData
import FBSDKLoginKit

public struct FacebookCredentials
{
    
    static func loginWithFacebook(FBLoginManager: FBSDKLoginManager, viewController: UIViewController, handler: () -> ())
    {
        FBLoginManager.logInWithPublishPermissions(["publish_actions", "manage_pages"],
                                                   fromViewController: viewController,
                                                   handler:
            
            { (response:FBSDKLoginManagerLoginResult!, error: NSError!) in
                if(error != nil){
                    NSLog("An error occured logging in: \(error)")
                }
                else if(response.isCancelled){
                    NSLog("Facebook Login was cancelled")
                }
                else {
                    handler()
                }
        })
    }
    
    static func isLoggedIn() -> Bool {
        if let loggedIn = AppPlistHelpers.getAppPlistDictionary().objectForKey("LoggedIn") as? Bool {
            NSLog("LoggedIn value from App.plist is : \(loggedIn)")
            return loggedIn
        }
        return false
    }
    
    static func setIsLoggedIn()
    {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("App.plist")
        let dict = NSMutableDictionary(contentsOfFile: path)
        dict?.setValue(true, forKey: "LoggedIn")
        dict?.writeToFile(path, atomically: false)
        NSLog("Setting App.plist file to :\(NSMutableDictionary(contentsOfFile: path)))")
    }
    
    static func setFacebookRequestOperationsQueue(facebookRequestOperation: NSBlockOperation, presentUserViewOperation: NSBlockOperation ) {
        let queue = NSOperationQueue()
        presentUserViewOperation.addDependency(facebookRequestOperation)
        queue.addOperation(facebookRequestOperation)
        queue.addOperation(presentUserViewOperation)
    }


}
