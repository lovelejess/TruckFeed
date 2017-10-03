//
//  FacebookAPI.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/2/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class FacebookAPI: NSObject {
    static func setFacebookRequestOperationsQueue(_ facebookRequestOperation: BlockOperation, presentUserViewOperation: BlockOperation ) {
        let queue = OperationQueue()
        presentUserViewOperation.addDependency(facebookRequestOperation)
        queue.addOperation(facebookRequestOperation)
        queue.addOperation(presentUserViewOperation)
    }

}
