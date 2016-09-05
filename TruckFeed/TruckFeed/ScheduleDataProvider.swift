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
    
    public func getScheduleForTruck(truckId: String) -> [TruckSchedule]
    {
        let truckScheduleListUrl = self.createURLWithEndPoint("trucks/schedules/\(truckId)")
        self.generateSessionDataWithURL(truckScheduleListUrl)
        
        // generates placeholder list view until data is fetched
        if (truckScheduleList.isEmpty)
        {
            self.truckScheduleList = [TruckSchedule]()
        }
        return self.truckScheduleList
    }
    
    func createURLWithEndPoint(endpoint: String) -> NSURL
    {
        let kServerUrl = "https://damp-escarpment-86736.herokuapp.com/";
        var truckScheduleListUrl = NSURL(string: kServerUrl)
        truckScheduleListUrl = truckScheduleListUrl?.URLByAppendingPathComponent(endpoint)
        NSLog("getTruckScheduleList - url: \(truckScheduleListUrl)")
        return truckScheduleListUrl!
    }
    
    func generateSessionDataWithURL(url: NSURL) {
        
        let request = NSURLRequest(URL:url)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            response, data, error in
            if let error = error {
                NSLog("getTruckScheduleList\(error.localizedDescription)")
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.truckScheduleList = self.parseJSON(data!)
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableView.reloadData()
                    });
                }
            }
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func parseJSON(data: NSData) -> [TruckSchedule]
    {
        var json: AnyObject?
        var mappedJson = [TruckSchedule]()
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [AnyObject]
            NSLog("parseJSON - json : \(json)")
            let scheduleArray = json as! [AnyObject]
            for schedule in scheduleArray {
                let mappedTruckSchedule = self.translateToTruckScheduleObject(schedule)
                mappedJson.append(mappedTruckSchedule)
            }
        } catch {
            NSLog("parseJSON - error: \(error)")
        }
        return mappedJson
    }
    
    func translateToTruckScheduleObject(json: AnyObject) -> TruckSchedule
    {
        NSLog("translateToTruckObject - : \(json)")
        let truckId = NSInteger(json["truck_id"] as! String)!
        let truckName = json["truck_name"] as! String
        let month = json["month"] as! String
        let weekDay = json["week_day"] as! String
        let dateNumber = json["date_number"] as! String
        let time = json["time"] as! String
        let location = json["location"] as! String
        let truckScheduleObject = TruckSchedule(truckId: truckId, truckName: truckName, month:month, weekDay:weekDay, dateNumber:dateNumber, time:time,location:location)
        return truckScheduleObject
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
        truckScheduleCell.dateNumber.textColor = darkColor
        truckScheduleCell.time.text = truckSchedule.time
        truckScheduleCell.location.text = truckSchedule.location
        
        print(truckScheduleCell.weekDay.text)
    }


}
