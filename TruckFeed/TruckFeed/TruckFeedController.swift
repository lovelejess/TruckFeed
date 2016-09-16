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
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = TruckFeedDataProvider()
        tableView!.delegate = self
        tableView!.dataSource = dataProvider
        self.truckList = dataProvider!.getTruckFeedList();
        dataProvider?.tableView = tableView
        
        
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let rightBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(presentMainLoginScreenController), frame:CGRectMake(0, 0, 43, 31), image: UIImage(named: "gear.png")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithRightButton(frame, title: "TruckFeed", rightBarButton: rightBarButtonItem)
        self.view.addSubview(navigationBar)

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
    
    func presentMainLoginScreenController(sender: AnyObject){
        if let mainLoginScreenController = self.storyboard!.instantiateViewControllerWithIdentifier("MainLoginScreenController") as? MainLoginScreenController {
            self.presentViewController(mainLoginScreenController, animated: true, completion:
                {
                    NSLog("Presenting Main Login Screen Controller")
            })
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

