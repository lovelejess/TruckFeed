//
//  StartDateSwitchCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 12/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

class StartDateSwitchCell: UITableViewCell {

    @IBOutlet weak var startDateSwitch: UISwitch!
    @IBOutlet weak var startDateLabel: UILabel!
    
    public var delegate: AddScheduleDataProvider?
    
    override func awakeFromNib() {
        startDateLabel.text = getCurrentDateTime()
        startDateSwitch.addTarget(self, action: #selector(startTimeSwitchToggled), for: UIControlEvents.valueChanged)
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.startDateLabelSelected"), object: nil, queue: nil, using: updateStartDateLabel)
    }
    
    func startTimeSwitchToggled(){
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
    
    private func updateStartDateLabel(notification: Notification) -> Void {
        if let userInfo = notification.userInfo {
            if let date = userInfo["date"]  as? String {
                startDateLabel.text = date
            }
        }
    }
}
