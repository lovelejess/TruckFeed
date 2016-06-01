//
//  UserView.swift
//  TruckFeed
//
//  Created by Jessica Le on 5/31/16.
//  Copyright © 2016 LoveLeJess. All rights reserved.
//

import UIKit

class UserView: UIView {

    override init (frame : CGRect) {
        super.init(frame : frame)
    }
    
    convenience init () {
        self.init(frame:CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
}
