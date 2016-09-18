//
//  MenuDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/16/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

public class MenuDataProvider: NSObject, MenuDataProviderProtocol {
    public var menuList = [MenuListItem]()
    weak public var tableView: UITableView!
    
    public func getMenuList() -> [MenuListItem] {
        if(FacebookCredentials.isLoggedIn())
        {
            self.menuList = [MenuListItem(name: "Logout")]
        }
            
        else
        {
            self.menuList = [MenuListItem(name: "Login")]
        }

        
        return self.menuList
    }
}

// MARK: - Table view data source

extension MenuDataProvider: UITableViewDataSource {
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuList.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let menuListItemCell = tableView.dequeueReusableCellWithIdentifier("MenuListItemCell")
        self.configureCell(menuListItemCell!, atIndexPath: indexPath)
        
        return menuListItemCell!
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        if let menuListItemCell = cell as? MenuListItemCell {
            let menuListItem = self.menuList[indexPath.row] as MenuListItem
            menuListItemCell.name.text = menuListItem.name
            print(menuListItem.name)
            menuListItemCell.name.textColor = secondaryColor
        }
        else {
            NSLog("MenuDataProvider - unable to configure cell")
        }
    }

}



