//
//  AddScheduleDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 12/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

open class AddScheduleDataProvider: NSObject, TableDataProviderProtocol {

    weak open var tableView: UITableView!
    private var startDateSwitchValue: Bool?
    private var endDateSwitchValue: Bool?
    
    public func postSchedule() {
        let postURL = createURLWithEndPoint("truck/schedules")
        let httpBody = serializeJSONData()
        postToURLWithData(postURL, httpBody: httpBody)
    }
    
    func createURLWithEndPoint(_ endpoint: String) -> URL
    {
//        let kServerUrl = "https://damp-escarpment-86736.herokuapp.com/"
        let kServerUrl = "https://truck-server-dev.herokuapp.com"
        var truckListUrl = URL(string: kServerUrl)
        truckListUrl = truckListUrl?.appendingPathComponent(endpoint)
        NSLog("postSchedule - url: \(truckListUrl)")
        return truckListUrl!
    }

    func serializeJSONData() -> NSData {
        let json: [String :Any] = ["truck_id":"3","truck_name":"The Spot","month":"January","week_day":"Saturday","date_number":"28","start_time":"9:00AM","end_time":"5:00PM","location":"Iowa Tap Room","street_address":"215 E 3rd St #100","city_state":"Des Moines, IA"]
        if let jsonData = try? JSONSerialization.data(withJSONObject: json)
        {
            return jsonData as NSData
        }
        return NSData()
    }
    
    func postToURLWithData(_ url: URL, httpBody: NSData){
        var request = URLRequest(url:url)
        request.httpBody = httpBody as Data
        request.httpMethod = "POST"
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {
            response, data, error in
            if let error = error {
                NSLog("postTruckSchedule\(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async(execute: {
                        let userInfo = ["message": "Truck Schedule was submitted successfully"] as [String :String]
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.lovelejess.scheduleSubmitted"), object: self, userInfo: userInfo)
                    });
                }
            }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }


// MARK: - Table view data source

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "startDateSwitch") as? StartDateSwitchCell {
                cell.delegate = self
                startDateSwitchValue = cell.startDateSwitch.isOn
                return cell
            }
        }
        
        if (indexPath.row ==  1 && startDateSwitchValue == true) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "startDatePicker") as? StartDatePickerCell {
                return cell
            }
        }
        
        else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "endDateSwitch") as? EndDateSwitchCell {
                cell.delegate = self
                endDateSwitchValue = cell.endDateSwitch.isOn
                return cell
            }
        }
        
        if (indexPath.row == 2 && startDateSwitchValue == true) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "endDateSwitch") as? EndDateSwitchCell {
                cell.delegate = self
                endDateSwitchValue = cell.endDateSwitch.isOn
                return cell
            }
        }
        
        else if (indexPath.row == 2 && startDateSwitchValue == false && endDateSwitchValue == true) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "endDatePicker") as? EndDatePickerCell {
                return cell
            }
        }
        
        if (indexPath.row ==  3 && startDateSwitchValue == true && endDateSwitchValue == true)  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "endDatePicker") as? EndDatePickerCell {
                return cell
            }
        }
        return UITableViewCell()
    }

    
    public func reloadTableData() {
        self.tableView.reloadData()
    }

    func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
       
    }
}
