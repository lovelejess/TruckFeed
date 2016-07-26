//
//  TruckScheduleController.swift
//  TruckFeed
//
//  Created by Jessica Le on 7/7/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

public class TruckScheduleController: UIViewController, UITableViewDelegate {
    
    var tableView: UITableView  =   UITableView()
    private var dataProvider: ScheduleDataProviderProtocol?
    public var foodTruckName: String?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = ScheduleDataProvider()
        dataProvider!.getSchedule()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        dataProvider?.tableView = tableView
        
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: foodTruckName!)
        self.view.addSubview(navigationBar)
    }
}
