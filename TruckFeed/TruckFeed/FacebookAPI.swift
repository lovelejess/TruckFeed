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
    static func setFacebookRequestOperationsQueue(_ facebookRequestOperation: BlockOperation, presentUserViewOperation: BlockOperation ) {
        let queue = OperationQueue()
        presentUserViewOperation.addDependency(facebookRequestOperation)
        queue.addOperation(facebookRequestOperation)
        queue.addOperation(presentUserViewOperation)
    }
    
    static func requestFacebookCredentials() -> String {
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
                }
            }
        })
        connection.start()
        return fbAccessUserID
    }
    
    static func retrieveFBPageIDFromFBRequest(userAccessInfo: String) -> NSArray {
        NSLog("getFBPageID - getting facebook page id")
        var facebookPageData = NSArray()
        let request = FBSDKGraphRequest(graphPath:"\(userAccessInfo)/accounts", parameters: nil , httpMethod: "GET")
        
        let connection = FBSDKGraphRequestConnection()
        connection.add(request, completionHandler: {
            (connection, result, error) in
            if(error != nil){
                NSLog("getFBPageID - Error retrieving fb graph request:  \(error?.localizedDescription)")
            }
            else {
                if let response = result as AnyObject? {
                    if let data = response.value(forKey: "data") as? NSArray {
                        facebookPageData = data
                    }
                }
            }
        })
        connection.start()
        return facebookPageData
    }

}
