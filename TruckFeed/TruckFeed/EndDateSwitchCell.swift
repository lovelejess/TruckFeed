//
//  EndDateSwitchCellTableViewCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 1/8/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class EndDateSwitchCell: UITableViewCell {

    @IBOutlet weak var endDateSwitch: UISwitch!
    @IBOutlet weak var endDateLabel:UILabel!
    
    public var delegate: AddScheduleDataProvider?
    
    override func awakeFromNib() {
        endDateLabel.text = getCurrentDateTime()
        endDateSwitch.addTarget(self, action: #selector(endTimeSwitchToggled), for: UIControlEvents.valueChaavgvanged)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.endDateLabelSelected"), object: nil, queue: nil, using: updateEndDateLabel)
    }
    
    func endTimeSwitchToggled(){
        delegate!.reloadTableData()
    }
    
    public func getCurrentDateTime() -> String {
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date = dateFormatter.string(from: currentDateTime)
        return date
    }

    
    private func updateEndDateLabel(notification: Notification) -> Void {
        if let userInfo = notification.userInfo {
            if let date = userInfo["date"]  as? String {
                endDateLabel.text = date
            }
        }
    }
}
