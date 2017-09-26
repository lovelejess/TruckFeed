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

open class TruckFeedController: UIViewController, UINavigationBarDelegate {
    
    @IBOutlet var tableView: UITableView?
    fileprivate var dataProvider: TruckFeedDataProviderProtocol?
    fileprivate var truckList = [Truck]()
    let FBLoginManager = FBSDKLoginManager()
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        dataProvider = TruckFeedDataProvider()
        tableView!.delegate = self
        tableView!.dataSource = dataProvider
        self.truckList = dataProvider!.getTruckFeedList();
        dataProvider?.tableView = tableView
        
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 54)
        let lefttBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.presentMenuViewController), frame:CGRect(x: 0, y: 0, width: 20, height: 10), image: UIImage(named: "menu_button_64.png")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithLeftButton(frame, title: "TruckFeed", leftBarButton: lefttBarButtonItem)
        self.view.addSubview(navigationBar)

    }
    
    func presentMenuViewController(_ sender: AnyObject){
        NSLog("presentMenuViewController - entering presentMenuViewController")
        if let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController {
            self.present(menuViewController, animated: true, completion:
                {
                    NSLog("presentMenuViewController - Presenting MenuViewController")
            })
        }
    }
    
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DisplayTruckSchedule" {
            if let destination = segue.destination as? TruckScheduleController {
                NSLog("Presenting \(destination.title)")
                if let index = self.tableView?.indexPathForSelectedRow {
                    let navigationBarTitleHeader = "Spotted: "
                    if let cell = self.tableView?.cellForRow(at: index)
                    {
                        destination.foodTruckTitleName = navigationBarTitleHeader + (cell.textLabel?.text)!
                        destination.foodTruckName = (cell.textLabel?.text)!
                    }
                    else
                    {
                        destination.foodTruckTitleName = navigationBarTitleHeader +  "FoodTruckName"
                        destination.foodTruckName = "FoodTruckName"
                    }
                }
            }
        }
    }
}

extension TruckFeedController: UITableViewDelegate
{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75.0;
    }
    
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        NSLog("You selected cell #\(indexPath.row)!")
        NSLog("TruckFeedController: Presenting TruckScheduleController")
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
