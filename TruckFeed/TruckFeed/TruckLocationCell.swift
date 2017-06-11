//
//  TruckLocationCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 5/31/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class TruckLocationCell: UITableViewCell {

    @IBOutlet weak var truckLocationSwitch: UISwitch!
    @IBOutlet weak var truckLocationLabel: UILabel!
    
    public var delegate: AddScheduleDataProvider?
    
    override func awakeFromNib() {
        truckLocationLabel.text = "-------"
        truckLocationSwitch.addTarget(self, action: #selector(truckLocationSwitchToggled), for: UIControlEvents.valueChanged)
//        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.startDateLabelSelected"), object: nil, queue: nil, using: updateStartDateLabel)
    }
    
    func truckLocationSwitchToggled(){
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
