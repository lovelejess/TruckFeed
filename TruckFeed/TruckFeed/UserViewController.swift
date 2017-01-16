//
//  UserViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/4/15.
//  Copyright (c) 2015 LoveLeJess. All rights reserved.
//

import UIKit
import FBSDKLoginKit

open class UserViewController: UIViewController, UINavigationBarDelegate, UITextFieldDelegate, UIScrollViewDelegate {

    fileprivate var truckOwner = TruckOwner.sharedInstance
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView?
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UIPickerView!
    @IBOutlet weak var submit: UIButton!
    
    var newTruckScheduleAddress: String?
    var newTruckScheduleLocation: String?
    var newTruckScheduleCity: String?
    fileprivate var dataProvider: TableDataProviderProtocol?


    override open func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 54)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: self.truckOwner.getTruckOwnerName())
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        self.view.isOpaque = false
        self.view.tintColor = mainColor
        dataProvider = AddScheduleDataProvider()
        self.tableView!.delegate = self
        self.tableView!.dataSource = dataProvider
        dataProvider?.tableView = tableView
        self.tableView!.estimatedRowHeight = 100
        self.tableView!.rowHeight = UITableViewAutomaticDimension
        self.tableView!.setNeedsLayout()
        self.tableView!.layoutIfNeeded()

        self.scrollView.delegate = self
        self.hideKeyboard()
        
        submit.addTarget(self, action: #selector(onSubmit), for: UIControlEvents.touchUpInside)
        self.view.addSubview(scrollView)
        self.view.addSubview(navigationBar)
        
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
        self .viewDidLayoutSubviews()
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
    
    func onSubmit(_ sender: UIButton) {
        print("submitButton pressed")
        print("newTruckScheduleLocation: \(newTruckScheduleLocation)")
        print("TruckScheduleTextFieldTags \(newTruckScheduleAddress)")
        print("newTruckScheduleCity \(newTruckScheduleCity)")
        presentSubmitAlert("Truck Schedule Submitted", message:"Successfully!")
    }
    
    func startTimeSwitchToggled(_sender: UISwitch)
    {
        presentSubmitAlert("switch",message: "yes")
    }
    
}

extension UIViewController
{
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

extension UserViewController: UITableViewDelegate
{
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }

}


