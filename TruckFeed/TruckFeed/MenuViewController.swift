//
//  MenuViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/16/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit

public class MenuViewController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet var tableView: UITableView?
    private var dataProvider: MenuDataProvider?
    private var menuList = [MenuListItem]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = MenuDataProvider()
        tableView!.delegate = self
        tableView!.dataSource = dataProvider
        self.menuList = dataProvider!.getMenuList();
        dataProvider?.tableView = tableView
        
        
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let lefttBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.dismissViewController), frame:CGRectMake(0, 0, 43, 31), image: UIImage(named: "back.png")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithLeftButton(frame, title: "Settings", leftBarButton: lefttBarButtonItem)
        self.view.addSubview(navigationBar)
    }
    
    func dismissViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }

    func presentMainLoginViewController(sender: AnyObject){
        NSLog(" facebookLogout - entering presentMainLoginScreen")
        if let MainLoginScreenController = self.storyboard?.instantiateViewControllerWithIdentifier("MainLoginScreen") as? MainLoginScreenController {
            self.presentViewController(MainLoginScreenController, animated: true, completion:
                {
                    NSLog("facebookLogout - Presenting MainLoginScreen")
            })
        }
    }
    
    func facebookLogout(){
        FBSDKAccessToken.setCurrentAccessToken(nil)
        let truckOwner = TruckOwner.sharedInstance
        truckOwner.setFBAccessToken("")
        
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("App.plist")
        let dict = NSMutableDictionary(contentsOfFile: path)
        dict?.setValue(false, forKey: "LoggedIn")
        dict?.writeToFile(path, atomically: false)
        NSLog("facebookLogout - Setting App.plist file to :\(NSMutableDictionary(contentsOfFile: path)))")
    }
}


extension MenuViewController: UITableViewDelegate
{
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 42.0;
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        NSLog("You selected cell #\(indexPath.row)!")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        if(FacebookCredentials.isLoggedIn())
        {
            self.facebookLogout()
        }
        self.presentMainLoginViewController(self )
    }
    
}

