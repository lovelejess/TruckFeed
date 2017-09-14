//
//  EndDateSwitchCellTableViewCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 1/8/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit
import RealmSwift

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
                self.saveDateLabel(date: date)
            }
        }
    }
    
    func updateDateLabel() {
        let realm = try? Realm()
        if let scheduleRealm = realm?.objects(Schedule.self) {
            let schedule = scheduleRealm.first
            endDateLabel.text = schedule?.endDate
        }
    }
    
    func saveDateLabel(date:String) {
        let realm = try? Realm()
        let allobjects = realm?.objects(Schedule.self)
        
        if let schedule = realm?.objects(Schedule.self).first {
            try? realm?.write {
                schedule.endDate = date
            }
        }
        else {
            self.addSchedule(date: date)
        }
    }
    
    private func addSchedule(date: String) {
        let realm = try? Realm()
        let schedule = Schedule()
        schedule.endDate = DateUtility.getCurrentDateTime()
        try! realm?.write {
            realm?.add(schedule)
        }
    }
}
