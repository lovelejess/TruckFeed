//
//  Trucks.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/27/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit

public struct Truck {
    var name: String
    var type: String
    var defaultImage: UIImage
    var price: String
    
    init(name: String, type:String, defaultImage: UIImage, price: String){
        self.name = name
        self.type = type
        self.defaultImage = defaultImage
        self.price = price
    }
}