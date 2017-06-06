//
//  TruckLocationCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 5/31/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class TruckLocationCell: UITableViewCell {

//    @IBOutlet weak var startDateSwitch: UISwitch!
    @IBOutlet weak var truckLocationLabel: UILabel!
    
    public var delegate: AddScheduleDataProvider?
    
    override func awakeFromNib() {
        truckLocationLabel.text = "location"
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
