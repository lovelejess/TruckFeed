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
    var fbAccessToken:String
    var userDefaults:NSUserDefaults
    var fbPageId:String
    var fbAccessUserID:String
    var name:String
    
    override init()
    {
        self.userDefaults = NSUserDefaults()
        self.fbAccessToken = ""
        self.fbPageId = ""
        self.fbAccessUserID = String()
        self.name = ""
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
    
    public func retrieveFBPageIDFromFBRequest() -> String {
        NSLog("getFBPageID - getting facebook page id")
        let request = FBSDKGraphRequest(graphPath:"\(self.getUserAccessInfo())/accounts", parameters: nil , HTTPMethod: "GET")
        request.startWithCompletionHandler(
            {
                (connection, result, error) in
                if(error != nil){
                    NSLog("getFBPageID - Error retrieving fb graph request:  \(error.localizedDescription)")
                }
                else {
                    let data = result.valueForKey("data") as! NSArray
                    if let id = data[0].valueForKey("id") as? String {
                        NSLog("getFBPageID - retrieved id successfully. ID:  \(id)")
                        self.setFBPageID(id)
                    }
                    if let name = data[0].valueForKey("name") as? String {
                        NSLog("getFBPageID - retrieved name successfully. name:  \(name)")
                        self.setTruckOwnerName(name)
                    }
            }
        })
        return self.getFBPageID()
    }
    
    func setFBPageID(id: String)
    {
        userDefaults.setObject(id, forKey:"fbPageId")
        userDefaults.synchronize()
        self.fbPageId = id
        NSLog("setFbPageId - id: \(self.fbPageId)")
    }
    
    public func getFBPageID() -> String {
        if let id = userDefaults.valueForKey("fbPageId") as? String
        {
            return id as String
        }
        return ""
    }
    
    public func getTruckOwnerName() -> String {
        if let name = userDefaults.valueForKey("name") as? String
        {
            return name as String
        }
        return "Truck Feeder"
    }
    
    func setTruckOwnerName(name: String)
    {
        userDefaults.setObject(name, forKey:"name")
        userDefaults.synchronize()
        self.name = name
        NSLog("setTruckOwnerName - name: \(self.name)")
    }
    
    func setUserAccessInfoFromFBRequest(fbAccessUserID: String)
    {
        userDefaults.setObject(fbAccessUserID, forKey:"fbAccessUserID")
        userDefaults.synchronize()
        self.fbAccessUserID = fbAccessUserID
        NSLog("setUserAccessInfoFromFBRequest - fbAccessUserId: \(self.fbAccessUserID)")
    }
    
}
