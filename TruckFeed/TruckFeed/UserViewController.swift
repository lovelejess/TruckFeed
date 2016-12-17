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
    @IBOutlet weak var startDateView: UIView!
    @IBOutlet weak var endDateView: UIView!
    @IBOutlet weak var addressView: UIView!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var startTimeSwitch: UISwitch!
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var endTimeSwitch: UISwitch!
    @IBOutlet weak var endTime: UIDatePicker!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UIPickerView!
    @IBOutlet weak var submit: UIButton!
    
    var newTruckScheduleAddress: String?
    var newTruckScheduleLocation: String?
    var newTruckScheduleCity: String?


    override open func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 54)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: self.truckOwner.getTruckOwnerName())
        scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.view.frame.height+100)
        self.view.isOpaque = false
        self.view.tintColor = mainColor
        
        
        location.delegate = self
        address.delegate = self
        city.delegate = self
        self.scrollView.delegate = self
        self.hideKeyboard()
        
        submit.addTarget(self, action: #selector(onSubmit), for: UIControlEvents.touchUpInside)
        startTimeSwitch.addTarget(self, action: #selector(startTimeSwitchToggled), for: UIControlEvents.valueChanged)
        endTimeSwitch.addTarget(self, action: #selector(endTimeSwitchToggled), for: UIControlEvents.valueChanged)
        startTimeSwitchToggled(self.startTimeSwitch)
        endTimeSwitchToggled(self.endTimeSwitch)
        
        self.scrollView.addSubview(addressView)
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

    
    // MARK: UITextFieldDelegate
    
    open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        determineTextFieldToFocus(textField)
        return true
    }
    
    open func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField.tag {
            case TruckScheduleTextFieldTags.locationTag.rawValue:
                scrollView.contentOffset = textField.frame.origin
            
            case TruckScheduleTextFieldTags.addressTag.rawValue:
                scrollView.contentOffset = textField.frame.origin
            
            case TruckScheduleTextFieldTags.cityTag.rawValue:
                scrollView.contentOffset = textField.frame.origin
            default:
                print("did not match")
            }
        
    }
    
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    open func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
            case TruckScheduleTextFieldTags.locationTag.rawValue:
                setAutoScrollFocus(CGPoint(x: 0, y: 0))
                newTruckScheduleLocation = textField.text
                    
            case TruckScheduleTextFieldTags.addressTag.rawValue:
                setAutoScrollFocus(CGPoint(x: 0, y: 0))
                newTruckScheduleAddress = textField.text

            case TruckScheduleTextFieldTags.cityTag.rawValue:
                setAutoScrollFocus(CGPoint(x: 0, y: 0))
                newTruckScheduleCity = textField.text
            
            default:
                print("did not match")
        }
    }
    
    fileprivate func determineTextFieldToFocus(_ textField: UITextField) {
        switch textField.tag {
            case TruckScheduleTextFieldTags.locationTag.rawValue:
                textField.becomeFirstResponder()
                
            case TruckScheduleTextFieldTags.addressTag.rawValue:
                textField.becomeFirstResponder()
                
            case TruckScheduleTextFieldTags.cityTag.rawValue:
                textField.becomeFirstResponder()
            setAutoScrollFocus(CGPoint(x: 0, y: -100))
            
        default:
            print("did not match")
        }

    }
    
    // MARK: TextField Tag Enum
    
    enum TruckScheduleTextFieldTags : Int {
        case locationTag = 0
        case addressTag = 1
        case cityTag = 2
    }
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
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
    
    func startTimeSwitchToggled(_ sender: UISwitch){
        if (sender.isOn && self.endTimeSwitch.isOn){
            self.addressView.frame = CGRect(x: 0, y: 395, width: self.view.frame.size.width, height: self.addressView.frame.size.height)
            self.startDateView.isHidden = false
        }
        else if(sender.isOn && !self.endTimeSwitch.isOn){
            self.addressView.frame = CGRect(x: 0, y: 265, width: self.view.frame.size.width, height: self.addressView.frame.size.height)
            self.startDateView.isHidden = false
        }
        else {
            let startViewFrame = self.startDateView.frame
            self.startDateView.isHidden = true
            self.addressView.frame = startViewFrame
        }
    }
    
    func endTimeSwitchToggled(_ sender: UISwitch){
        if (sender.isOn && self.startTimeSwitch.isOn){
            self.addressView.frame = CGRect(x: 0, y: 395, width: self.view.frame.size.width, height: self.addressView.frame.size.height)
            self.endDateView.isHidden = false
        }
        else if(sender.isOn && !self.startTimeSwitch.isOn){
            self.endTimeView.frame = CGRect(x: 0, y: 90, width: self.view.frame.size.width, height: self.addressView.frame.size.height)
            self.addressView.frame = CGRect(x: 0, y: 240, width: self.view.frame.size.width, height: self.addressView.frame.size.height)
            self.endDateView.isHidden = false
        }
        else {
            let endViewFrame = self.endDateView.frame
            self.endDateView.isHidden = true
            self.addressView.frame = endViewFrame
        }
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
