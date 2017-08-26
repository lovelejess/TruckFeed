//
//  EndDateSwitchCellTableViewCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 1/8/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class EndDateSwitchCell: UITableViewCell {

    @IBOutlet weak var endDateLabel:UILabel!
    
    public var delegate: AddScheduleDataProvider?
    
    override func awakeFromNib() {
        endDateLabel.text = DateUtility.getCurrentDateTime()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.endDateLabelSelected"), object: nil, queue: nil, using: updateEndDateLabel)
    }
    
    private func updateEndDateLabel(notification: Notification) -> Void {
        if let userInfo = notification.userInfo {
            if let date = userInfo["date"]  as? String {
                endDateLabel.text = date
            }
        }
    }
}
