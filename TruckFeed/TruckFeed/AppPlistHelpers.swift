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
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        let documentsDirectory = paths.object(at: 0) as! NSString
        let path = documentsDirectory.appendingPathComponent("App.plist")
        var dict = NSMutableDictionary()
        dict = NSMutableDictionary(contentsOfFile: path)!
        
        let fileManager = FileManager.default
        
        if(!fileManager.fileExists(atPath: path)) {
            if let bundlePath = Bundle.main.path(forResource: "App", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                NSLog("getAppPlistDictionary - Bundle App.plist file is --> \(resultDictionary?.description)")
                do {
                    try fileManager.copyItem(atPath: bundlePath, toPath: path)
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
