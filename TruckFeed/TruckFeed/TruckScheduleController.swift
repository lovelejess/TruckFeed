//
//  TruckScheduleController.swift
//  TruckFeed
//
//  Created by Jessica Le on 7/7/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

open class TruckScheduleController: UIViewController {
    
    @IBOutlet var tableView: UITableView?
    fileprivate var dataProvider: ScheduleDataProviderProtocol?
    fileprivate var truckScheduleList = [TruckSchedule]()
    open var foodTruckName: String?
    open var foodTruckTitleName: String?
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = ScheduleDataProvider()
        tableView!.delegate = self
        tableView!.dataSource = dataProvider
        self.truckScheduleList = dataProvider!.getScheduleForTruck(foodTruckName!);
        dataProvider?.tableView = tableView
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 55)
        let leftBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.dismissViewController), frame:CGRect(x: 0, y: 0, width: 30, height: 30), image: UIImage(named: "back.png")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithLeftButton(frame, title: foodTruckTitleName!, leftBarButton: leftBarButtonItem)
        self.view.addSubview(navigationBar)
    }
    
    func dismissViewController(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {});
    }
}

extension TruckScheduleController: UITableViewDelegate
{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 120.0;
    }
    
}

