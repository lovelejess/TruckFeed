//
//  TruckCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/28/15.
//  Copyright © 2015 LoveLeJess. All rights reserved.
//

import UIKit

class TruckCell: UITableViewCell {

    var nameLabel = UILabel()
    var typeLabel = UILabel()
    var default_image = UIImageView()
    var price = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(default_image)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel = UILabel()
        nameLabel.frame = CGRect(x: 20, y: 0, width: 70, height: 30)
        nameLabel.textColor = secondaryColor
        
        typeLabel = UILabel()
        typeLabel.frame = CGRect(x: 0, y: 10, width: 20,height: 20)
        typeLabel.textColor = secondaryColor

        default_image = UIImageView()
        default_image.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        
    }
}
