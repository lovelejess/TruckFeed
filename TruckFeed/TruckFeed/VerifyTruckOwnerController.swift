//
//  VerifyTruckOwnerController.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/29/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class VerifyTruckOwnerController: UIViewController {
    
    @IBOutlet var tableView: UITableView?
    fileprivate var dataProvider: TruckFeedDataProviderProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 15, width: self.view.frame.size.width, height: 55)
        let leftBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.dismissViewController), frame:CGRect(x: 0, y: 15, width: 20, height: 20), image: UIImage(named: "back_button")!, target: self)
        let rightBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.cancel), frame:CGRect(x: 0, y: 15, width: 15, height: 20), image: UIImage(named: "cancel_button")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithButtons(frame, title: "Verify Truck Owner", leftBarButton: leftBarButtonItem, rightBarButton: rightBarButtonItem)
        self.view.addSubview(navigationBar)
    }
    
    func dismissViewController(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {});
    }
    
    func cancel() {
        self.dismiss(animated: true, completion: {});
    }
}

