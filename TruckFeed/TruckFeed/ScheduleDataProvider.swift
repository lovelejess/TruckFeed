//
//  ScheduleDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 7/7/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

public class ScheduleDataProvider: NSObject, ScheduleDataProviderProtocol {
    public var truckScheduleList = [TruckSchedule]()
    weak public var tableView: UITableView!
    
    public func getSchedule() -> [TruckSchedule] {
        self.truckScheduleList = [TruckSchedule(truckId: 1, truckName: "The Outside Scoop", month: "February", weekDay: "Sunday", dateNumber: "3", time1: "12:00PM", time2: "2:00PM", time3: "4:00PM", location1: "Scuplture Garden Park", location2: "Confluence", location3: "Festival"),TruckSchedule(truckId: 2, truckName: "The Spot", month: "February", weekDay: "Sunday", dateNumber: "3", time1: "12:00PM", time2: "2:00PM", time3: "4:00PM", location1: "Scuplture Garden Park", location2: "Confluence", location3: "Festival")]
        return truckScheduleList
    }
}


// MARK: - Table view data source
extension ScheduleDataProvider: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckScheduleList.count
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let truckScheduleCell = tableView.dequeueReusableCellWithIdentifier("TruckSchedule")
        self.configureCell(truckScheduleCell!, atIndexPath: indexPath)
        
        return truckScheduleCell!
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let truckScheduleCell = cell as! TruckScheduleCell
        let truckSchedule = self.truckScheduleList[indexPath.row] as TruckSchedule
//        truckScheduleCell.month.text = truckSchedule.month
        truckScheduleCell.weekDay.text = truckSchedule.weekDay
        truckScheduleCell.weekDay!.textColor = secondaryColor
        truckScheduleCell.dateNumber.text = truckSchedule.dateNumber
        truckScheduleCell.time1.text = truckSchedule.time1
        truckScheduleCell.time2.text = truckSchedule.time2
//        truckScheduleCell.time3.text = truckSchedule.time3
        truckScheduleCell.location1.text = truckSchedule.location1
        truckScheduleCell.location2.text = truckSchedule.location2
//        truckScheduleCell.location3.text = truckSchedule.location3
        
        print(truckScheduleCell.weekDay.text)
    }


}
