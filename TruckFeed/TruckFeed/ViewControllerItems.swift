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
    
    static func createNavigationBarWithRightButton(frame: CGRect, title: String, rightBarButton: UIBarButtonItem) -> UINavigationBar {
        let navigationBar = UINavigationBar(frame:frame)
        let navigationItem = UINavigationItem()
        navigationItem.title = title
        NSLog("createNavigationBarWithRightButton - Navigation Item Name: \(title)")
        navigationItem.rightBarButtonItem = rightBarButton
        navigationBar.items = [navigationItem]
        
        return navigationBar
    }
    
    static func createNavigationBarWithLeftButton(frame: CGRect, title: String, leftBarButton: UIBarButtonItem) -> UINavigationBar {
        let navigationBar = UINavigationBar(frame:frame)
        let navigationItem = UINavigationItem()
        navigationItem.title = title
        NSLog("createNavigationBarWithLeftButton - Navigation Item Name: \(title)")
        navigationItem.leftBarButtonItem = leftBarButton
        navigationBar.items = [navigationItem]
        
        return navigationBar
    }
    
    static func createNavigationBar(frame: CGRect, title: String) -> UINavigationBar {
        let navigationBar = UINavigationBar(frame:frame)
        let navigationItem = UINavigationItem()
        navigationItem.title = title
        NSLog("createNavigationBarWithRightButton - Navigation Item Name: \(title)")
        navigationBar.items = [navigationItem]
        return navigationBar
    }
    
    
    static func createBarButtonItemWithImage(onClick: Selector, frame: CGRect, image: UIImage, target: AnyObject) -> UIBarButtonItem {
        let barButtonItem: UIButton = UIButton(type:UIButtonType.Custom)
        barButtonItem.addTarget(target, action: onClick, forControlEvents: UIControlEvents.TouchUpInside)
        barButtonItem.frame = frame
        barButtonItem.setImage(image, forState: UIControlState.Normal)
        
        let barButton = UIBarButtonItem(customView: barButtonItem)
        barButton.tintColor = UIColor.darkGrayColor()
        
        return barButton
    }
    
    static func createButton(title: String, onClick: Selector, frame: CGRect, target: AnyObject ) -> UIButton {
        let button = UIButton(type: UIButtonType.System)
        button.setTitle(title, forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Trebuchet MS", size: 16)
        button.tintColor = lightColor
        button.backgroundColor = darkColor
        button.addTarget(target, action: onClick, forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = frame
        
        return button
    }
    // DONT NEED THESE
    static func createBarButtonItem(title: String, onClick: Selector, frame: CGRect, target: AnyObject, image: UIImage) -> UIBarButtonItem {
        let barButtonItem: UIButton = UIButton(type:UIButtonType.Custom)
        barButtonItem.setTitle(title, forState: UIControlState.Normal)
        barButtonItem.addTarget(target, action: onClick, forControlEvents: UIControlEvents.TouchUpInside)
        barButtonItem.frame = frame
        barButtonItem.setImage(image, forState: UIControlState.Normal)
        
        let barButton = UIBarButtonItem(customView: barButtonItem)
        barButton.tintColor = UIColor.darkGrayColor()
        
        return barButton
    }
}