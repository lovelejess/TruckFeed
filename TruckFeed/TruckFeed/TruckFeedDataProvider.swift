//
//  TruckFeedDataProvider.swift
//  TruckFeed
//
//  Created by Jessica Le on 6/20/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit
import CoreData

open class TruckFeedDataProvider: NSObject, TruckFeedDataProviderProtocol {
    open var truckList = [Truck]()
    weak open var tableView: UITableView!
    fileprivate var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    open func getTruckFeedList() -> [Truck]
    {
        let truckListUrl = self.createURLWithEndPoint("truck/all")
        self.generateSessionDataWithURL(truckListUrl)
        
        // generates placeholder list view until data is fetched
        if (self.truckList.isEmpty)
        {
            truckList = [Truck]()
        }
        return self.truckList
    }
    
    func createURLWithEndPoint(_ endpoint: String) -> URL
    {
        let kServerUrl = "https://damp-escarpment-86736.herokuapp.com/";
        var truckListUrl = URL(string: kServerUrl)
        truckListUrl = truckListUrl?.appendingPathComponent(endpoint)
        NSLog("getTruckFeedList - url: \(truckListUrl)")
        return truckListUrl!
    }
    
    func generateSessionDataWithURL(_ url: URL) {
        
        let request = URLRequest(url:url)
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {
            response, data, error in
            if let error = error {
                NSLog("getTruckFeedList\(error.localizedDescription)")
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    self.truckList = self.parseJSON(data!)
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    });
                }
            }
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func parseJSON(_ data: Data) -> [Truck]
    {
        var json: AnyObject?
        var mappedJson = [Truck]()
        do {
            json = try JSONSerialization.jsonObject(with: data, options: []) as! [AnyObject] as AnyObject?
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
    
    func translateToTruckObject(_ json: AnyObject) -> Truck
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

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return truckList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let truckCell = tableView.dequeueReusableCell(withIdentifier: "TruckCell")
        self.configureCell(truckCell!, atIndexPath: indexPath)
        
        return truckCell!
    }
    
    func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        if let truckCell = cell as? TruckCell {
            let truck = truckList[indexPath.row] as Truck
            truckCell.nameLabel.text = truck.name
            truckCell.nameLabel.textColor = secondaryColor
            truckCell.nameLabel.font =  UIFont(name: "AppleSDGothicNeo-SemiBold", size: 17)
            truckCell.typeLabel.text = truck.type
            truckCell.typeLabel.textColor = mainColor
            truckCell.typeLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 15)
            truckCell.imageView?.image = resizeImageView(truckCell, truck: truck)
        }
        else {
            NSLog("TruckFeedDataProvider - unable to configure cell")
        }
    }
    
    func resizeImageView(_ truckCell: TruckCell, truck: Truck) -> UIImage {
        let newSize:CGSize = CGSize(width: 80 ,height: 80)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        truck.defaultImage.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        truckCell.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        
        return newImage!;
    }
}
