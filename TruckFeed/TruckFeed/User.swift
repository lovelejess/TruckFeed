//
//  FacebookController.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/15/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import CoreData
import FBSDKLoginKit

public struct User
{
    
    static func isLoggedIn() -> Bool {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        print("isLoggedIn: \(isLoggedIn)")
        return isLoggedIn
    }
    
    static func setIsLoggedIn(isLoggedIn: Bool)
    {
        print("setting isLoggedIn to: \(isLoggedIn)")
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
        defaults.synchronize()
    }
    
    static func facebookLogout(){
        FBSDKAccessToken.setCurrent(nil)
        let truckOwner = TruckOwner.sharedInstance
        truckOwner.setFBAccessToken("")
        
        setIsLoggedIn(isLoggedIn: false)
        NSLog("facebookLogout - )")
    }
}
