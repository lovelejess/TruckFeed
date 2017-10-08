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
        NSLog("requestFacebookCredentials - getting facebook user access info")
        var fbAccessUserID = String()
        let request = FBSDKGraphRequest(graphPath:"me", parameters: ["fields": "id,first_name,last_name,email"] , httpMethod: "GET")
        let connection = FBSDKGraphRequestConnection()
        connection.add(request, completionHandler: {
            (connection, result, error) in
            if(error != nil){
                NSLog("requestFacebookCredentials - Error retrieving fb graph request:  \(error!.localizedDescription)")
            }
            else {
                if let response = result as AnyObject? {
                    NSLog("requestFacebookCredentials - response: \(response)")
                    fbAccessUserID = response.value(forKey: "id") as! String
                    NSLog("requestFacebookCredentials - fbAccessUserId: \(fbAccessUserID)")
                }
            }
        })
        connection.start()
        return fbAccessUserID
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
