//
//  ViewControllerItems.swift
//  TruckFeed
//
//  Created by Jessica Le on 4/24/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit

public struct ViewControllerItems {
    
    static func createNavigationBarWithRightButton(_ frame: CGRect, title: String, rightBarButton: UIBarButtonItem) -> UINavigationBar {
        let navigationBar = UINavigationBar(frame:frame)
        let navigationItem = UINavigationItem()
        navigationItem.title = title
        NSLog("createNavigationBarWithRightButton - Navigation Item Name: \(title)")
        navigationItem.rightBarButtonItem = rightBarButton
        navigationBar.items = [navigationItem]
        
        return navigationBar
    }
    
    static func createNavigationBarWithLeftButton(_ frame: CGRect, title: String, leftBarButton: UIBarButtonItem) -> UINavigationBar {
        let navigationBar = UINavigationBar(frame:frame)
        let navigationItem = UINavigationItem()
        navigationItem.title = title
        NSLog("createNavigationBarWithLeftButton - Navigation Item Name: \(title)")
        navigationItem.leftBarButtonItem = leftBarButton
        navigationBar.items = [navigationItem]
        
        return navigationBar
    }
    
    static func createNavigationBar(_ frame: CGRect, title: String) -> UINavigationBar {
        let navigationBar = UINavigationBar(frame:frame)
        let navigationItem = UINavigationItem()
        navigationItem.title = title
        NSLog("createNavigationBarWithRightButton - Navigation Item Name: \(title)")
        navigationBar.items = [navigationItem]
        return navigationBar
    }
    
    
    static func createBarButtonItemWithImage(_ onClick: Selector, frame: CGRect, image: UIImage, target: AnyObject) -> UIBarButtonItem {
        let barButtonItem: UIButton = UIButton(type:UIButtonType.custom)
        barButtonItem.addTarget(target, action: onClick, for: UIControlEvents.touchUpInside)
        barButtonItem.frame = frame
        barButtonItem.setImage(image, for: UIControlState())
        
        let barButton = UIBarButtonItem(customView: barButtonItem)
        barButton.tintColor = UIColor.darkGray
        
        return barButton
    }
    
    static func createButton(_ title: String, onClick: Selector, frame: CGRect, target: AnyObject ) -> UIButton {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle(title, for: UIControlState())
        button.titleLabel?.font = UIFont(name: "Trebuchet MS", size: 16)
        button.tintColor = lightColor
        button.backgroundColor = darkColor
        button.addTarget(target, action: onClick, for: UIControlEvents.touchUpInside)
        button.frame = frame
        
        return button
    }
    // DONT NEED THESE
    static func createBarButtonItem(_ title: String, onClick: Selector, frame: CGRect, target: AnyObject, image: UIImage) -> UIBarButtonItem {
        let barButtonItem: UIButton = UIButton(type:UIButtonType.custom)
        barButtonItem.setTitle(title, for: UIControlState())
        barButtonItem.addTarget(target, action: onClick, for: UIControlEvents.touchUpInside)
        barButtonItem.frame = frame
        barButtonItem.setImage(image, for: UIControlState())
        
        let barButton = UIBarButtonItem(customView: barButtonItem)
        barButton.tintColor = UIColor.darkGray
        
        return barButton
    }
}
