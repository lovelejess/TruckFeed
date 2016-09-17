//
//  MenuDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/16/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

public class MenuDataProvider: NSObject, MenuDataProviderProtocol {
    public var menuList = [Truck]()
    weak public var tableView: UITableView!
    private var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    public func getMenuList() -> [Truck] {
        return [Truck]()
    }
    
}

// MARK: - Table view data source

extension MenuDataProvider: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuList.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let truckCell = tableView.dequeueReusableCellWithIdentifier("TruckCell")
        self.configureCell(truckCell!, atIndexPath: indexPath)
        
        return truckCell!
    }
    
    public func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
    
    }
}



