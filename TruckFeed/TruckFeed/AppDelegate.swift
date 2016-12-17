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

    @IBOutlet var window: UIWindow?
    let truckOwner = TruckOwner.sharedInstance;
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        FBSDKApplicationDelegate.sharedInstance();
        
        UINavigationBar.appearance().backgroundColor = mainColor
        UINavigationBar.appearance().barTintColor = mainColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = self.determineUIViewToPresent()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    func determineUIViewToPresent() -> UIViewController
    {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if(FacebookCredentials.isLoggedIn())
        {
            let masterTabViewController: MasterTabViewController = mainStoryboard.instantiateViewController(withIdentifier: "MasterTabViewController") as! MasterTabViewController
            return masterTabViewController
        }
        let mainLoginScreen: MainLoginScreenController = mainStoryboard.instantiateViewController(withIdentifier: "MainLoginScreen") as! MainLoginScreenController
        return mainLoginScreen
    }
    
    func didFinishLaunchingWithOptions(_ application: UIApplication){
        self.window?.tintColor = UIColor.white;
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp();
     }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
   
    func application(_ application: UIApplication,
        open url: URL,
        sourceApplication: String?,
        annotation: Any) -> Bool {
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                open: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }


}

