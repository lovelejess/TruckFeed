//
//  UserViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/4/15.
//  Copyright (c) 2015 LoveLeJess. All rights reserved.
//

import UIKit
import FBSDKLoginKit

open class UserViewController: UIViewController, UINavigationBarDelegate {

    fileprivate var truckOwner = TruckOwner.sharedInstance
    
    @IBOutlet var tableView: UITableView?
    fileprivate var dataProvider: AddScheduleDataProvider?
    @IBOutlet weak var submit: UIButton!
    

    override open func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.scheduleSubmitted"), object: nil, queue: nil, using: scheduleSubmittedSuccessfully)
        submit.addTarget(self, action: #selector(submitSchedule), for: UIControlEvents.touchUpInside)
        
        setUpTableView()
        setUpView()
        
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissViewController(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: {});
    }

    func presentMainLoginScreen(_ sender: AnyObject){
        NSLog(" facebookLogout - entering presentMainLoginScreen")
        if let MainLoginScreenController = self.storyboard?.instantiateViewController(withIdentifier: "MainLoginScreen") as? MainLoginScreenController {
            self.present(MainLoginScreenController, animated: true, completion:
                {
                    NSLog("facebookLogout - Presenting MainLoginScreen")
            })
        }
    }


    // MARK: - PRIVATE METHODS
    func presentSubmitAlert(_ title: String, message: String) {
        if let _: AnyClass = NSClassFromString("UIAlertController") { // iOS 8
            let myAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(myAlert, animated: true, completion: nil)
        } else { // iOS 7
            let alert: UIAlertView = UIAlertView()
            alert.delegate = self
            
            alert.title = title
            alert.message = message
            alert.addButton(withTitle: "OK")
            
            alert.show()
        }
    }
    
    
    func setUpTableView()
    {
        dataProvider = AddScheduleDataProvider()
        self.tableView!.delegate = self
        self.tableView!.dataSource = dataProvider
        dataProvider?.tableView = tableView
        self.tableView!.estimatedRowHeight = 100
        self.tableView!.rowHeight = UITableViewAutomaticDimension
        self.tableView!.setNeedsLayout()
        self.tableView!.layoutIfNeeded()
    }
    
    func setUpView() {
        self.view.isOpaque = false
        self.view.tintColor = mainColor
        
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 54)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: "Add Truck Schedule")
        self.view.addSubview(navigationBar)
    }

    func submitSchedule() {
        print("submitSchedule pressed")
        let start_date_time = getStartDateTimeFromLabel()
        let end_date_time = getEndDateTimeFromLabel()
        
        dataProvider?.postSchedule(start_date_time: start_date_time, end_date_time: end_date_time)
    }
    
    private func scheduleSubmittedSuccessfully(notification: Notification) -> Void {
        if let userInfo = notification.userInfo {
            if let message = userInfo["message"]  as? String {
                presentSubmitAlert("Submitting Truck Schedule", message: message)
            }
        }
    }

    private func getStartDateTimeFromLabel() -> [String] {
        let startDateSwitchCell = self.tableView?.visibleCells[0] as? StartDateSwitchCell
        if let dateFromLabel = startDateSwitchCell?.startDateLabel.text {
            let dateTime = dateFromLabel.components(separatedBy: " ")
            NSLog("UserViewController: getStartDateTimeFromLabel dateTime \(dateTime)")
            return dateTime
        }
        return DateUtility.getCurrentDateTime().components(separatedBy: " ")
    }
    
    private func getEndDateTimeFromLabel() -> [String] {
        let endDateSwitchCell = self.tableView?.visibleCells[1] as? EndDateSwitchCell
        if let dateFromLabel = endDateSwitchCell?.endDateLabel.text {
            let dateTime = dateFromLabel.components(separatedBy: " ")
            NSLog("UserViewController: getEndDateTimeFromLabel dateTime \(dateTime)")
            return dateTime
        }
        return DateUtility.getCurrentDateTime().components(separatedBy: " ")
    }

}

extension UserViewController: UITableViewDelegate
{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("UserViewController: You selected cell #\(indexPath.row)!")
        NSLog("UserViewController: Presenting DisplayPickerController")
        tableView.deselectRow(at: indexPath, animated: true)
        self.presentDatePickerController(self, indexPath: indexPath)
    }
    
    func presentDatePickerController(_ sender: AnyObject, indexPath: IndexPath){
        NSLog("presentDatePickerController")
        if let DatePickerController = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerController") as? DatePickerController {
            
            if (indexPath.row == 0) {
                DatePickerController.notificationToPost = "com.lovelejess.startDateLabelSelected"
            }
            else if (indexPath.row == 1) {
                DatePickerController.notificationToPost = "com.lovelejess.endDateLabelSelected"
            }
            self.present(DatePickerController, animated: true, completion: {})
        }
    }
}
