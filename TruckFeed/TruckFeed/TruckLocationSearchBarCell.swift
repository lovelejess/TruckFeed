//
//  TruckLocationSearchBarCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 6/9/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit
import GooglePlaces

class TruckLocationSearchBarCell: UITableViewCell, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    public var delegate: AddScheduleDataProvider?
    public var truckLocationDelegate: TruckLocationCellProtocol?
    
    override func awakeFromNib() {
        searchBar.text = "my truck location"
        searchBar.delegate = self
    }
    
    func searchBarTextDidBeginEditing(_: UISearchBar) {
        print("TruckLocationSearchBarCell - searchBarTextDidBeginEditing")
        self.truckLocationDelegate?.presentGooglePlacesAutoComplete()
    }

}
