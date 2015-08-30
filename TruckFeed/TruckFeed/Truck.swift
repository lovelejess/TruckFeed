//
//  Trucks.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/27/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import Foundation
import UIKit

@objc
class Truck: NSObject {
    var name: String
    var type: String
    var defaultImage: UIImage?
    
    init(name: String, type:String, defaultImage: UIImage){
        self.name = name
        self.type = type
        self.defaultImage = defaultImage
        super.init()
        
    }
}