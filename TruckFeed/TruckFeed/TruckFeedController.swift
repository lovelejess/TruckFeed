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
        tableView = createTableView(UITableView())
        dataProvider = TruckFeedDataProvider()
        tableView!.delegate = dataProvider
        tableView!.dataSource = dataProvider
        dataProvider!.getTruckFeedList();
        dataProvider?.tableView = tableView
        
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: "TruckFeed")
        self.view.addSubview(tableView!)
        self.view.addSubview(navigationBar)

    }
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  
    // PRIVATE HELPERS
   
    func createTableView(tableView: UITableView) -> UITableView
    {
        tableView.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height);
        tableView.registerClass(TruckCell.self, forCellReuseIdentifier: "TruckCell")
        
        return tableView
    }
    
    // TruckCellDelegateMethod 
    func foodTruckCellSelected(name: String)
    {
        
    }
    
    func presentTruckScheduleController(sender: AnyObject){
        if let truckScheduleController = self.storyboard!.instantiateViewControllerWithIdentifier("TruckScheduleController") as? TruckScheduleController {
            self.presentViewController(truckScheduleController, animated: true, completion:
                {
                    NSLog("Presenting Truck Schedule Controller")
            })
        }
    }

}
