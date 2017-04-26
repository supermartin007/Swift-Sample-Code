//
//  changePasswordViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 12/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class changePasswordViewController: UIViewController, UIAlertViewDelegate, UITextFieldDelegate {
    
    var oldPasswordText : UITextField = UITextField()
      var newPasswordText : UITextField = UITextField()
     var confPasswordText : UITextField = UITextField()
var  firstBlnkValue = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        
        var navView: UIView = UIView()
        //var nheight =  navigationController?.navigationBar.frame.height + 20
        navView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        navView.backgroundColor = UIColor(red: 0/255.0, green:135/255, blue: 206/255, alpha: 1.0)
        self.view.addSubview(navView)
        var navHeight = navView.frame.height
        var navMid = navHeight / 2 - 15
        
        /* Home Button*/
        
        var leftButton: UIButton = UIButton()
        leftButton.frame = CGRect(x: 16, y: 32, width: 20, height: 20)
        var img = UIImage(named: "back_errow")
        leftButton.setBackgroundImage(img, for: UIControlState())
        leftButton.addTarget(self, action: #selector(changePasswordViewController.homeClick(_:)), for: UIControlEvents.touchUpInside)
        navView.addSubview(leftButton)
        var titlepos = ScreenSize.width / 2 - 60
        
        /* Navigation Title*/
        
        var titleButton: UIButton = UIButton()
        titleButton.frame = CGRect(x: titlepos - 2, y: navMid + 10, width: 120, height: 30)
        titleButton.setTitle("Account", for: UIControlState())
        if (self.view.frame.height >= 667.0) {
            titleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14.5)
        } else {
            titleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        }
        
        titleButton.setTitleColor(UIColor.white, for: UIControlState())
        navView.addSubview(titleButton)
        
        var passwordTitleView: UIView = UIView()
        passwordTitleView.frame = CGRect(x: 0, y: navView.frame.maxY, width: ScreenSize.width, height: 30)
        passwordTitleView.backgroundColor = UIColor(red: 0 / 255, green:  105 / 255, blue:  159 / 255, alpha: 1)
        self.view.addSubview(passwordTitleView)
        
        var label:UILabel = UILabel()
        label.frame = CGRect(x: 20, y: 5, width: 200, height: 20)
        label.text = "Change Password"
        label.textColor = UIColor.white
        label.font = SMLGlobal.sharedInstance.fontSize(13)
        passwordTitleView.addSubview(label)
        
        var backView: UIView = UIView()
        backView.frame = CGRect(x: 0, y: passwordTitleView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - 94)
        backView.backgroundColor = UIColor.white
        self.view.addSubview(backView)
        var oldPasswordLabel : UILabel = UILabel()
        oldPasswordLabel.frame = CGRect(x: 30, y: 10, width: 100, height: 20)
        oldPasswordLabel.text = "Old Password"
        oldPasswordLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        oldPasswordLabel.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.8)
        
        backView.addSubview(oldPasswordLabel)
        
        
        oldPasswordText.frame = CGRect(x: 30, y: oldPasswordLabel.frame.maxY + 1, width: ScreenSize.width - 60, height: 25)
        //meetingTitleText.placeholder = " Lorem Ipsum"
        oldPasswordText.textColor = UIColor.black
       // oldPasswordText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        oldPasswordText.font = SMLGlobal.sharedInstance.fontSize(12)
        oldPasswordText.layer.borderWidth = 1
        oldPasswordText.isSecureTextEntry = true
        oldPasswordText.layer.cornerRadius = oldPasswordText.frame.width * 0.015
        oldPasswordText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        backView.addSubview(oldPasswordText)
        oldPasswordText.delegate = self
        
        var leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        oldPasswordText.leftView = leftView;
        oldPasswordText.leftViewMode = UITextFieldViewMode.always;
        var newPasswordLabel : UILabel = UILabel()
        newPasswordLabel.frame = CGRect(x: 30, y: oldPasswordText.frame.maxY + 10, width: 100, height: 20)
        newPasswordLabel.text = "New Password"
        newPasswordLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        newPasswordLabel.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.8)
        
        backView.addSubview(newPasswordLabel)
        
      
        newPasswordText.frame = CGRect(x: 30, y: newPasswordLabel.frame.maxY + 1, width: ScreenSize.width - 60, height: 25)
        //meetingTitleText.placeholder = " Lorem Ipsum"
        newPasswordText.textColor = UIColor.black
       // newPasswordText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        newPasswordText.font = SMLGlobal.sharedInstance.fontSize(12)
        newPasswordText.layer.borderWidth = 1
        newPasswordText.isSecureTextEntry = true
        newPasswordText.layer.cornerRadius = newPasswordText.frame.width * 0.015
        newPasswordText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        backView.addSubview(newPasswordText)
        newPasswordText.delegate = self
        var leftView1 = UIView()
        leftView1.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        newPasswordText.leftView = leftView1;
        newPasswordText.leftViewMode = UITextFieldViewMode.always;
        
        var confPasswordLabel : UILabel = UILabel()
        confPasswordLabel.frame = CGRect(x: 30, y: newPasswordText.frame.maxY + 10, width: 200, height: 20)
        confPasswordLabel.text = "Confirm Password"
        confPasswordLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        confPasswordLabel.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.8)
        
        backView.addSubview(confPasswordLabel)
        
       
        confPasswordText.frame = CGRect(x: 30, y: confPasswordLabel.frame.maxY + 1, width: ScreenSize.width - 60, height: 25)
        //meetingTitleText.placeholder = " Lorem Ipsum"
        //confPasswordText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        confPasswordText.font = SMLGlobal.sharedInstance.fontSize(12)
        confPasswordText.isSecureTextEntry = true
        confPasswordText.textColor = UIColor.black
        confPasswordText.layer.borderWidth = 1
        confPasswordText.layer.cornerRadius = confPasswordText.frame.width * 0.015
        confPasswordText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        backView.addSubview(confPasswordText)
        confPasswordText.delegate = self
        
        var leftView2 = UIView()
        leftView2.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        confPasswordText.leftView = leftView2;
        confPasswordText.leftViewMode = UITextFieldViewMode.always;
        
        var X : (CGFloat) = (ScreenSize.width - 210)/2
        
        var updateButton: UIButton = UIButton()
        updateButton.frame = CGRect(x: X, y: confPasswordText.frame.maxY + 20, width: 100, height: 35)
       // var img2 = UIImage(named: "upgrad_button")
        //updateButton.setBackgroundImage(img2, forState: .Normal)
        updateButton.backgroundColor = ButtonBlueColor
        updateButton.setTitle("Update", for: UIControlState())
        updateButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        updateButton.layer.cornerRadius = 2.0
        updateButton.addTarget(self, action: #selector(changePasswordViewController.updateAction(_:)), for: UIControlEvents.touchUpInside)
        backView.addSubview(updateButton)
        
        
        var cancleButton: UIButton = UIButton()
        cancleButton.frame = CGRect(x: updateButton.frame.maxX+10, y: confPasswordText.frame.maxY + 20, width: 100, height: 35)
        cancleButton.backgroundColor = ButtonRedColor
        cancleButton.setTitle("Cancel", for: UIControlState())
        cancleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        cancleButton.layer.cornerRadius = 2.0
        //var img1 = UIImage(named: "popupcancel")
       // cancleButton.setBackgroundImage(img1, forState: .Normal)
        cancleButton.addTarget(self, action: #selector(changePasswordViewController.cancleAction(_:)), for: UIControlEvents.touchUpInside)
        backView.addSubview(cancleButton)

    }
    func whiteSpaceCheck() ->Bool {
        var textField = UITextField()
        var val = 5
        
        var rawString = oldPasswordText.text! as NSString
        var vvv = ScreenSize.width
        
        var whitespace: CharacterSet = CharacterSet.whitespacesAndNewlines
        var trimmed: NSString = rawString.trimmingCharacters(in: whitespace) as NSString
        val = trimmed.length
//        print(trimmed)
//          var numberOfSpaces = oldPasswordText.text?.characters.count.compo
//            count(oldPasswordText.text.componentsSeparatedByString(" "))
//        var numberOfSpaces1 = count(newPasswordText.text.componentsSeparatedByString(" "))
//        var numberOfSpaces2 = count(confPasswordText.text.componentsSeparatedByString(" "))
        
//        print(numberOfSpaces)
        if firstBlnkValue == 1 {
            var alertView = UIAlertView (title: "", message: "Old Password is mandatory", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            oldPasswordText.text = ""
            return false;
            
        } else if firstBlnkValue == 2 {
            var alertView = UIAlertView (title: "", message: "New Password is mandatory", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            newPasswordText.text = ""
            return false;
            
        }  else if firstBlnkValue == 3 {
            var alertView = UIAlertView (title: "", message: "Confirm Password Text field is mandatory", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            newPasswordText.text = ""
            return false;
            
        } else {
            return true;
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if string == " " {
            if textField == oldPasswordText  {
            firstBlnkValue = 1
            } else if textField == newPasswordText {
                firstBlnkValue = 2
            }
            else if textField == confPasswordText {
                firstBlnkValue = 3
            }else {
                firstBlnkValue = 0
            }
        }
        return true
    }

//    func textFieldShouldEndEditing(textField: UITextField) -> Bool
//    {
    
//        if textField == newPasswordText    {
//            if newPasswordText.text == "" {
//                var alertView = UIAlertView(title: "", message: "Password field is mandatory", delegate: nil, cancelButtonTitle: "Ok")
//                //textPassword.becomeFirstResponder()
//                
//                alertView.show()
//            } else {
//                var cou = count(newPasswordText.text)
//                
//                if cou <= 4 {
//                    
//                    var alertView = UIAlertView(title: "", message: "The New Password field must be at least 5 characters", delegate: nil, cancelButtonTitle: "Ok")
//                    //textPassword.becomeFirstResponder()
//                    
//                    alertView.show()
//                }
//            }
//                    }else if textField == confPasswordText {
//            if newPasswordText.text == "" {
//                var alertView = UIAlertView(title: "", message: "Password field is mandatory", delegate: nil, cancelButtonTitle: "Ok")
//                //textPassword.becomeFirstResponder()
//                
//                alertView.show()
//            } else {
//                            var cou1 = count(confPasswordText.text)
//                          if cou1 <= 4 {
//                            var alertView = UIAlertView(title: "", message: "Re-Password field must be at least 5 characters", delegate: nil, cancelButtonTitle: "Ok")
//                       // textConfirmPassword.becomeFirstResponder()
//                            alertView.show()
//                        }
//            }
//                    }
//        
//        
//        return true
//        
//    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateAction(_ sender: UIButton) {
        
        
        let old = oldPasswordText.text! as NSString
        let newp = newPasswordText.text! as NSString
        let confp = confPasswordText.text! as NSString
        if whiteSpaceCheck() {
        if(CheckTextFields())
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
            SVProgressHUD.show(withStatus: "Loading..", maskType: SVProgressHUDMaskType.black)
           // var uid =
            //http://112.196.34.179/stepslocator/index.php/login/wschangepassword?user_id=&oldpassword=&password=&cpassword=
            let user : (SMLAppUser) = SMLAppUser.getUser()
            let loginID : (NSString) = user.userId;
            let parameters : (NSDictionary) = ["user_id" :loginID,
            "oldpassword": old,
            "password": newp,
            "cpassword": confp];
            
            WebserviceManager .sharedInstance.changePassword(params: parameters, withCompletionBlock: { (responseObject, error) in
                if responseObject != nil
                {
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                    if success == 0
                    {
                       SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                    }
                    else
                    {
                       SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                        self.oldPasswordText.text = ""
                        self.newPasswordText.text = ""
                        self.confPasswordText.text = ""
                      self.resignTextFields()
                    }
                     SVProgressHUD.dismiss()
                }
                else
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, (error?.localizedDescription)! as String as NSString, title: "")
                    SVProgressHUD.dismiss()
                }
            })
            }
            else
            {
                SMLGlobal.sharedInstance.NOINTERNETALERT(self)
            }
            
        }
        } else {
            firstBlnkValue = 0
        }
        
    }
    func resignTextFields()
    {
        self.oldPasswordText.resignFirstResponder()
        self.newPasswordText.resignFirstResponder()
        self.confPasswordText.resignFirstResponder()
    }
    
    func cancleAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    func homeClick(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var view = settingView(nibName: nil, bundle: nil)
        delegate.callMethod(view)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
     
        
        textField.resignFirstResponder()
        
        return true
    }
    
    func CheckTextFields() ->Bool
    {
        
        let isEqual = (newPasswordText.text == confPasswordText.text)
        //        now isEqual is true.
        if(oldPasswordText.text == "")
        {
            let alertView = UIAlertView (title: "", message: "Old Password is mandatory", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            return false;
        }
        else if(self.newPasswordText.text == "")
        {
            let alertView = UIAlertView (title: "", message: "New Password Text field is mandatory", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            
            //UIAlertView(title: "", message: "", delegate: nil, cancelButtonTitle: "OK").show()
            return false;
        }
        else if(self.confPasswordText.text == "")
        {
            let alertView = UIAlertView (title: "", message: "Confirm Password Text field is mandatory", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            
            //UIAlertView(title: "", message: "", delegate: nil, cancelButtonTitle: "OK").show()
            return false;
        }
               else if(!isEqual)
        {
            let alertView = UIAlertView (title: "", message: "Password and Confirm Password doesn't match", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            return false;
        }
            
            
            
            
        else
        {
            return true;
        }
        
        
        
        
        
    }
    

}
