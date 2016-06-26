//
//  TruckFeedDataProviderProtocol.swift
//  TruckFeed
//
//  Created by Jessica Le on 6/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit

public protocol TruckFeedDataProviderProtocol: UITableViewDataSource, UITableViewDelegate {
    weak var tableView: UITableView! { get set }
    func getTruckFeedList() -> [Truck]
}
