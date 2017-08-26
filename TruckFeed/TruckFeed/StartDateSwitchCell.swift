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
        startDateLabel.text = DateUtility.getCurrentDateTime()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.startDateLabelSelected"), object: nil, queue: nil, using: updateStartDateLabel)
    }

    private func updateStartDateLabel(notification: Notification) -> Void {
        if let userInfo = notification.userInfo {
            if let date = userInfo["date"]  as? String {
                startDateLabel.text = date
            }
        }
    }
}
