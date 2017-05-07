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
    
    public func postSchedule(date_time: [String]) {
        let postURL = createURLWithEndPoint("truck/schedules")
        let httpBody = serializeJSONData(date_time: date_time)

        let request = createRequest(method: "POST", url: postURL, httpBody: httpBody)
        sendRequestWithData(postURL, request: request)
    }
    
    func createURLWithEndPoint(_ endpoint: String) -> URL
    {
        //TO DO: SWITCH URL WHEN GOING TO PROD
//        let kServerUrl = "https://damp-escarpment-86736.herokuapp.com/"
        let kServerUrl = "https://truck-server-dev.herokuapp.com"
//        let kServerUrl = "https://damp-escarpment-86736-pr-20.herokuapp.com"
        var truckListUrl = URL(string: kServerUrl)
        truckListUrl = truckListUrl?.appendingPathComponent(endpoint)
        NSLog("postSchedule - url: \(String(describing: truckListUrl))")
        return truckListUrl!
    }
    
    func serializeJSONData(date_time: [String]) -> Data {
        let date = date_time[0]
        let start_time = date_time[1] + date_time[2]

        let json: [String: Any] = ["truck_id":"3","truck_name":"Gastro Grub","date": date, "start_time": start_time, "end_time":"8:00PM", "location":"Des Moines Social Club", "street_address":"11 Cherry Street", "city_state":"Des Moines, IA"]

        if let jsonData = try? JSONSerialization.data(withJSONObject: json)
        {
            return jsonData as Data
        }
        return Data()
    }
    
    func createRequest(method: String, url: URL, httpBody:Data) -> URLRequest{
        var request = URLRequest(url:url)
        request.httpBody = httpBody as Data
        request.httpMethod = "POST"
        return request
    }
    
    func sendRequestWithData(_ url: URL, request: URLRequest){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {
            response, data, error in
            if let error = error {
                NSLog("postTruckSchedule\(error.localizedDescription)")
                let message = "Truck Schedule was submitted successfully"
                self.sendSubmitAlertMessage(message: message)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    DispatchQueue.main.async(execute: {
                        let message = "Truck Schedule was submitted successfully"
                        self.sendSubmitAlertMessage(message: message)
                        
                    });
                }
            }
        }
        
        let message = "Truck Schedule was submitted successfully"
        self.sendSubmitAlertMessage(message: message)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func sendSubmitAlertMessage(message: String) {
        let userInfo = ["message": message] as [String :String]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.lovelejess.scheduleSubmitted"), object: self, userInfo: userInfo)
        
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

}
