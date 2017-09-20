//
//  MenuViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 9/16/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit
import FBSDKCoreKit

open class MenuViewController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet var tableView: UITableView?
    fileprivate var dataProvider: MenuDataProvider?
    fileprivate var menuList = [MenuListItem]()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = MenuDataProvider()
        tableView!.delegate = self
        tableView!.dataSource = dataProvider
        self.menuList = dataProvider!.getMenuList();
        dataProvider?.tableView = tableView
        
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 54)
        let lefttBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.dismissViewController), frame:CGRect(x: 0, y: 0, width: 30, height: 30), image: UIImage(named: "back_button_64.png")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithLeftButton(frame, title: "Settings", leftBarButton: lefttBarButtonItem)
        self.view.addSubview(navigationBar)
    }
    
    func dismissViewController(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {});
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }

    func presentMainLoginViewController(_ sender: AnyObject){
        NSLog(" facebookLogout - entering presentMainLoginScreen")
        if let MainLoginScreenController = self.storyboard?.instantiateViewController(withIdentifier: "MainLoginScreen") as? MainLoginScreenController {
            self.present(MainLoginScreenController, animated: true, completion:
                {
                    NSLog("facebookLogout - Presenting MainLoginScreen")
            })
        }
    }
    
}


extension MenuViewController: UITableViewDelegate
{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 42.0;
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        NSLog("You selected cell #\(indexPath.row)!")
        tableView.deselectRow(at: indexPath, animated: true)
        if(FacebookCredentials.isLoggedIn())
        {
            FacebookCredentials.facebookLogout()
        }
        self.presentMainLoginViewController(self )
    }
    
}

