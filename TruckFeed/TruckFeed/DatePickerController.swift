//
//  DatePickerController.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/26/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker?
    public var notificationToPost: String?
    public var navigationTitle: String?
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 15, width: self.view.frame.size.width, height: 55)
        let leftBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.dismissViewController), frame:CGRect(x: 0, y: 15, width: 20, height: 20), image: UIImage(named: "back_button")!, target: self)
        let rightBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.cancelDateSelection), frame:CGRect(x: 0, y: 15, width: 15, height: 20), image: UIImage(named: "cancel_button")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithButtons(frame, title: navigationTitle!, leftBarButton: leftBarButtonItem, rightBarButton: rightBarButtonItem)
        self.view.addSubview(navigationBar)
    }
    
    func dismissViewController(_ sender: AnyObject) {
        let userInfo = ["date": self.getSelectedDate()] as [String :String]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: notificationToPost!), object: self, userInfo: userInfo)
        self.dismiss(animated: true, completion: {});
    }
    
    func cancelDateSelection() {
        self.dismiss(animated: true, completion: {});
    }
    
    func getSelectedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date = dateFormatter.string(from: datePicker!.date)
        return date
    }


}
