//
//  MenuViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/16/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit

public class MenuViewController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet var tableView: UITableView?
    private var dataProvider: MenuDataProvider?
    private var menuList = [Truck]()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = MenuDataProvider()
        tableView!.delegate = self
        tableView!.dataSource = dataProvider
        self.menuList = dataProvider!.getMenuList();
        dataProvider?.tableView = tableView
        
        
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let lefttBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.dismissViewController), frame:CGRectMake(0, 0, 43, 31), image: UIImage(named: "back.png")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithLeftButton(frame, title: "Settings", leftBarButton: lefttBarButtonItem)
        self.view.addSubview(navigationBar)
        
    }
    
    func dismissViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
}



extension MenuViewController: UITableViewDelegate
{
    
    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 120.0;
    }
    
}

