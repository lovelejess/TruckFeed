//
//  EndDatePickerCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 1/8/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class EndDatePickerCell: UITableViewCell {

       @IBOutlet weak var endDatePicker: UIDatePicker!
    
    override public func awakeFromNib() {
        endDatePicker.addTarget(self, action: #selector(getDate), for: UIControlEvents.valueChanged)
    }
    
    public func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date = dateFormatter.string(from: endDatePicker.date)
        let userInfo = ["date": date] as [String :String]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "com.lovelejess.endDateLabelSelected"), object: self, userInfo: userInfo)
        return date
    }


}
