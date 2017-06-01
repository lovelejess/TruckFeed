//
//  ScheduleDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 7/7/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

open class ScheduleDataProvider: NSObject, ScheduleDataProviderProtocol {
    open var truckScheduleList = [TruckSchedule]()
    weak open var tableView: UITableView!
    
    open func getScheduleForTruck(_ truckName: String) -> [TruckSchedule]
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
    
    func createURLWithEndPoint(_ endpoint: String) -> URL
    {
        
        let queryItems = [URLQueryItem(name: "truck_name", value: endpoint)]
        if var urlComps = URLComponents(string: "https://damp-escarpment-86736.herokuapp.com/truck/schedules?"){
            urlComps.queryItems = queryItems
            let truckScheduleListUrl = urlComps.url
            return truckScheduleListUrl!
        }
        return URL(string: "")! // TODO: never return Url!
    }
    
    func generateSessionDataWithURL(_ url: URL) {
        
        let request = URLRequest(url:url)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {
            response, data, error in
            if let error = error {
                NSLog("getTruckScheduleList\(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.truckScheduleList = self.parseJSON(data!)
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    });
                }
            }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func parseJSON(_ data: Data) -> [TruckSchedule]
    {
        var json: AnyObject?
        var mappedJson = [TruckSchedule]()
        do {
            json = try JSONSerialization.jsonObject(with: data, options: []) as! [AnyObject] as AnyObject?
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
    
    func translateToTruckScheduleObject(_ json: AnyObject) -> TruckSchedule
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
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckScheduleList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let truckScheduleCell = tableView.dequeueReusableCell(withIdentifier: "TruckSchedule")
        self.configureCell(truckScheduleCell!, atIndexPath: indexPath)
        
        return truckScheduleCell!
    }
    
    func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        if let truckScheduleCell = cell as? TruckScheduleCell {
            let truckSchedule = self.truckScheduleList[indexPath.row] as TruckSchedule
            truckScheduleCell.weekDay.text = truckSchedule.weekDay
            truckScheduleCell.weekDay.font  = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
            truckScheduleCell.weekDay.textColor = secondaryColor
            truckScheduleCell.dateNumber.text = truckSchedule.dateNumber
            truckScheduleCell.dateNumber.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
            truckScheduleCell.dateNumber.textColor = darkColor
            truckScheduleCell.startTime.text = truckSchedule.startTime
            truckScheduleCell.startTime.textColor = darkColor
            truckScheduleCell.startTime.font =  UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
            truckScheduleCell.endTime.text = truckSchedule.endTime
            truckScheduleCell.endTime.textColor = darkColor
            truckScheduleCell.endTime.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
            truckScheduleCell.location.text = truckSchedule.location
            truckScheduleCell.location.textColor = mainColor
            truckScheduleCell.location.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
            truckScheduleCell.streetAddress.text = truckSchedule.streetAddress
            truckScheduleCell.streetAddress.textColor = greyColor
            truckScheduleCell.streetAddress.font = UIFont(name: "AppleSDGothicNeo", size: 15)
            truckScheduleCell.cityState.text = truckSchedule.cityState
            truckScheduleCell.cityState.textColor = greyColor
            truckScheduleCell.cityState.font = UIFont(name: "AppleSDGothicNeo", size: 15)
        }
        else {
            NSLog("ScheduleDataProvider - unable to configure cell")
        }
    }

}
