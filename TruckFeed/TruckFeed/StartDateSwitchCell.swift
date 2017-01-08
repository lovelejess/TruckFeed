//
//  StartDateSwitchCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 12/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

class StartDateSwitchCell: UITableViewCell {

    @IBOutlet weak var startDateSwitch: UISwitch!
    
    public var delegate: AddScheduleDataProvider?
    
    override func awakeFromNib() {
        startDateSwitch.addTarget(self, action: #selector(startTimeSwitchToggled), for: UIControlEvents.valueChanged)
    }
    
    func startTimeSwitchToggled(){
        delegate!.reloadTableData()
    }
}
