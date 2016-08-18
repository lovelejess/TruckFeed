//
//  TruckSchedule.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/16/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation

public class TruckSchedule: NSObject {
    var truckId: NSInteger
    var truckName: String
    var month: String
    var weekDay: String
    var dateNumber: String
    var time1: String
    var time2: String
    var time3: String
    var location1: String
    var location2: String
    var location3: String
    
    init(truckId: NSInteger, truckName: String, month:String, weekDay:String, dateNumber:String, time1:String, time2: String, time3:String, location1:String, location2:String, location3:String)
    {
        self.truckId = truckId
        self.truckName = truckName
        self.month = month
        self.weekDay = weekDay
        self.dateNumber = dateNumber
        self.time1 = time1
        self.time2 = time2
        self.time3 = time3
        self.location1 = location1
        self.location2 = location2
        self.location3 = location3
    }
}
