//
//  TableDataProviderProtocol.swift
//  TruckFeed
//
//  Created by Jessica Le on 12/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit
import Foundation

public protocol TableDataProviderProtocol: UITableViewDataSource, UITableViewDelegate {
    weak var tableView: UITableView! { get set }

}
