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
    public var dataProvider: ScheduleDataProviderProtocol?
    
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = ScheduleDataProvider()
        //        assert(dataProvider != nil, "dataProvider is not allowed to be nil at this point")
        dataProvider!.getSchedule()
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        dataProvider?.tableView = tableView
        
        self.view.addSubview(createTableView(tableView))
    }
    
    func createTableView(tableView: UITableView) -> UITableView
    {
        tableView.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height);
//        tableView.registerClass(TruckCell.self, forCellReuseIdentifier: "TruckCell")
        
        return tableView
    }
}
