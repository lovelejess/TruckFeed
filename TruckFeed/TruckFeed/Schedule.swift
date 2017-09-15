//
//  Schedule.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/13/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import RealmSwift

class Schedule: Object {
    dynamic var startDate: String = DateUtility.getCurrentDateTime()
    dynamic var endDate: String = DateUtility.getCurrentDateTime()
}

