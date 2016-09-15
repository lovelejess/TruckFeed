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
    
    public func getScheduleForTruck(truckName: String) -> [TruckSchedule]
    {
        let truckScheduleListUrl = self.createURLWithEndPoint(truckName)
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
        
        let queryItems = [NSURLQueryItem(name: "truck_name", value: endpoint)]
        if let urlComps = NSURLComponents(string: "https://damp-escarpment-86736.herokuapp.com/truck/schedules?"){
            urlComps.queryItems = queryItems
            let truckScheduleListUrl = urlComps.URL
            return truckScheduleListUrl!
        }
        return NSURL()
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
        let startTime = json["start_time"] as! String
        let endTime = json["end_time"] as! String
        let location = json["location"] as! String
        let streetAddress = json["street_address"] as! String
        let cityState = json["city_state"] as! String
        let truckScheduleObject = TruckSchedule(truckId: truckId, truckName: truckName, month:month, weekDay:weekDay, dateNumber:dateNumber, startTime:startTime, endTime: endTime, location:location, streetAddress: streetAddress, cityState: cityState)
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
        if let truckScheduleCell = cell as? TruckScheduleCell {
            let truckSchedule = self.truckScheduleList[indexPath.row] as TruckSchedule
            truckScheduleCell.weekDay.text = truckSchedule.weekDay
            truckScheduleCell.weekDay.textColor = secondaryColor
            truckScheduleCell.dateNumber.text = truckSchedule.dateNumber
            truckScheduleCell.dateNumber.textColor = darkColor
            truckScheduleCell.startTime.text = truckSchedule.startTime
            truckScheduleCell.endTime.text = truckSchedule.endTime
            truckScheduleCell.location.text = truckSchedule.location
            truckScheduleCell.streetAddress.text = truckSchedule.streetAddress
            truckScheduleCell.cityState.text = truckSchedule.cityState
        }
        else {
            NSLog("ScheduleDataProvider - unable to configure cell")
        }
    }

}
