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
    var time: String
    var location: String
    
    init(truckId: NSInteger, truckName: String, month:String, weekDay:String, dateNumber:String, time:String, location:String)
    {
        self.truckId = truckId
        self.truckName = truckName
        self.month = month
        self.weekDay = weekDay
        self.dateNumber = dateNumber
        self.time = time
        self.location = location
    }
}
