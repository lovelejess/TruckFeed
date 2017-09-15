//
//  DateLabel.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/14/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import Foundation
import RealmSwift

class DateLabel {
    
    private var isStartDate: Bool?
    lazy var realm = try? Realm()
    
    init(isStartDate: Bool) {
        self.isStartDate = isStartDate
    }
    
    public func getDateFromSchedule() -> Schedule {
        if let scheduleRealm = realm?.objects(Schedule.self) {
            if let schedule = scheduleRealm.first {
                return schedule
            }
        }
        return Schedule()
    }
    
    public func saveDateLabel(date:String) {
        if let schedule = realm?.objects(Schedule.self).first {
            try! self.realm?.write {
                if(self.isStartDate)! {
                    schedule.startDate = date
                }
                else {
                    schedule.endDate = date
                }
            }
        }
        else {
            self.addSchedule(date: date)
        }
    }
    
    private func addSchedule(date: String) {
        let schedule = Schedule()
        schedule.endDate = DateUtility.getCurrentDateTime()
        try! self.realm?.write {
            realm?.add(schedule)
        }
    }

}
