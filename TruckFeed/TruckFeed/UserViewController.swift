//
//  UserViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/4/15.
//  Copyright (c) 2015 LoveLeJess. All rights reserved.
//

import UIKit
import FBSDKLoginKit

public class UserViewController: UIViewController, UINavigationBarDelegate, UITextFieldDelegate, UIScrollViewDelegate {

    private var truckOwner = TruckOwner.sharedInstance
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var startTime: UIDatePicker!
    @IBOutlet weak var startTimeSwitch: UISwitch!
    @IBOutlet weak var endTime: UIDatePicker!
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UIPickerView!
    @IBOutlet weak var submit: UIButton!
    
    var newTruckScheduleAddress: String?
    var newTruckScheduleLocation: String?
    var newTruckScheduleCity: String?


    override public func viewDidLoad() {
        super.viewDidLoad()
        let frame = CGRectMake(0, 0, self.view.frame.size.width, 54)
        let navigationBar = ViewControllerItems.createNavigationBar(frame, title: self.truckOwner.getTruckOwnerName())
        scrollView.contentSize = CGSizeMake(self.view.frame.width, self.view.frame.height+100)
        self.view.opaque = false
        self.view.tintColor = mainColor
        
        
        location.delegate = self
        address.delegate = self
        city.delegate = self
        self.scrollView.delegate = self
        self.hideKeyboard()
        
        submit.addTarget(self, action: #selector(onSubmit), forControlEvents: UIControlEvents.TouchUpInside)
        startTimeSwitch.addTarget(self, action: #selector(startTimeSwitchToggled), forControlEvents: UIControlEvents.ValueChanged)
        if (startTimeSwitch.on){
            self.uiView.hidden = false
        }
        else {
            self.uiView.hidden = true
        }
        
        self.view.addSubview(scrollView)
        self.view.addSubview(navigationBar)
        
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissViewController(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }

    func presentMainLoginScreen(sender: AnyObject){
        NSLog(" facebookLogout - entering presentMainLoginScreen")
        if let MainLoginScreenController = self.storyboard?.instantiateViewControllerWithIdentifier("MainLoginScreen") as? MainLoginScreenController {
            self.presentViewController(MainLoginScreenController, animated: true, completion:
                {
                    NSLog("facebookLogout - Presenting MainLoginScreen")
            })
        }
    }
    
    
    
    // MARK: UIScroll
    
    private func setAutoScrollFocus(offset: CGPoint) {
        self.scrollView .setContentOffset(offset, animated: true)
        self .viewDidLayoutSubviews()
    }

    
    // MARK: UITextFieldDelegate
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        determineTextFieldToFocus(textField)
        return true
    }
    
    public func textFieldDidBeginEditing(textField: UITextField) {
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
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    public func textFieldDidEndEditing(textField: UITextField) {
        switch textField.tag {
            case TruckScheduleTextFieldTags.locationTag.rawValue:
                setAutoScrollFocus(CGPointMake(0, 0))
                newTruckScheduleLocation = textField.text
                    
            case TruckScheduleTextFieldTags.addressTag.rawValue:
                setAutoScrollFocus(CGPointMake(0, 0))
                newTruckScheduleAddress = textField.text

            case TruckScheduleTextFieldTags.cityTag.rawValue:
                setAutoScrollFocus(CGPointMake(0, 0))
                newTruckScheduleCity = textField.text
            
            default:
                print("did not match")
        }
    }
    
    private func determineTextFieldToFocus(textField: UITextField) {
        switch textField.tag {
            case TruckScheduleTextFieldTags.locationTag.rawValue:
                textField.becomeFirstResponder()
                
            case TruckScheduleTextFieldTags.addressTag.rawValue:
                textField.becomeFirstResponder()
                
            case TruckScheduleTextFieldTags.cityTag.rawValue:
                textField.becomeFirstResponder()
            setAutoScrollFocus(CGPointMake(0, -100))
            
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
    func presentSubmitAlert(title: String, message: String) {
        if let _: AnyClass = NSClassFromString("UIAlertController") { // iOS 8
            let myAlert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
            myAlert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(myAlert, animated: true, completion: nil)
        } else { // iOS 7
            let alert: UIAlertView = UIAlertView()
            alert.delegate = self
            
            alert.title = title
            alert.message = message
            alert.addButtonWithTitle("OK")
            
            alert.show()
        }
    }
    
    func onSubmit(sender:UIButton) {
        print("submitButton pressed")
        print("newTruckScheduleLocation: \(newTruckScheduleLocation)")
        print("TruckScheduleTextFieldTags \(newTruckScheduleAddress)")
        print("newTruckScheduleCity \(newTruckScheduleCity)")
        presentSubmitAlert("Truck Schedule Submitted", message:"Successfully!")
    }
    
    func startTimeSwitchToggled(sender: UISwitch){
        if (sender.on){
            self.uiView.hidden = false
        }
        else {
         self.uiView.hidden = true
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
