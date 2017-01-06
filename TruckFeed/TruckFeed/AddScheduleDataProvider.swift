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
    
}

// MARK: - Table view data source

extension AddScheduleDataProvider: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "startDateSwitch") {
                return cell
            }
            return UITableViewCell()
            
        }
        else if indexPath.row == 1 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "startDatePicker") {
                return cell
            }
            return UITableViewCell()
        }
           return UITableViewCell()
    }
    

    
    func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
       
    }
    
}
