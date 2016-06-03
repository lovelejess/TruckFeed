//
//  AppPlistHelpers.swift
//  TruckFeed
//
//  Created by Jessica Le on 4/26/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation

public struct AppPlistHelpers
{
    static func getAppPlistDictionary() -> NSMutableDictionary {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("App.plist")
        var dict = NSMutableDictionary()
        dict = NSMutableDictionary(contentsOfFile: path)!
        
        let fileManager = NSFileManager.defaultManager()
        
        if(!fileManager.fileExistsAtPath(path)) {
            if let bundlePath = NSBundle.mainBundle().pathForResource("App", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                NSLog("getAppPlistDictionary - Bundle App.plist file is --> \(resultDictionary?.description)")
                do {
                    try fileManager.copyItemAtPath(bundlePath, toPath: path)
                }
                catch {
                    NSLog("getAppPlistDictionary - App.plist not found. Please, make sure it is part of the bundle.")
                }
            }
        } else {
            NSLog("getAppPlistDictionary - App.plist already exits at path.")
        }
        
        NSLog("getAppPlistDictionary - Loaded App.plist file is: \(dict.description)")
        
        return dict
    }
}