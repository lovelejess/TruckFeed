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

        nameLabel = UILabel()
        nameLabel.textColor = secondaryColor
        nameLabel.font =  UIFont.boldSystemFontOfSize(17)
        
        typeLabel = UILabel()
        typeLabel.textColor = mainColor
        typeLabel.font =  UIFont.italicSystemFontOfSize(15)
        
        default_image = UIImageView()
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(typeLabel)
        self.contentView.addSubview(default_image)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.frame = CGRect(x: 100, y: 25, width: 250, height: 20)
        typeLabel.frame = CGRect(x: 100, y: 45, width: 250, height: 20)
        default_image.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
    }
}
