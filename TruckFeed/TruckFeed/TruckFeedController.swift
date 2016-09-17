//
//  TruckFeedController.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/28/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit

public class TruckFeedController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet var tableView: UITableView?
    private var dataProvider: TruckFeedDataProviderProtocol?
    private var truckList = [Truck]()
    let FBLoginManager = FBSDKLoginManager()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = TruckFeedDataProvider()
        tableView!.delegate = self
        tableView!.dataSource = dataProvider
        self.truckList = dataProvider!.getTruckFeedList();
        dataProvider?.tableView = tableView
        
        
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let lefttBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.presentMenuViewController), frame:CGRectMake(0, 0, 43, 31), image: UIImage(named: "menu.png")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithLeftButton(frame, title: "TruckFeed", leftBarButton: lefttBarButtonItem)
        self.view.addSubview(navigationBar)

    }
    
    func presentMenuViewController(sender: AnyObject){
        NSLog("presentMenuViewController - entering presentMenuViewController")
        if let menuViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MenuViewController") as? MenuViewController {
            self.presentViewController(menuViewController, animated: true, completion:
                {
                    NSLog("presentMenuViewController - Presenting MenuViewController")
            })
        }
    }

    
    func loginWithFacebook()
    {
        
        if(!FacebookCredentials.isLoggedIn())
        {
            self.presentMainLoginViewController(self)
        }
        
        else
        {
            self.presentMasterTabViewController(self)
        }
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
    
    func presentMasterTabViewController(sender: AnyObject){
        NSLog(" facebookLogout - entering presentMainLoginScreen")
        if let masterTabViewController = self.storyboard?.instantiateViewControllerWithIdentifier("MasterTabViewController") as? MasterTabViewController {
            self.presentViewController(masterTabViewController, animated: true, completion:
                {
                    NSLog("facebookLogout - Presenting MasterTabViewController")
            })
        }
    }
    
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "DisplayTruckSchedule" {
            if let destination = segue.destinationViewController as? TruckScheduleController {
                NSLog("Presenting \(destination.title)")
                if let index = self.tableView?.indexPathForSelectedRow {
                    let navigationBarTitleHeader = "Spotted: "
                    if let cell = self.tableView?.cellForRowAtIndexPath(index)
                    {
                        destination.foodTruckTitleName = navigationBarTitleHeader + (cell.textLabel?.text)!
                        destination.foodTruckName = (cell.textLabel?.text)!
                    }
                    else
                    {
                        destination.foodTruckTitleName = navigationBarTitleHeader +  "FoodTruckName"
                        destination.foodTruckName = "FoodTruckName"
                    }
                }
            }
        }
    }
}

extension TruckFeedController: UITableViewDelegate
{
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 75.0;
    }
    
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        NSLog("You selected cell #\(indexPath.row)!")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier("DisplayTruckSchedule", sender: indexPath)
    }
}

