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
    
    override func viewWillAppear(_ animated: Bool) {

        let truckFeedController = setUpTruckFeedController()
        let userViewController = setUpUserViewController()
        
        let controllers = [truckFeedController, userViewController]
        self.viewControllers = controllers
        self.view.tintColor = mainColor;
    }
    
    //Delegate methods
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true;
    }
    
    func setUpTruckFeedController() -> UIViewController
    {
        let truckFeedController: TruckFeedController = mainStoryboard.instantiateViewController(withIdentifier: "TruckFeedController") as! TruckFeedController
        
        let truckFeedIcon = UITabBarItem(title: "TruckFeed", image: UIImage(named: "truck.png")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "truck.png")?.withRenderingMode(.alwaysTemplate))
        truckFeedIcon.setTitleTextAttributes([NSForegroundColorAttributeName: mainColor], for: UIControlState())
        
        truckFeedController.tabBarItem = truckFeedIcon
        
        return truckFeedController

    }
    
    func setUpUserViewController() -> UIViewController
    {
        let userViewController: UserViewController = mainStoryboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        
        let userViewIcon = UITabBarItem(title: "My Truck", image: UIImage(named: "people.png")?.withRenderingMode(.alwaysTemplate), selectedImage: UIImage(named: "people.png")?.withRenderingMode(.alwaysTemplate))
        userViewIcon.setTitleTextAttributes([NSForegroundColorAttributeName: mainColor], for: UIControlState())
        userViewController.tabBarItem = userViewIcon
        
        return userViewController
    }
}
