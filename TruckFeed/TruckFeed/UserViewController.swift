//
//  UserViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/4/15.
//  Copyright (c) 2015 LoveLeJess. All rights reserved.
//

import UIKit
import FBSDKLoginKit

public class UserViewController: UIViewController, UINavigationBarDelegate, UITextFieldDelegate {

    private var truckOwner = TruckOwner.sharedInstance
    
    
    @IBOutlet weak var startTime: UIDatePicker!
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
        
        submit.addTarget(self, action: #selector(onSubmit), forControlEvents: UIControlEvents.TouchUpInside)
        
        location.delegate = self
        address.delegate = self
        city.delegate = self
        
        self.view.opaque = false
        self.view.tintColor = mainColor;
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
    
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    // MARK: UITextFieldDelegate
    
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        // Hide the keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    
    enum TruckScheduleTextFieldTags : Int {
        case locationTag = 0
        case addressTag = 1
        case cityTag = 2
    }

    
    public func textFieldDidEndEditing(textField: UITextField) {
        switch textField.tag {
            case TruckScheduleTextFieldTags.locationTag.rawValue:
                newTruckScheduleLocation = textField.text
                    
            case TruckScheduleTextFieldTags.addressTag.rawValue:
                newTruckScheduleAddress = textField.text

            case TruckScheduleTextFieldTags.cityTag.rawValue:
                newTruckScheduleCity = textField.text
            
            default:
                print("did not match")
        }
        
        
        
    }
    
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    func presentSubmitAlert(title: String, message: String) {
        if let getModernAlert: AnyClass = NSClassFromString("UIAlertController") { // iOS 8
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
        presentSubmitAlert("Successfully Submitted", message:"YAY")
        //        if let values = self.userView
        //        {
        //            if let startDate = values.startTime?.date
        //            {
        //                print("startDate: \(startDate)")
        //            }
        //            if let endDate = values.endTime?.date
        //            {
        //                print("endDate: \(endDate)")
        //            }
        //            if let location = values.location?.text
        //            {
        //                print("location: \(location)")
        //            }
        //            if let address = values.address?.text
        //            {
        //                print("address: \(address)")
        //            }
        //            if let city = values.city?.text
        //            {
        //                print("city: \(city)")
        //            }
        //        }
    }
}
