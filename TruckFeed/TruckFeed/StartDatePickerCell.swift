//
//  StartDatePickerCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 12/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

class StartDatePickerCell: UITableViewCell {

    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    
    override public func awakeFromNib() {
        startDatePicker.addTarget(self, action: #selector(getDate), for: UIControlEvents.valueChanged)
    }
    
    public func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date = dateFormatter.string(from: startDatePicker.date)
        print("GET DATE: \(date)")
        return date
    }

}
