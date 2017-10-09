//
//  DictionaryParser.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/7/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class DictionaryParser: NSObject {
    
    static func parseKeyFromResponse(key: String, response: NSDictionary) -> String {
        var value = ""
        if let parsedValue = response.value(forKey: key) as! String? {
            value = parsedValue
        }
        return value
    }
}
