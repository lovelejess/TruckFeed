//
//  EndDateSwitchCellTableViewCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 1/8/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit
import RealmSwift

class EndDateCell: UITableViewCell {

    @IBOutlet weak var endDateLabel:UILabel!
    public var delegate: AddScheduleDataProvider?
    private var dateLabel: DateLabel?
    lazy var realm = try? Realm()
    
    override func awakeFromNib() {
        self.dateLabel = DateLabel(isStartDate: false)
        let schedule = self.dateLabel?.getDateFromSchedule()
        endDateLabel.text = schedule?.endDate
    
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.endDateLabelSelected"), object: nil, queue: nil, using: updateEndDateLabel)
    }
    
    private func updateEndDateLabel(notification: Notification) -> Void {
        if let userInfo = notification.userInfo {
            if let date = userInfo["date"]  as? String {
                self.dateLabel?.saveDateLabel(date: date)
            }
        }
    }
}
