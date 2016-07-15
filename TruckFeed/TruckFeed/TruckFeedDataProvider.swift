//
//  TruckFeedDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 6/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit
import CoreData

public class TruckFeedDataProvider: NSObject, TruckFeedDataProviderProtocol,UITableViewDataSource, UITableViewDelegate {
    public var truckList = [Truck]()
    weak public var tableView: UITableView!
    private var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    public func getTruckFeedList() -> [Truck]
    {
        let truckListUrl = self.createURLWithEndPoint("trucks.json")
        self.generateSessionDataWithURL(truckListUrl)
        
        // generates placeholder list view until data is fetched
        if (self.truckList.isEmpty)
        {
            truckList = [Truck]()
        }
        return self.truckList
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
                    dispatch_async(dispatch_get_main_queue(),{
                        self.tableView.reloadData()
                    });
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
    
    func configureCell(truckCell: TruckCell, atIndexPath indexPath: NSIndexPath) {
        let truck = truckList[indexPath.row] as Truck
        truckCell.nameLabel.text = truck.name
        truckCell.typeLabel.text = truck.type
        truckCell.imageView!.image = resizeImageView(truckCell, truck: truck)
        truckCell.price.text = truck.price
    }
//}


// MARK: - Table view data source
//extension TruckFeedDataProvider: UITableViewDataSource, UITableViewDelegate {

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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

    public func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return 75.0;
    }

    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let truckCell = TruckCell(style: UITableViewCellStyle.Default, reuseIdentifier: "TruckCell")
        self.configureCell(truckCell, atIndexPath: indexPath)
        return truckCell
    }
    
    public func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath){
        NSLog("You selected cell #\(indexPath.row)!")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        truckCellDelegate.foodTruckCellSelected("FoodTruckName")
        
    }
}
