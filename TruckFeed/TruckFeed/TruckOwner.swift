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
    var fbAccessUserID:String
    
    override init()
    {
        self.userDefaults = NSUserDefaults()
        self.fbAccessToken = ""
        self.fbPageId = ""
        self.fbAccessUserID = String()
        super.init()
    }
    public func retrieveUserAccessInfoFromFBRequest() -> String {
        NSLog("retrieveUserAccessInfoFromFBRequest - getting facebook user access info")
        var fbAccessUserID = String()
        let request = FBSDKGraphRequest(graphPath:"me", parameters: ["fields": "name, email, friends, id"] , HTTPMethod: "GET")
        request.startWithCompletionHandler(
            {
                (connection, result, error) in
                if(error != nil){
                    NSLog("retrieveUserAccessInfoFromFBRequest - Error retrieving fb graph request:  \(error.localizedDescription)")
                }
                else {
                    fbAccessUserID = result.valueForKey("id") as! String
                    NSLog("retrieveUserAccessInfoFromFBRequest - retrieved result successfully. ID:  \(fbAccessUserID)")
                    self.setUserAccessInfoFromFBRequest(fbAccessUserID)
                }
        })
        return fbAccessUserID
    }
    
    public func getUserAccessInfo() -> String {
        return userDefaults.valueForKey("fbAccessUserID") as! String
    }
    
    public func setFBAccessToken(accessToken:String){
        userDefaults.setObject(accessToken, forKey:"accessToken")
        userDefaults.synchronize()
        self.fbAccessToken = accessToken
    }

    public func getFBAccessToken() -> String{
        return userDefaults.valueForKey("accessToken") as! String
    }
    
    public func getFBPageID() -> String {
        NSLog("getFBPageID - getting facebook page id")
        var id = String()
        let request = FBSDKGraphRequest(graphPath:"\(self.getUserAccessInfo())/accounts", parameters: ["fields": "page"] , HTTPMethod: "GET")
        request.startWithCompletionHandler(
            {
                (connection, result, error) in
                if(error != nil){
                    NSLog("getFBPageID - Error retrieving fb graph request:  \(error.localizedDescription)")
                }
                else {
                    NSLog("result: \(result)")
                    id = result.valueForKey("id") as! String
                    NSLog("getFBPageID - retrieved result successfully. ID:  \(id)")
            }
        })
        return id
    }
    
    func setUserAccessInfoFromFBRequest(fbAccessUserID: String)
    {
        userDefaults.setObject(fbAccessUserID, forKey:"fbAccessUserID")
        userDefaults.synchronize()
        self.fbAccessUserID = fbAccessUserID
        NSLog("setUserAccessInfoFromFBRequest - fbAccessUserId: \(fbAccessUserID)")
    }
    
}
