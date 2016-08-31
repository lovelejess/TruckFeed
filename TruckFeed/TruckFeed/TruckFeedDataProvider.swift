//
//  TruckFeedDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 6/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit
import CoreData

public class TruckFeedDataProvider: NSObject, TruckFeedDataProviderProtocol {
    public var truckList = [Truck]()
    weak public var tableView: UITableView!
    private var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    public func getTruckFeedList() -> [Truck]
    {
        let truckListUrl = self.createURLWithEndPoint("trucks/all")
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
            json = try NSJSONSerialization.JSONObjectWithData(data, options: []) as! [AnyObject]
            NSLog("parseJSON - json : \(json)")
            let truckArray = json as! [AnyObject]
                for truck in truckArray {
                    let mappedTruck = self.translateToTruckObject(truck)
                    mappedJson.append(mappedTruck)
                }
        } catch {
            NSLog("parseJSON - error: \(error)")
        }
        return mappedJson
    }
    
    func translateToTruckObject(json: AnyObject) -> Truck
    {
        NSLog("translateToTruckObject - : \(json)")
        let name = json["name"] as! String
        let type = json["description_type"] as! String
        let image_url = json["image_url"] as! String
        let image = UIImage(named: image_url)
        let truckObject = Truck(name: name, type: type, defaultImage: image!, price: "$")
        return truckObject
    }
    
}


// MARK: - Table view data source
extension TruckFeedDataProvider: UITableViewDataSource {

    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckList.count
    }
    
    public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let truckCell = tableView.dequeueReusableCellWithIdentifier("TruckCell")
        self.configureCell(truckCell!, atIndexPath: indexPath)
        
        return truckCell!
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        let truckCell = cell as! TruckCell
        let truck = truckList[indexPath.row] as Truck
        truckCell.nameLabel.text = truck.name
        truckCell.nameLabel!.textColor = secondaryColor
        truckCell.nameLabel!.font =  UIFont.boldSystemFontOfSize(17)
        truckCell.typeLabel.text = truck.type
        truckCell.typeLabel!.textColor = mainColor
        truckCell.typeLabel!.font =  UIFont.italicSystemFontOfSize(15)
        truckCell.imageView!.image = resizeImageView(truckCell, truck: truck)
        
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
}
