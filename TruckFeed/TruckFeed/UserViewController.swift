//
//  UserViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/4/15.
//  Copyright (c) 2015 LoveLeJess. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GooglePlaces

open class UserViewController: UIViewController, UINavigationBarDelegate, UITextFieldDelegate, UIScrollViewDelegate {

    fileprivate var truckOwner = TruckOwner.sharedInstance
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView?
    @IBOutlet weak var submit: UIButton!
    
    fileprivate var dataProvider: AddScheduleDataProvider?


    override open func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "com.lovelejess.scheduleSubmitted"), object: nil, queue: nil, using: scheduleSubmittedSuccessfully)
        submit.addTarget(self, action: #selector(submitSchedule), for: UIControlEvents.touchUpInside)
        
        self.hideKeyboard()
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
    
    
    // MARK: UIScroll
    
    fileprivate func setAutoScrollFocus(_ offset: CGPoint) {
        self.scrollView .setContentOffset(offset, animated: true)
        self.viewDidLayoutSubviews()
    }


    // MARK: - PRIVATE METHODS
    func createAlert(message: String, title: String) -> UIAlertView {
        let alert: UIAlertView = UIAlertView()
        alert.delegate = self
        
        alert.title = title
        alert.message = message
        alert.addButton(withTitle: "OK")
        return alert;
    }
    
    func presentSubmitAlert(_ title: String, message: String) {
        if let _: AnyClass = NSClassFromString("UIAlertController") {
            let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alert = createAlert(message: message, title: title)
            alert.show()
        }
    }
    
    
    func setUpTableView() {
        self.tableView!.delegate = self
        dataProvider = AddScheduleDataProvider()
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
        self.scrollView.delegate = self
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        self.view.addSubview(scrollView)
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

extension UserViewController: GMSAutocompleteViewControllerDelegate {
    public func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        let name = place.name
        print("Name is: \(name)")
        print("Address is: \(String(describing: place.formattedAddress))")
        
        dismiss(animated: true, completion: nil)
    }
    
    public func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    
        print("Error: \(error)")
        dismiss(animated: true, completion: nil)
    }
    
    public func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        print("Autocomplete was cancelled.")
        dismiss(animated: true, completion: nil)
    }
}

extension UIViewController {
    func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard()
    {
        view.endEditing(true)
    }
}

extension UserViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

}


