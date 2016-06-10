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
    var truckList: [Truck]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        truckList = self.getTruckFeedList();
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
        return truckList!.count
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
        let truck = truckList![indexPath.row] as Truck
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
    
    func getTruckFeedList() -> [Truck]
    {
        var truckList:[Truck]?
        let truckListUrl = self.createURLWithEndPoint("trucks.json")
        self.generateSessionDataWithURL(truckListUrl)
        
        if (truckList == nil)
        {
            truckList = [Truck]()
        }
        return truckList!
    }
    
    func createURLWithEndPoint(endpoint: String) -> NSURL
    {
        let kServerUrl = "https://damp-escarpment-86736.herokuapp.com/";
        var truckListUrl = NSURL(string: kServerUrl)
        truckListUrl = truckListUrl?.URLByAppendingPathComponent(endpoint)
        NSLog("getTruckFeedList - url: \(truckListUrl)")
        return truckListUrl!
    }
        
    func generateSessionDataWithURL(url: NSURL) {
        
        let request = NSURLRequest(URL:url)
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            response, data, error in
            if let error = error {
                NSLog("getTruckFeedList\(error.localizedDescription)")
            } else if let httpResponse = response as? NSHTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.truckList = self.parseJSON(data!)
                    self.tableView.reloadData()
                }
            }
        }
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    func parseJSON(data: NSData) -> [Truck]
    {
        var json: AnyObject?
        var mappedJson = [Truck]()
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [String:AnyObject]
            NSLog("parseJSON - json : \(json)")
            if let trucksDictionary = json as? NSDictionary {
                if let truckArray = trucksDictionary["trucks"] as? NSArray {
                    for truck in truckArray {
                        let mappedTruck = self.translateToTruckObject(truck)
                        mappedJson.append(mappedTruck)
                    }
                }
            }
        } catch {
            NSLog("parseJSON - error: \(error)")
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
