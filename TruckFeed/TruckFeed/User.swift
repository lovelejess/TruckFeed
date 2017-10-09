//
//  FacebookController.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/15/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import CoreData
import FBSDKLoginKit

public struct User // TODO: Convert to realm??
{
    
    static func isLoggedIn() -> Bool {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        NSLog("user: isLoggedIn: \(isLoggedIn)")
        return isLoggedIn
    }
    
    static func setIsLoggedIn(isLoggedIn: Bool)
    {
        NSLog("user: setting isLoggedIn to: \(isLoggedIn)")
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
        NSLog("user: setting firstName to: \(firstName)")
        let defaults = UserDefaults.standard
        defaults.set(firstName, forKey: "firstName")
        defaults.synchronize()
    }
    
    static func setLastName(lastName: String) {
        NSLog("user: setting lastName to: \(lastName)")
        let defaults = UserDefaults.standard
        defaults.set(lastName, forKey: "lastName")
        defaults.synchronize()
    }
    
    static func setEmail(email: String) {
        NSLog("user: setting email to: \(email)")
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.synchronize()
    }
    
    static func setId(id: String) {
        NSLog("user: setting id to: \(id)")
        let defaults = UserDefaults.standard
        defaults.set(id, forKey: "id")
        defaults.synchronize()
    }
}
