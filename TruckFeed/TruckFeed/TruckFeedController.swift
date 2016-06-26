//
//  TruckFeedController.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/28/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit

public class TruckFeedController: UIViewController, UITableViewDelegate, UINavigationBarDelegate {
    
    var tableView: UITableView  =   UITableView()
    public var dataProvider: TruckFeedDataProviderProtocol?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = TruckFeedDataProvider()
//        assert(dataProvider != nil, "dataProvider is not allowed to be nil at this point")
        dataProvider!.getTruckFeedList();
        tableView.dataSource = dataProvider
        tableView.delegate = dataProvider
        dataProvider?.tableView = tableView
        
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: "TruckFeed")
        self.view.addSubview(createTableView(tableView))
        self.view.addSubview(navigationBar)

    }
    override public func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
  
    // PRIVATE HELPERS
   
    func createTableView(tableView: UITableView) -> UITableView
    {
        tableView.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height);
        tableView.registerClass(TruckCell.self, forCellReuseIdentifier: "TruckCell")
        
        return tableView
    }
    
    

}
