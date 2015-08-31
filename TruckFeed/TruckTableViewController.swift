//
//  TruckTableViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/28/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import UIKit

class TruckTableViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let truckList: [Truck] = [Truck(name: "Powered By Fries", type: "Belgian fries", defaultImage: UIImage(named: "powered_by_fries.png")!, price: "$"),
                              Truck(name: "Outside Scoop", type: "Dessert", defaultImage: UIImage(named: "the_outside_scoop.jpg")!, price: "$"),
                              Truck(name: "The Spot", type: " Fresh, made-to-order sandwiches", defaultImage: UIImage(named: "the_spot.jpg")!, price: "$"),
                              Truck(name: "Ferinheit Wood Oven Pizza", type: "Wood Oven Pizza", defaultImage: UIImage(named: "ferinheit_pizza.jpg")!, price: "$"),
                              Truck(name: "Let's Toast", type: "Spanish Tapas", defaultImage: UIImage(named: "lets_toast.jpg")!, price: "$"),
                              Truck(name: "Parlo Pizza", type: "Authentic Neapolitan pizzas", defaultImage: UIImage(named: "parlo_pizza.jpg")!, price: "$"),
                              Truck(name: "Karam's Grill", type: "Mediterranean", defaultImage: UIImage(named: "karams_grill.jpg")!, price: "$"),
                              Truck(name: "Street Eats DSM", type: "Stuffed sammiches with hand-cut fries", defaultImage: UIImage(named: "street_eats_dsm.jpg")!, price: "$"),]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bringSubviewToFront(view)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let truckCell = tableView.dequeueReusableCellWithIdentifier("TruckCell", forIndexPath: indexPath) as! TruckCell
        
        let truck = truckList[indexPath.row] as Truck
        truckCell.nameLabel?.text = truck.name
        truckCell.nameLabel?.textColor = secondaryColor
        truckCell.typeLabel?.text = truck.type
        
        let newSize:CGSize = CGSize(width: 80 ,height: 80)
        let rect = CGRectMake(0,0, newSize.width, newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        
        truck.defaultImage!.drawInRect(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        truckCell.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        truckCell.imageView?.image = newImage
        
        truckCell.price?.text = truck.price
        
        return truckCell
    }

}
