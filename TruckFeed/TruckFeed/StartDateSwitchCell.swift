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
        let realm = try! Realm()
        let scheduleRealm = realm.objects(Schedule.self)
        let schedule = scheduleRealm.first
        startDateLabel.text = schedule?.startDate
    }
    
    func saveDateLabel(date:String) {
        let realm = try! Realm()
        if let schedule = realm.objects(Schedule.self).first {
            try! realm.write {
                schedule.startDate = date
            }
        }
        else {
           self.addSchedule(date: date)
        }
    }
    
    private func addSchedule(date: String) {
        let realm = try! Realm()
        let schedule = Schedule()
        schedule.startDate = DateUtility.getCurrentDateTime()
        try! realm.write {
            realm.add(schedule)
        }

    }
}


class Schedule: Object {
    dynamic var startDate: String = DateUtility.getCurrentDateTime()
}

