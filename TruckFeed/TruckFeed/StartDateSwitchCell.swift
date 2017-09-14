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
    lazy var realm = try? Realm()
    
    override func awakeFromNib() {
        self.updateDateLabel()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.startDateLabelSelected"), object: nil, queue: nil, using: updateStartDateLabel)
    }

    private func updateStartDateLabel(notification: Notification) -> Void {
        if let userInfo = notification.userInfo {
            if let date = userInfo["date"]  as? String {
                self.saveDateLabel(date: date)
            }
        }
    }
    
    func updateDateLabel() {
        if let scheduleRealm = self.realm?.objects(Schedule.self) {
            let schedule = scheduleRealm.first
            startDateLabel.text = schedule?.startDate
        }
        
    }
    
    func saveDateLabel(date:String) {
        if let schedule = realm?.objects(Schedule.self).first {
            try? self.realm?.write {
                schedule.startDate = date
            }
        }
        else {
           self.addSchedule(date: date)
        }
    }
    
    private func addSchedule(date: String) {
        let schedule = Schedule()
        schedule.startDate = DateUtility.getCurrentDateTime()
        try! self.realm?.write {
            realm?.add(schedule)
        }

    }
}

