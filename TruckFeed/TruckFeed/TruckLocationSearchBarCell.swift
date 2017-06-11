//
//  TruckLocationSearchBarCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 6/9/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class TruckLocationSearchBarCell: UITableViewCell {
    
    //    @IBOutlet weak var startDateSwitch: UISwitch!
    @IBOutlet weak var searchBar: UILabel!
    
    public var delegate: AddScheduleDataProvider?
    
    override func awakeFromNib() {
        searchBar.text = "-------"
        //        startDateSwitch.addTarget(self, action: #selector(startTimeSwitchToggled), for: UIControlEvents.valueChanged)
        //        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.startDateLabelSelected"), object: nil, queue: nil, using: updateStartDateLabel)
    }
    
    func startTimeSwitchToggled(){
        delegate!.reloadTableData()
    }
    
    //    private func truckLocationLabel(notification: Notification) -> Void {
    //        if let userInfo = notification.userInfo {
    //            if let date = userInfo["date"]  as? String {
    //                startDateLabel.text = date
    //            }
    //        }
    //    }
}
