//
//  StartDateSwitchCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 12/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit
import RealmSwift

class StartDateSwitchCell: UITableViewCell {

    @IBOutlet weak var startDateLabel: UILabel!
    public var delegate: AddScheduleDataProvider?
    private var dateLabel: DateLabel?
    lazy var realm = try? Realm()
    
    override func awakeFromNib() {
        self.dateLabel = DateLabel(isStartDate: true)
        let schedule = self.dateLabel?.getDateFromSchedule()
        startDateLabel.text = schedule?.startDate
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.startDateLabelSelected"), object: nil, queue: nil, using: updateStartDateLabel)
    }
    
    private func updateStartDateLabel(notification: Notification) -> Void {
        if let userInfo = notification.userInfo {
            if let date = userInfo["date"]  as? String {
                self.dateLabel?.saveDateLabel(date: date)
            }
        }
    }
}
