//
//  AppDelegate.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/27/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let truckOwner = TruckOwner.sharedInstance;
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().backgroundColor = mainColor
        UINavigationBar.appearance().barTintColor = mainColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        FBSDKApplicationDelegate.sharedInstance();
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.window?.rootViewController = loadFacebookData()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func getAppPlistDictionary() -> NSMutableDictionary {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("App.plist")
        var dict = NSMutableDictionary()
        dict = NSMutableDictionary(contentsOfFile: path)!

        let fileManager = NSFileManager.defaultManager()
        
        if(!fileManager.fileExistsAtPath(path)) {
            if let bundlePath = NSBundle.mainBundle().pathForResource("App", ofType: "plist") {
                let resultDictionary = NSMutableDictionary(contentsOfFile: bundlePath)
                print("Bundle App.plist file is --> \(resultDictionary?.description)")
                do {
                    try fileManager.copyItemAtPath(bundlePath, toPath: path)
                }
                catch {
                    print("App.plist not found. Please, make sure it is part of the bundle.")
                }
            }
        } else {
            print("App.plist already exits at path.")
        }
        
        print("Loaded App.plist file is: \(dict.description)")
        
        return dict
    }
    
    func loadFacebookData() -> UIViewController {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        if let loggedIn = getAppPlistDictionary().objectForKey("LoggedIn") as? Bool {
            NSLog("LoggedIn value from App.plist is : \(loggedIn)")
            if loggedIn != true
            {
                let mainLoginScreen: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("MainLoginScreen") as! MainLoginScreen
                return mainLoginScreen
            }
        }
        
        let dashboardViewController: UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("DashboardViewController") as! DashboardViewController
        return dashboardViewController
    }
    
    func didFinishLaunchingWithOptions(application: UIApplication){
        
        
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp();
     }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
   
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                openURL: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }


}

