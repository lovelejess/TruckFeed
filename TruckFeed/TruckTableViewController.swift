//
//  TruckTableViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/28/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import UIKit

class TruckTableViewController: UITableViewController {
    
    let truckList: [Truck] = [Truck(name: "Powered By Fries", type: "Belgian fries", defaultImage: UIImage                      (named: "powered_by_fries.png")!),
                              Truck(name: "Outside Scoop", type: "Dessert", defaultImage: UIImage(named: "the_outside_scoop.jpg")!),
                              Truck(name: "The Spot", type: " Fresh, made-to-order sandwiches", defaultImage: UIImage(named: "the_spot.jpg")!),
                              Truck(name: "Ferinheit Wood Oven Pizza", type: "Wood Oven Pizza", defaultImage: UIImage(named: "ferinheit_pizza.jpg")!),
                              Truck(name: "Let's Toast", type: "Spanish Tapas", defaultImage: UIImage(named: "lets_toast.jpg")!),
                              Truck(name: "Parlo Pizza", type: "Authentic Neapolitan pizzas", defaultImage: UIImage(named: "parlo_pizza.jpg")!),
                              Truck(name: "Karam's Grill", type: "Mediterranean", defaultImage: UIImage(named: "karams_grill.jpg")!),
                              Truck(name: "Street Eats DSM", type: "Stuffed sammiches featuring hand-cut fries", defaultImage: UIImage(named: "street_eats_dsm.jpg")!)]
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

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckList.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let truckCell = tableView.dequeueReusableCellWithIdentifier("TruckCell", forIndexPath: indexPath)
        
        let truck = truckList[indexPath.row] as Truck
        truckCell.textLabel?.text = truck.name
        truckCell.textLabel?.textColor = secondaryColor
        truckCell.detailTextLabel?.text = truck.type
        
        truckCell.imageView?.frame = CGRectMake(30,30,30,30)
        truckCell.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        truckCell.imageView?.image = truck.defaultImage
        return truckCell
    }

}
