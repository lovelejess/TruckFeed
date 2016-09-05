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
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: "TruckFeed")
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
                        destination.foodTruckName = navigationBarTitleHeader + (cell.textLabel?.text)!
                        destination.truckId = String(index.row)
                    }
                    else
                    {
                        destination.foodTruckName = navigationBarTitleHeader +  "FoodTruckName"
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

