//
//  LoginViewController.swift
//  TruckFeed
//
//  Created by Jessica Le on 10/4/15.
//  Copyright (c) 2015 LoveLeJess. All rights reserved.
//

import UIKit

public class LoginViewController: UIViewController, UINavigationBarDelegate {

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        let navigationBar = createNavigationBar()
        let userNameTextField = createTextField("Username", frame: CGRectMake(20, 100, 300, 40))
        let passWordTextField = createTextField("Password", frame: CGRectMake(20, 150, 300, 40))
        passWordTextField.secureTextEntry = true

        let loginButton = createButton("Login", target: "", frame: CGRectMake(10, 200, 80, 50))
        let signUpButton = createButton("I'm a new foodie! Sign Me Up", target: "", frame: CGRectMake(10, 230, 250, 50))
        
        self.view.addSubview(userNameTextField)
        self.view.addSubview(passWordTextField)
        self.view.addSubview(navigationBar)
        self.view.addSubview(loginButton)
        self.view.addSubview(signUpButton)
    }
    
    func createNavigationBar() -> UINavigationBar {
        let navigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 54))
        navigationBar.delegate = self;
        let navigationItem = UINavigationItem()
        navigationItem.title = "User Login"
        navigationItem.leftBarButtonItem = createBarButtonItem()
        navigationBar.items = [navigationItem]

        return navigationBar
    }
    
    func createButton(title: String, target: Selector, frame: CGRect) -> UIButton {
        let button = UIButton(type: UIButtonType.System)
        button.setTitle(title, forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "Arial", size: 16)
        button.tintColor = secondaryColor
        button.addTarget(self, action: target, forControlEvents: UIControlEvents.TouchUpInside)
        button.frame = frame
        
        return button
    }
    
    func loginCancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    func createTextField(placeholderText: String, frame: CGRect ) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.placeholder = placeholderText
        textField.font = UIFont.systemFontOfSize(15)
        textField.borderStyle = UITextBorderStyle.RoundedRect
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.keyboardType = UIKeyboardType.Default
        textField.returnKeyType = UIReturnKeyType.Done
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing;
        textField.contentVerticalAlignment = UIControlContentVerticalAlignment.Center
        
        return textField
    }
    
    func createBarButtonItem() -> UIBarButtonItem {
        let barButtonItem: UIButton = UIButton(type:UIButtonType.Custom)
        barButtonItem.setTitle("Cancel", forState: UIControlState.Normal)
        barButtonItem.addTarget(self, action: "loginCancelButton:", forControlEvents: UIControlEvents.TouchUpInside)
        barButtonItem.frame = CGRectMake(0, 0, 60, 31)
        
        let barButton = UIBarButtonItem(customView: barButtonItem)
        barButton.tintColor = UIColor.darkGrayColor()
        
        return barButton
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
