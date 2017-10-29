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
    var userDefaults:UserDefaults
    var fbPageId:String
    var name:String
    
    override init()
    {
        self.userDefaults = UserDefaults()
        self.fbPageId = ""
        self.name = ""
        super.init()
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
    
}
