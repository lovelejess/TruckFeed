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
    public var dataProvider: TruckFeedDataProviderProtocol?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = TruckFeedDataProvider()
        tableView!.delegate = dataProvider
        tableView!.dataSource = dataProvider
        dataProvider!.getTruckFeedList();
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
        NSLog("Presenting")
        if segue.identifier == "DisplayTruckSchedule" {
            if let destination = segue.destinationViewController as? TruckScheduleController {
                NSLog("Presenting \(destination.title)")
            }
        }
    }
}
