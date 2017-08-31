//
//  DatePickerController.swift
//  TruckFeed
//
//  Created by Jessica Le on 8/26/17.
//  Copyright © 2017 LoveLeJess. All rights reserved.
//

import UIKit

class DatePickerController: UIViewController {
    @IBOutlet weak var startDatePicker: UIDatePicker!
    var scheduleDatePickerDelegate: ScheduleDatePickerProtocol?
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 55)
        let leftBarButtonItem = ViewControllerItems.createBarButtonItemWithImage(#selector(self.dismissViewController), frame:CGRect(x: 0, y: 0, width: 30, height: 30), image: UIImage(named: "back_button_small.png")!, target: self)
        let navigationBar = ViewControllerItems.createNavigationBarWithLeftButton(frame, title: "Add Start Date", leftBarButton: leftBarButtonItem)
        self.view.addSubview(navigationBar)
    }
    
    func dismissViewController(_ sender: AnyObject) {
        self.scheduleDatePickerDelegate?.updateDateLabel(date: getSelectedDate());
        self.dismiss(animated: true, completion: {});
    }
    
    func getSelectedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        let date = dateFormatter.string(from: startDatePicker.date)
        return date
    }


}
