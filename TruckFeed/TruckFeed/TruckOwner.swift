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

open class TruckOwner: NSObject {
    
    static let sharedInstance = TruckOwner()
    var fbAccessToken:String
    var userDefaults:UserDefaults
    var fbPageId:String
    var fbAccessUserID:String
    var name:String
    
    override init()
    {
        self.userDefaults = UserDefaults()
        self.fbAccessToken = ""
        self.fbPageId = ""
        self.fbAccessUserID = String()
        self.name = ""
        super.init()
    }
    
    open func requestFacebookCredentials(){
        NSLog("retrieveUserAccessInfoFromFBRequest - getting facebook user access info")
        var fbAccessUserID = String()
        let request = FBSDKGraphRequest(graphPath:"me", parameters: ["fields": "name, email, friends, id"] , httpMethod: "GET")
        let connection = FBSDKGraphRequestConnection()
        connection.add(request, completionHandler: {
                (connection, result, error) in
                if(error != nil){
                    NSLog("retrieveUserAccessInfoFromFBRequest - Error retrieving fb graph request:  \(error?.localizedDescription)")
                }
                else {
                    if let response = result as AnyObject? {
                        fbAccessUserID = response.value(forKey: "id") as! String
                        NSLog("retrieveUserAccessInfoFromFBRequest - retrieved result successfully. ID:  \(fbAccessUserID)")
                        self.setUserAccessInfoFromFBRequest(fbAccessUserID)
                        self.retrieveFBPageIDFromFBRequest()
                    }
                }
        })
        connection.start()
    }
    
    open func retrieveFBPageIDFromFBRequest(_ completionBlock: ()){
        NSLog("getFBPageID - getting facebook page id")
        let request = FBSDKGraphRequest(graphPath:"\(self.getUserAccessInfo())/accounts", parameters: nil , httpMethod: "GET")
        let connection = FBSDKGraphRequestConnection()
        connection.add(request, completionHandler: {
                (connection, result, error) in
                if(error != nil){
                    NSLog("getFBPageID - Error retrieving fb graph request:  \(error?.localizedDescription)")
                }
                else {
                    if let response = result as AnyObject? {
                        if let data = response.value(forKey: "data") as? NSArray {
                            if let id = data.value(forKey: "id") as? String {
                                NSLog("getFBPageID - retrieved id successfully. ID:  \(id)")
                                self.setFBPageID(id)
                            }
                            if let name = data.firstObject as AnyObject? {
                                if let nameString = name.value(forKey: "name") as? String {
                                    NSLog("getFBPageID - retrieved name successfully. name:  \(nameString)")
                                    self.setTruckOwnerName(nameString)
                                }
                            }
                        }
                    }
                }
        })
        connection.start()
    }
    
    open func getUserAccessInfo() -> String {
        return userDefaults.value(forKey: "fbAccessUserID") as! String
    }
    
    open func setFBAccessToken(_ accessToken:String){
        userDefaults.set(accessToken, forKey:"accessToken")
        userDefaults.synchronize()
        self.fbAccessToken = accessToken
    }

    open func getFBAccessToken() -> String{
        return userDefaults.value(forKey: "accessToken") as! String
    }
    
    func setFBPageID(_ id: String)
    {
        userDefaults.set(id, forKey:"fbPageId")
        userDefaults.synchronize()
        self.fbPageId = id
        NSLog("setFbPageId - id: \(self.fbPageId)")
    }
    
    open func getFBPageID() -> String {
        if let id = userDefaults.value(forKey: "fbPageId") as? String
        {
            return id as String
        }
        return ""
    }
    
    open func getTruckOwnerName() -> String {
        if let name = userDefaults.value(forKey: "name") as? String
        {
            return name as String
        }
        return "Truck Feeder"
    }
    
    func setTruckOwnerName(_ name: String)
    {
        userDefaults.set(name, forKey:"name")
        userDefaults.synchronize()
        self.name = name
        NSLog("setTruckOwnerName - name: \(self.name)")
    }
    
    func setUserAccessInfoFromFBRequest(_ fbAccessUserID: String)
    {
        userDefaults.set(fbAccessUserID, forKey:"fbAccessUserID")
        userDefaults.synchronize()
        self.fbAccessUserID = fbAccessUserID
        NSLog("setUserAccessInfoFromFBRequest - fbAccessUserId: \(self.fbAccessUserID)")
    }
    
}
