//
//  Trucks.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/27/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit

struct Truck {
    var name: String
    var type: String
    var defaultImage: UIImage?
    var price: String
    
    init(name: String, type:String, defaultImage: UIImage, price: String){
        self.name = name
        self.type = type
        self.defaultImage = defaultImage
        self.price = price
    }
}

public struct TruckHelpers {
    
    static func getTruckFeedList() -> [Truck]
    {
        var trucks:[Truck]?
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        var sessionDataTask: NSURLSessionDataTask?
        let kServerUrl = "https://damp-escarpment-86736.herokuapp.com/";
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
                    trucks = self.parseJSON(data!)
                }
            }
        }
        sessionDataTask?.resume()
        if (trucks == nil)
        {
            trucks = [Truck]()
        }
        return trucks!
    }
    
    static func parseJSON(data: NSData) -> [Truck]
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
    
    static func translateToTruckObject(json: AnyObject) -> Truck
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