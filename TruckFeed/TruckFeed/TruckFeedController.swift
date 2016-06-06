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
    var truckList: [Truck] = []

//    let truckList: [Truck] = [Truck(name: "Powered By Fries", type: "Belgian fries", defaultImage: UIImage(named: "powered_by_fries.png")!, price: "$"),
//                              Truck(name: "Outside Scoop", type: "Ice Cream", defaultImage: UIImage(named: "the_outside_scoop.jpg")!, price: "$"),
//                              Truck(name: "The Spot", type: " Fresh, made-to-order sandwiches", defaultImage: UIImage(named: "the_spot.jpg")!, price: "$"),
//                              Truck(name: "Ferinheit Wood Oven Pizza", type: "Wood Oven Pizza", defaultImage: UIImage(named: "ferinheit_pizza.jpg")!, price: "$"),
//                              Truck(name: "Let's Toast", type: "Spanish Tapas", defaultImage: UIImage(named: "lets_toast.jpg")!, price: "$"),
//                              Truck(name: "Parlo Pizza", type: "Authentic Neapolitan pizzas", defaultImage: UIImage(named: "parlo_pizza.jpg")!, price: "$"),
//                              Truck(name: "Karam's Grill", type: "Mediterranean", defaultImage: UIImage(named: "karams_grill.jpg")!, price: "$"),
//                              Truck(name: "Street Eats DSM", type: "Stuffed sammiches with hand-cut fries", defaultImage: UIImage(named: "street_eats_dsm.jpg")!, price: "$")]
//    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        truckList = self.intializeTruckFeedList()
        
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
    

    func intializeTruckFeedList() -> [Truck]
    {
//        var truckList: [Truck]
        let truckList = [Truck]()
        self.getTruckFeedList()
//        let responseData = self.getTruckFeedList()
//        let truckJSON = self.parseJSON(responseData)
//        truckList = self.translateToTruckObject(truckJSON!)
        return truckList
    }
    
    func getTruckFeedList()
    {
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        var sessionDataTask: NSURLSessionDataTask?
        var truckListUrl = NSURL(string: kServerUrl)
        truckListUrl = truckListUrl?.URLByAppendingPathComponent("trucks.json")
        NSLog("getTruckFeedList - url: \(truckListUrl)")
        sessionDataTask = session.dataTaskWithURL(truckListUrl!) {
            data, response, error in
            dispatch_async(dispatch_get_main_queue()) {
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            }
            if let error = error {
                NSLog("getTruckFeedList\(error.localizedDescription)")
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.parseJSON(data!)
                }
            }
        }
        sessionDataTask?.resume()
    }
    
    func parseJSON(data: NSData) -> Truck
    {
        var json: AnyObject?
        var mappedJson = Truck(name: "", type: "", defaultImage: UIImage(named:"powered_by_fries.png")!, price: "")
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
            NSLog("parseJSON - json : \(json)")
            if let trucksDictionary = json as? NSDictionary {
//                NSLog("parseJSON - Truck List: \(trucksDictionary["trucks"])")
//                NSLog("parseJSON - Trucks: \(trucksDictionary["trucks"]![0]!["truck"])")
                let truckArray = trucksDictionary["trucks"] as? NSArray
//                NSLog("parseJSON - Trucks: \(truckArray)")
                let oneTruck = truckArray![0] as? NSDictionary
                mappedJson = oneTruck.map({ (item) -> Truck  in
                    return self.translateToTruckObject(item)
                })!
            }
        } catch {
            NSLog("parseJSON - error: \(error)")
//            mappedJson = Truck(name: "", type: "", defaultImage: UIImage(named:"no_image.PNG")!, price: "")
        }
        return mappedJson
    }
    
    func translateToTruckObject(json: AnyObject) -> Truck
    {
        NSLog("translateToTruckObject - : \(json)")
        let truck = json["truck"] as! NSDictionary
        let name = truck["name"] as! String
        let type = truck["type"] as! String
        let image = UIImage(named: truck["image"] as! String)
        let price = truck["price"] as! String
        let truckObject = Truck(name: name, type: type, defaultImage: image!, price: price)
        return truckObject
    }
    
}
