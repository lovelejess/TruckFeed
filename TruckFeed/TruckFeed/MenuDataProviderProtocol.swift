//
//  MenuDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/16/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit
import Foundation


public protocol MenuDataProviderProtocol: UITableViewDataSource, UITableViewDelegate {
    weak var tableView: UITableView! { get set }
    func getMenuList() -> [Truck]
}
