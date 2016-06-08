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

class TruckFeedController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate {
    
    var tableView: UITableView  =   UITableView()
//    let kServerUrl = "http://localhost:5000/";
    let kServerUrl = "https://damp-escarpment-86736.herokuapp.com/";

    let FBLoginManager = FBSDKLoginManager()
    var truckOwner:TruckOwner?

    let truckList: [Truck] = [Truck(name: "Powered By Fries", type: "Belgian fries", defaultImage: UIImage(named: "powered_by_fries.png")!, price: "$"),
                              Truck(name: "Outside Scoop", type: "Ice Cream", defaultImage: UIImage(named: "the_outside_scoop.jpg")!, price: "$"),
                              Truck(name: "The Spot", type: " Fresh, made-to-order sandwiches", defaultImage: UIImage(named: "the_spot.jpg")!, price: "$"),
                              Truck(name: "Ferinheit Wood Oven Pizza", type: "Wood Oven Pizza", defaultImage: UIImage(named: "ferinheit_pizza.jpg")!, price: "$"),
                              Truck(name: "Let's Toast", type: "Spanish Tapas", defaultImage: UIImage(named: "lets_toast.jpg")!, price: "$"),
                              Truck(name: "Parlo Pizza", type: "Authentic Neapolitan pizzas", defaultImage: UIImage(named: "parlo_pizza.jpg")!, price: "$"),
                              Truck(name: "Karam's Grill", type: "Mediterranean", defaultImage: UIImage(named: "karams_grill.jpg")!, price: "$"),
                              Truck(name: "Street Eats DSM", type: "Stuffed sammiches with hand-cut fries", defaultImage: UIImage(named: "street_eats_dsm.jpg")!, price: "$")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        truckOwner?.userDefaults = NSUserDefaults.standardUserDefaults()
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: "TruckFeed")
        
        self.view.addSubview(createTableView(tableView))
        self.view.addSubview(navigationBar)

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
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
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        truck.defaultImage!.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        truckCell.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        
        return newImage;
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 75.0;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let truckCell = TruckCell(style: UITableViewCellStyle.Default, reuseIdentifier: "TruckCell")
        let truck = truckList[indexPath.row] as Truck
        truckCell.nameLabel.text = truck.name
        truckCell.typeLabel.text = truck.type
        truckCell.imageView!.image = resizeImageView(truckCell, truck: truck)
        truckCell.price.text = truck.price
        
        return truckCell
    }
  
    // PRIVATE HELPERS
   
    func createTableView(tableView: UITableView) -> UITableView
    {
        tableView.frame = CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height);
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.registerClass(TruckCell.self, forCellReuseIdentifier: "TruckCell")
        
        return tableView
    }
    

}
