//
//  MasterTabViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 5/4/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit
import Foundation

class MasterTabViewController : UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        let truckFeedController = TruckFeedController()
        let truckFeedIcon = UITabBarItem(title: "TruckFeed", image: UIImage(named: "truck.png")?.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: "truck.png")?.imageWithRenderingMode(.AlwaysOriginal))
        truckFeedIcon.setTitleTextAttributes([NSForegroundColorAttributeName: mainColor], forState: UIControlState.Normal)
        truckFeedController.tabBarItem = truckFeedIcon
        
        let userViewController = UserViewController()
        let userViewIcon = UITabBarItem(title: "Guest", image: UIImage(named: "people.png")?.imageWithRenderingMode(.AlwaysOriginal), selectedImage: UIImage(named: "people.png")?.imageWithRenderingMode(.AlwaysOriginal))
        userViewIcon.setTitleTextAttributes([NSForegroundColorAttributeName: mainColor], forState: UIControlState.Normal)
        userViewController.tabBarItem = userViewIcon
        let controllers = [truckFeedController, userViewController]
        self.viewControllers = controllers
    }
    
    //Delegate methods
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        return true;
    }
}