//
//  TruckSchedule.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/16/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation

open class TruckSchedule: NSObject {
    var truckId: NSInteger
    var truckName: String
    var month: String
    var weekDay: String
    var dateNumber: String
    var startTime: String
    var endTime: String
    var location: String
    var streetAddress: String
    var cityState: String
    
    init(truckId: NSInteger, truckName: String, month:String, weekDay:String, dateNumber:String, startTime:String, endTime:String, location:String, streetAddress:String, cityState: String)
    {
        self.truckId = truckId
        self.truckName = truckName
        self.month = month
        self.weekDay = weekDay
        self.dateNumber = dateNumber
        self.startTime = startTime
        self.endTime = endTime
        self.location = location
        self.streetAddress = streetAddress
        self.cityState = cityState
    }
}
