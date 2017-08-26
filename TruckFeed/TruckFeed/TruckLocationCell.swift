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
        truckLocationTextField.placeholder = "Spotted Location"
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.truckLocationSelected"), object: nil, queue: nil, using: getLocationName)
    
    }
    
    func getLocationName(notification: Notification) -> Void {
        if let userInfo = notification.userInfo {
            if let name = userInfo["name"]  as? String {
                truckLocationTextField.text = name
            }
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("TruckLocationCell - searchBarTextDidBeginEditing")
        self.truckLocationDelegate?.presentGooglePlacesAutoComplete()
    }
}
