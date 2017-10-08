//
//  FacebookAPI.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/2/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit
import FBSDKCoreKit.FBSDKGraphRequest


class FacebookAPI: NSObject {
    static func setFacebookRequestOperationsQueue(setFBUserInfoOperation: BlockOperation, presentUserViewOperation: BlockOperation ) {
        let queue = OperationQueue()
        presentUserViewOperation.addDependency(setFBUserInfoOperation)
        queue.addOperation(setFBUserInfoOperation)
        queue.addOperation(presentUserViewOperation)
    }
    
    static func setFBUserInfo() {
        NSLog("getFBUserInfo - getting facebook user access info")
        var fbUserInfoResponse = NSDictionary()
        let request = FBSDKGraphRequest(graphPath:"me", parameters: ["fields": "id,first_name,last_name,email"] , httpMethod: "GET")
        let connection = FBSDKGraphRequestConnection()
        connection.add(request, completionHandler: {
            (connection, result, error) in
            if(error != nil){
                NSLog("getFBUserInfo - Error retrieving fb graph request:  \(error!.localizedDescription)")
            }
            else {
                if let response = result as! NSDictionary? {
                    NSLog("getFBUserInfo - response: \(response)")
                    fbUserInfoResponse = response
                    User.setFirstName(firstName: DictionaryParser.parseKeyFromResponse(key: "first_name", response: fbUserInfoResponse))
                    User.setLastName(lastName: DictionaryParser.parseKeyFromResponse(key: "last_name", response: fbUserInfoResponse))
                    User.setEmail(email: DictionaryParser.parseKeyFromResponse(key: "email", response: fbUserInfoResponse))
                    User.setId(id: DictionaryParser.parseKeyFromResponse(key: "id", response: fbUserInfoResponse))
                    
                }
            }
        })
        connection.start()
    }
    
    static func retrieveFBPageIDFromFBRequest(userAccessInfo: String) -> NSArray {
        NSLog("retrieveFBPageIDFromFBRequest - getting facebook page id")
        var facebookPageData = NSArray()
        let request = FBSDKGraphRequest(graphPath:"me/accounts", parameters: ["fields": "data"]  , httpMethod: "GET")
        
        let connection = FBSDKGraphRequestConnection()
        connection.add(request, completionHandler: {
            (connection, result, error) in
            if(error != nil){
                NSLog("retrieveFBPageIDFromFBRequest - Error retrieving fb graph request:  \(error!.localizedDescription)")
            }
            else {
                if let response = result as AnyObject? {
                    if let data = response.value(forKey: "data") as? NSArray {
                        facebookPageData = data
                         NSLog("retrieveFBPageIDFromFBRequest - fbAccessUserId: \(facebookPageData)")
                    }
                }
            }
        })
        connection.start()
        return facebookPageData
    }

}
