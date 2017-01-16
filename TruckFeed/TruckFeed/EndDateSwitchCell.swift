//
//  EndDateSwitchCellTableViewCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 1/8/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class EndDateSwitchCell: UITableViewCell {

    @IBOutlet weak var endDateSwitch: UISwitch!
    
    public var delegate: AddScheduleDataProvider?
    
    override func awakeFromNib() {
        endDateSwitch.addTarget(self, action: #selector(endTimeSwitchToggled), for: UIControlEvents.valueChanged)
    }
    
    func endTimeSwitchToggled(){
        delegate!.reloadTableData()
    }
}
