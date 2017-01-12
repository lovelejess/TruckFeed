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
