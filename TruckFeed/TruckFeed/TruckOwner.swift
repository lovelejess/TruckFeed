//
//  TruckOwner.swift
//  TruckFeed
//
//  Created by Jessica Le on 2/29/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit.FBSDKGraphRequest

public class TruckOwner: NSObject {
    var fbAccessToken:String?
    var userDefaults:NSUserDefaults
    var fbPageId:String?
    var fbAccessUserInfo:NSDictionary
    
    override init()
    {
        self.userDefaults = NSUserDefaults()
        self.fbAccessToken = ""
        self.fbPageId = ""
        self.fbAccessUserInfo = TruckOwner.retrieveUserAccessInfoFromFBRequest()
        super.init()
    }
    
    class func retrieveUserAccessInfoFromFBRequest() -> NSDictionary {
        NSLog("getUserAccessInfo - getting facebook page id")
        var userAccessInfo = NSDictionary()
        let request = FBSDKGraphRequest(graphPath:"me", parameters: ["fields": "name, email, friends, id"] , HTTPMethod: "GET")
        request.startWithCompletionHandler(
            {
                (connection, result, error) in
                if(error != nil){
                    NSLog(error.localizedDescription)
                }
                else {
                    userAccessInfo = result as! NSDictionary
                    NSLog("getUserAccessInfo - retrieved result successfully: \((result.valueForKey("id")) as! String)")
                }
        })
        return userAccessInfo
    }
    
    public func getUserAccessInfo() -> NSDictionary {
        return self.fbAccessUserInfo
    }
    
    public func setFBAccessToken(accessToken:String){
        userDefaults.setObject(accessToken, forKey:"accessToken")
        userDefaults.synchronize()
        self.fbAccessToken = accessToken
    }

    public func getFBAccessToken() -> String{
        return self.fbAccessToken!
    }
}
