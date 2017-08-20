//
//  AddScheduleDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 12/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit
import GooglePlaces

open class AddScheduleDataProvider: NSObject, TableDataProviderProtocol, TruckLocationCellProtocol {

    weak open var tableView: UITableView!
    private var startDateSwitchValue: Bool?
    private var endDateSwitchValue: Bool?
    private var truckLocationSwitchValue: Bool?
    
    public func postSchedule(start_date_time: [String], end_date_time: [String]) {
        let postURL = createURLWithEndPoint("truck/schedules")
        let httpBody = serializeJSONData(start_date_time: start_date_time, end_date_time: end_date_time)

        let request = createRequest(method: "POST", url: postURL, httpBody: httpBody)
        sendRequestWithData(postURL, request: request)
    }
    
    func createURLWithEndPoint(_ endpoint: String) -> URL
    {
        //TO DO: SWITCH URL WHEN GOING TO PROD
//        let kServerUrl = "https://damp-escarpment-86736.herokuapp.com/"
        let kServerUrl = "https://truck-server-dev.herokuapp.com"
//        let kServerUrl = "https://damp-escarpment-86736-pr-21.herokuapp.com"
        var truckListUrl = URL(string: kServerUrl)
        truckListUrl = truckListUrl?.appendingPathComponent(endpoint)
        NSLog("postSchedule - url: \(String(describing: truckListUrl))")
        return truckListUrl!
    }
    
    func serializeJSONData(start_date_time: [String], end_date_time: [String]) -> Data {
        let start_date = start_date_time[0]
        let start_time = start_date_time[1] + start_date_time[2]
        let end_date = end_date_time[0]
        let end_time = end_date_time[1] + end_date_time[2]

        let json: [String: Any] = ["truck_id":"3","truck_name":"Gastro Grub","start_date": start_date, "start_time": start_time, "end_date": end_date, "end_time": end_time, "location":"Des Moines Social Club", "street_address":"11 Cherry Street", "city_state":"Des Moines, IA"]

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
        return 6
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
        
        else if (indexPath.row ==  2 && startDateSwitchValue == false && endDateSwitchValue == false)  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "spotLocation") as? TruckLocationCell {
                cell.delegate = self
                truckLocationSwitchValue = cell.truckLocationSwitch.isOn
                return cell
            }
        }
        
        if (indexPath.row ==  3 && startDateSwitchValue == true && endDateSwitchValue == true)  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "endDatePicker") as? EndDatePickerCell {
                return cell
            }
        }
        
        else if (indexPath.row ==  3 && startDateSwitchValue == true && endDateSwitchValue == false)  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "spotLocation") as? TruckLocationCell {
                return cell
            }
        }
            
        else if (indexPath.row ==  3 && startDateSwitchValue == false && endDateSwitchValue == true)  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "spotLocation") as? TruckLocationCell {
                cell.delegate = self
                truckLocationSwitchValue = cell.truckLocationSwitch.isOn
                return cell
            }
        }
        
        else if (indexPath.row ==  3 && startDateSwitchValue == false && endDateSwitchValue == false && truckLocationSwitchValue == true) {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "spotLocationSearchBar") as? TruckLocationSearchBarCell {
                cell.truckLocationDelegate = self
                return cell
            }
        }
        
        if (indexPath.row ==  4 && startDateSwitchValue == true && endDateSwitchValue == false && truckLocationSwitchValue == true)  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "spotLocationSearchBar") as? TruckLocationSearchBarCell {
                cell.truckLocationDelegate = self
                return cell
            }
        }
            
        else if (indexPath.row ==  4 && startDateSwitchValue == false && endDateSwitchValue == true && truckLocationSwitchValue == true)  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "spotLocationSearchBar") as? TruckLocationSearchBarCell {
                cell.truckLocationDelegate = self
                return cell
            }
        }

        
        else if (indexPath.row ==  4 && startDateSwitchValue == true && endDateSwitchValue == true)  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "spotLocation") as? TruckLocationCell {
                cell.delegate = self
                truckLocationSwitchValue = cell.truckLocationSwitch.isOn
                return cell
            }
        }
        
        if (indexPath.row ==  5 && startDateSwitchValue == true && endDateSwitchValue == true && truckLocationSwitchValue == true)  {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "spotLocationSearchBar") as? TruckLocationSearchBarCell {
                cell.truckLocationDelegate = self
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    public func presentGooglePlacesAutoComplete() {
        let autoCompleteController = GMSAutocompleteViewController()
        let rootViewController = getPresentedViewController()
        autoCompleteController.delegate = rootViewController as? GMSAutocompleteViewControllerDelegate
        rootViewController?.present(autoCompleteController, animated: true, completion: nil)
    }
    
    public func reloadTableData() {
        self.tableView.reloadData()
    }
    
    private func getPresentedViewController() -> UIViewController? {
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let masterTabViewController = rootViewController as? MasterTabViewController {
            rootViewController = masterTabViewController.selectedViewController
        }
        return rootViewController
    }

}
