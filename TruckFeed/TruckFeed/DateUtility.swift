//
//  DateUtility.swift
//  TruckFeed
//
//  Created by Jessica Le on 1/25/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import Foundation

class DateUtility {

    class func getCurrentDateTime() -> String {
        let currentDateTime = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date = dateFormatter.string(from: currentDateTime)
        return date
    }

}
