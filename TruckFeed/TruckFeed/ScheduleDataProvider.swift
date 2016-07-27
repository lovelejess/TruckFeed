//
//  ScheduleDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 7/7/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

public class ScheduleDataProvider: NSObject, ScheduleDataProviderProtocol {
    weak public var tableView: UITableView!
    
    public func getSchedule() -> [Truck] {
        return [Truck]()
    }
}


// MARK: - Table view data source
extension ScheduleDataProvider: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
