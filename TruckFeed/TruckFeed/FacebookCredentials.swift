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
    
    static func isLoggedIn() -> Bool {
        if let loggedIn = AppPlistHelpers.getAppPlistDictionary().object(forKey: "LoggedIn") as? Bool {
            NSLog("LoggedIn value from App.plist is : \(loggedIn)")
            return loggedIn
        }
        return false
    }
    
    static func setIsLoggedIn()
    {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("App.plist")
        let dict = NSMutableDictionary(contentsOfFile: path)
        dict?.setValue(true, forKey: "LoggedIn")
        dict?.write(toFile: path, atomically: false)
        NSLog("Setting App.plist file to :\(NSMutableDictionary(contentsOfFile: path)))")
    }
    
    static func facebookLogout(){
        FBSDKAccessToken.setCurrent(nil)
        let truckOwner = TruckOwner.sharedInstance
        truckOwner.setFBAccessToken("")
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("App.plist")
        let dict = NSMutableDictionary(contentsOfFile: path)
        dict?.setValue(false, forKey: "LoggedIn")
        dict?.write(toFile: path, atomically: false)
        NSLog("facebookLogout - Setting App.plist file to :\(NSMutableDictionary(contentsOfFile: path)))")
    }

    
    static func setFacebookRequestOperationsQueue(_ facebookRequestOperation: BlockOperation, presentUserViewOperation: BlockOperation ) {
        let queue = OperationQueue()
        presentUserViewOperation.addDependency(facebookRequestOperation)
        queue.addOperation(facebookRequestOperation)
        queue.addOperation(presentUserViewOperation)
    }


}
