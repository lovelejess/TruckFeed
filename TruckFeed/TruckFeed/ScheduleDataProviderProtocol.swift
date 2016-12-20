//
//  ScheduleDataProviderProtocol.swift
//  TruckFeed
//
//  Created by Jessica Le on 7/7/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit

public protocol ScheduleDataProviderProtocol: UITableViewDataSource, UITableViewDelegate {
    weak var tableView: UITableView! { get set }
    func getScheduleForTruck(_ truckId: String) -> [TruckSchedule]
}
