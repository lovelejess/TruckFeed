//
//  MenuDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/16/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

open class MenuDataProvider: NSObject, MenuDataProviderProtocol {
    open var menuList = [MenuListItem]()
    weak open var tableView: UITableView!
    
    open func getMenuList() -> [MenuListItem] {
        if(User.isLoggedIn())
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
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let menuListItemCell = tableView.dequeueReusableCell(withIdentifier: "MenuListItemCell")
        self.configureCell(menuListItemCell!, atIndexPath: indexPath)
        
        return menuListItemCell!
    }
    
    func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
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



