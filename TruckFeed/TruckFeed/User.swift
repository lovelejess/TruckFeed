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
        print("user: isLoggedIn: \(isLoggedIn)")
        return isLoggedIn
    }
    
    static func setIsLoggedIn(isLoggedIn: Bool)
    {
        print("user: setting isLoggedIn to: \(isLoggedIn)")
        let defaults = UserDefaults.standard
        defaults.set(isLoggedIn, forKey: "isLoggedIn")
        defaults.synchronize()
    }
    
    static func facebookLogout(){
        FBSDKAccessToken.setCurrent(nil)
        let truckOwner = TruckOwner.sharedInstance
        truckOwner.setFBAccessToken("")
        
        setIsLoggedIn(isLoggedIn: false)
        NSLog("user: facebookLogout")
    }
    
    static func setFirstName(firstName: String) {
        print("user: setting name to: \(firstName)")
        let defaults = UserDefaults.standard
        defaults.set(firstName, forKey: "firstName")
        defaults.synchronize()
    }
}
