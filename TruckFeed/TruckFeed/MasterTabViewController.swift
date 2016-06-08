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
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {

        let truckFeedController = setUpTruckFeedController()
        let userViewController = setUpUserViewController()
        
        let controllers = [truckFeedController, userViewController]
        self.viewControllers = controllers
        self.view.tintColor = mainColor;
    }
    
    //Delegate methods
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        return true;
    }
    
    func setUpTruckFeedController() -> UIViewController
    {
        let truckFeedController: TruckFeedController = mainStoryboard.instantiateViewControllerWithIdentifier("TruckFeedController") as! TruckFeedController
        
        let truckFeedIcon = UITabBarItem(title: "TruckFeed", image: UIImage(named: "truck.png")?.imageWithRenderingMode(.AlwaysTemplate), selectedImage: UIImage(named: "truck.png")?.imageWithRenderingMode(.AlwaysTemplate))
        truckFeedIcon.setTitleTextAttributes([NSForegroundColorAttributeName: mainColor], forState: UIControlState.Normal)
        
        truckFeedController.tabBarItem = truckFeedIcon
        
        return truckFeedController

    }
    
    func setUpUserViewController() -> UIViewController
    {
        let userViewController: UserViewController = mainStoryboard.instantiateViewControllerWithIdentifier("UserViewController") as! UserViewController
        
        let userViewIcon = UITabBarItem(title: "My Truck", image: UIImage(named: "people.png")?.imageWithRenderingMode(.AlwaysTemplate), selectedImage: UIImage(named: "people.png")?.imageWithRenderingMode(.AlwaysTemplate))
        userViewIcon.setTitleTextAttributes([NSForegroundColorAttributeName: mainColor], forState: UIControlState.Normal)
        userViewController.tabBarItem = userViewIcon
        
        return userViewController
    }
}