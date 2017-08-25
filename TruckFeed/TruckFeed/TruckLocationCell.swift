//
//  TruckLocationCell.swift
//  TruckFeed
//
//  Created by Jessica Le on 5/31/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class TruckLocationCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var truckLocationTextField: UITextField!
    
    public var delegate: AddScheduleDataProvider?
    public var truckLocationDelegate: TruckLocationCellProtocol?
    
    override func awakeFromNib() {
        truckLocationTextField.delegate = self
//        truckLocationTextField.addTarget(self, action: #selector(getLocationName), for: UIControlEvents.valueChanged)
    }
    
    func getLocationName(){
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TruckLocationCell - searchBarTextDidBeginEditing")
        self.truckLocationDelegate?.presentGooglePlacesAutoComplete()
    }
}
