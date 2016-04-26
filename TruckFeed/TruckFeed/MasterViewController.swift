//
//  MasterViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/28/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import UIKit
import CoreData
import FBSDKLoginKit

class MasterViewController: UIViewController, UITableViewDataSource, UINavigationBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    let FBLoginManager = FBSDKLoginManager()
    var truckOwner:TruckOwner?
    let truckList: [Truck] = [Truck(name: "Powered By Fries", type: "Belgian fries", defaultImage: UIImage(named: "powered_by_fries.png")!, price: "$"),
                              Truck(name: "Outside Scoop", type: "Dessert", defaultImage: UIImage(named: "the_outside_scoop.jpg")!, price: "$"),
                              Truck(name: "The Spot", type: " Fresh, made-to-order sandwiches", defaultImage: UIImage(named: "the_spot.jpg")!, price: "$"),
                              Truck(name: "Ferinheit Wood Oven Pizza", type: "Wood Oven Pizza", defaultImage: UIImage(named: "ferinheit_pizza.jpg")!, price: "$"),
                              Truck(name: "Let's Toast", type: "Spanish Tapas", defaultImage: UIImage(named: "lets_toast.jpg")!, price: "$"),
                              Truck(name: "Parlo Pizza", type: "Authentic Neapolitan pizzas", defaultImage: UIImage(named: "parlo_pizza.jpg")!, price: "$"),
                              Truck(name: "Karam's Grill", type: "Mediterranean", defaultImage: UIImage(named: "karams_grill.jpg")!, price: "$"),
                              Truck(name: "Street Eats DSM", type: "Stuffed sammiches with hand-cut fries", defaultImage: UIImage(named: "street_eats_dsm.jpg")!, price: "$")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(view)
        truckOwner?.userDefaults = NSUserDefaults.standardUserDefaults()
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let truckLoginButton = ViewControllerItems.createBarButtonItem("", onClick:#selector(MasterViewController.truckBarButtonAction), frame:CGRectMake(0, 0, 53, 31), target: self, image: UIImage(named: "truck.png")!)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: "TruckFeed", rightBarButton: truckLoginButton)
        view.addSubview(navigationBar)
//        navigationItem.leftBarButtonItem = truckLoginButton

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
    }

    func truckBarButtonAction(){
        self.presentDashboardViewController(self)
    }
    
// PRIVATE HELPERS
    
    func presentDashboardViewController(sender: AnyObject){
        if let dashboardViewController = self.storyboard!.instantiateViewControllerWithIdentifier("DashboardViewController") as? DashboardViewController {
            self.presentViewController(dashboardViewController, animated: true, completion:
            {
                dashboardViewController.truckOwner = self.truckOwner!
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckList.count
    }
    
    func resizeImageView(truckCell: TruckCell, truck: Truck) -> UIImage {
        let newSize:CGSize = CGSize(width: 80 ,height: 80)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        truck.defaultImage!.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        truckCell.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        
        return newImage;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let truckCell = tableView.dequeueReusableCellWithIdentifier("TruckCell", forIndexPath: indexPath) as! TruckCell
        
        let truck = truckList[indexPath.row] as Truck
        truckCell.nameLabel?.text = truck.name
        truckCell.nameLabel?.textColor = secondaryColor
        truckCell.typeLabel?.text = truck.type
        truckCell.imageView?.image = resizeImageView(truckCell, truck: truck)
        truckCell.price?.text = truck.price
        
        return truckCell
    }

}
