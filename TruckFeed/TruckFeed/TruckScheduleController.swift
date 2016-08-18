//
//  TruckScheduleController.swift
//  TruckFeed
//
//  Created by Jessica Le on 7/7/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

public class TruckScheduleController: UIViewController {
    
    @IBOutlet var tableView: UITableView?
    private var dataProvider: ScheduleDataProviderProtocol?
    private var truckScheduleList = [TruckSchedule]()
    public var foodTruckName: String?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = ScheduleDataProvider()
        tableView!.delegate = self
        tableView!.dataSource = dataProvider
        self.truckScheduleList = dataProvider!.getSchedule();
        dataProvider?.tableView = tableView
        
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let leftBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.dismissViewController), frame:CGRectMake(0, 0, 30, 30), image: UIImage(named: "back.png")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithLeftButton(frame, title: foodTruckName!, leftBarButton: leftBarButtonItem)
        self.view.addSubview(navigationBar)
    }
    
    func dismissViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
}

extension TruckScheduleController: UITableViewDelegate
{
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 120.0;
    }
    
}

