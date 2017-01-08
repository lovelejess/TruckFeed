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
    private var switchValue: Bool?


// MARK: - Table view data source

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "startDateSwitch") as? StartDateSwitchCell {
                cell.delegate = self
                switchValue = cell.startDateSwitch.isOn
                return cell
            }
            return UITableViewCell()
            
        }
        else if indexPath.row == 1 && switchValue == true {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "startDatePicker") as? StartDatePickerCell {
                return cell
                
            }
            return UITableViewCell()
        }
           return UITableViewCell()
    }
    
    public func reloadTableData() {
        self.tableView.reloadData()
    }

    func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
       
    }
}
