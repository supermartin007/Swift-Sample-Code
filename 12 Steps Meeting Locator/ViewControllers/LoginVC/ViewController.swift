
//
//  ViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iapp on 01/05/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//




let ScreenSize = UIScreen.main.bounds.size
let AppBackgroundImage = UIImage (named : "background")
let TextPlaceHolderColor = UIColor(red: 109.0/255.0, green: 109.0/255.0, blue: 109.0/255.0, alpha: 1.0)

import UIKit
var backgroundScrollView : UIScrollView!
var count1 = 0
var isForgotValue : Int!

class ViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate
{
    var passwordTextField : UITextField!
    var emailTextField : UITextField!
    var textVal = 0
    var textVal1 = 0
    var btnSignFB : UIButton!
    var transparentView : UIView!
    var forgotPasswordView = UIView()
    var resetPasswordTextField = UITextField()
    var isForgotPassView : Bool!
    var backgroundImageView = UIImageView()
    var textFieldVal = CGFloat(1)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        isForgotPassView = false
        isForgotValue = 0
        self.createUI()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyBoard), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.fore), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func viewWillAppear(_ animated: Bool)
    {
        self.emailTextField .resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- UI Methods
    func createUI()
    {
        //hide navigationBar
        self.navigationController?.isNavigationBarHidden = true
        
        //ScrollView
        backgroundScrollView = UIScrollView()
        backgroundScrollView.isScrollEnabled = true;
        backgroundScrollView.bounces = false
         backgroundScrollView.frame = CGRect(x: 0, y: -20, width: ScreenSize.width, height: ScreenSize.height - 20)
        self.view.addSubview(backgroundScrollView);
        self.view.backgroundColor = UIColor.clear
        
        //BackgroudImage
        backgroundScrollView.addSubview(backgroundImageView)
        
        //ImagePin
        let imageViewPin = UIImageView()
        imageViewPin.image = UIImage(named: "map")
        backgroundScrollView.addSubview(imageViewPin)
        
        //Label
        let lblLocator = UILabel()
        lblLocator.text = "Recovery Meeting Locator"
        lblLocator.font = SMLGlobal.sharedInstance.fontSize(15.0)
        lblLocator.textColor = UIColor.white
        lblLocator.textAlignment = NSTextAlignment.center
        backgroundScrollView.addSubview(lblLocator)
        
        //Email TextField
        emailTextField = UITextField()
        emailTextField.textColor = UIColor.black
        //emailTextField.placeholder = "E-mail Address"
        emailTextField.font = SMLGlobal.sharedInstance.fontSize(13)
        emailTextField.textAlignment = NSTextAlignment.left
        emailTextField.delegate = self
        let textFont :(UIFont) = SMLGlobal.sharedInstance.fontSize(13)
        let FirstPlaceholder = NSAttributedString(string: "E-mail Address", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : textFont])
        emailTextField.attributedPlaceholder = FirstPlaceholder;
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.returnKeyType = UIReturnKeyType.next
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        emailTextField.leftViewMode = UITextFieldViewMode.always;
        emailTextField.backgroundColor = UIColor.white;
        emailTextField.borderStyle = UITextBorderStyle.roundedRect;
        backgroundScrollView.addSubview(emailTextField)
        
        let emailLeftView = UIView()
        emailLeftView.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
      
        let emailImage = UIImageView()
        emailImage.frame = CGRect(x: 10, y: 11, width: 18, height: 18)
        emailImage.image = UIImage(named: "e-mail")
        emailLeftView.addSubview(emailImage)
        emailTextField.leftView = emailLeftView
        
        //Password TextField
        passwordTextField = UITextField()
        passwordTextField.placeholder = "********"
        passwordTextField.textAlignment = NSTextAlignment.left
        passwordTextField.delegate = self
        passwordTextField.font = SMLGlobal.sharedInstance.fontSize(13)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.leftViewMode = UITextFieldViewMode.always;
        passwordTextField.borderStyle = UITextBorderStyle.roundedRect;
        passwordTextField.backgroundColor = UIColor.white;
        backgroundScrollView.addSubview(passwordTextField)
        
        let passLeftView = UIView()
        passLeftView.frame = CGRect(x: 0, y: 0, width: 40, height: 40);
        passwordTextField.leftView = passLeftView
        
        let passImage = UIImageView()
        passImage.frame = CGRect(x: 10, y: 10, width: 18, height: 18)
        passImage.image = UIImage(named: "password")
        passLeftView.addSubview(passImage)
        
        let forgotPasswordBtn : UIButton = UIButton.init(type: UIButtonType.custom)
        //var image = UIImage(named: "signin")
        //let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
//        var attribStr = NSMutableAttributedString(string: "Forgot Password?", attributes: [NSForegroundColorAttributeName : UIColor.blackColor(), NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(10)], NSUnderlineStyleAttributeName : NSUnderlineStyle.StyleSingle.rawValue)
        
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
        let underlineAttributedString = NSAttributedString(string: "Forgot Password?", attributes: underlineAttribute)
        // let underlineAttributedString = NSAttributedString(string: "REGISTER", attributes: underlineAttribute)
        forgotPasswordBtn.setTitle("ForgotPassword?", for: UIControlState())
        forgotPasswordBtn.setTitleColor(UIColor.black, for: UIControlState())
        forgotPasswordBtn.setAttributedTitle(underlineAttributedString, for: UIControlState())
        forgotPasswordBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(10)
        forgotPasswordBtn.titleLabel?.textAlignment = NSTextAlignment.right
        forgotPasswordBtn.addTarget(self, action: #selector(ViewController.FPassAction(_:)), for: UIControlEvents.touchUpInside)
        backgroundScrollView.addSubview(forgotPasswordBtn)
         //SignIn
        let btnSignIn : UIButton = UIButton.init(type: UIButtonType.custom)
        var image = UIImage(named: "signin")
        btnSignIn.setImage(image, for: UIControlState())
        btnSignIn.addTarget(self, action: #selector(ViewController.SignInAction(_:)), for: UIControlEvents.touchUpInside)
        backgroundScrollView.addSubview(btnSignIn)
        
       
        //SignIn with Fb
        btnSignFB = UIButton.init(type: UIButtonType.custom)
        image = UIImage(named: "singn in with facebook button")
        btnSignFB .setImage(image, for: UIControlState())
        btnSignFB.addTarget(self, action: #selector(ViewController.FBSignInAction(_:)), for: UIControlEvents.touchUpInside)
        backgroundScrollView.addSubview(btnSignFB)
        
        //SignUP
        let btnSignUp : UIButton = UIButton.init(type: UIButtonType.custom)
        //btnSignUp.setTitle("Sign up", forState: UIControlState.Normal)
        //btnSignUp.titleLabel!.font =  SMLGlobal.sharedInstance.fontSize(15)
        //btnSignUp.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        btnSignUp.setImage(UIImage(named: "signup"), for: UIControlState())
        //btnSignUp.layer.cornerRadius = 15.0
       // btnSignUp.clipsToBounds=true
        btnSignUp.addTarget(self, action: #selector(ViewController.SignUpAction(_:)), for: UIControlEvents.touchUpInside)
        backgroundScrollView.addSubview(btnSignUp)
        
        
        backgroundScrollView.frame = CGRect(x: 0, y: -20, width: ScreenSize.width, height: ScreenSize.height + 20 )
            
        backgroundImageView.image = AppBackgroundImage
            
        backgroundImageView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height);
            
        imageViewPin.frame = CGRect(x: (ScreenSize.width - 120)/2, y: 40 , width: 120, height: 120)
            
        lblLocator.frame = CGRect(x: 0, y: imageViewPin.frame.maxY+10,width: ScreenSize.width, height: 30)
            
        emailTextField.frame = CGRect(x: 50, y: lblLocator.frame.maxY+50, width: ScreenSize.width-100 , height: 40)
            
        passwordTextField.frame = CGRect(x: 50, y: emailTextField.frame.maxY+10, width: ScreenSize.width-100, height: 40)
            
        forgotPasswordBtn.frame = CGRect(x: emailTextField.frame.maxX - 95 , y: passwordTextField.frame.maxY+10, width: 100, height: 20)
            
        btnSignIn.frame = CGRect(x: 50, y: forgotPasswordBtn.frame.maxY+10, width: ScreenSize.width-100, height: 41)
            
            
        let  btnSizeWidth:CGFloat = (ScreenSize.width-110)/2
        if ScreenSize.height >= 667 {
            btnSignFB.frame = CGRect(x: 50,y: btnSignIn.frame.maxY+20, width: btnSizeWidth, height: 41)
                
                
            btnSignUp.frame = CGRect(x: emailTextField.frame.maxX - btnSizeWidth, y: btnSignIn.frame.maxY+20, width: btnSizeWidth, height: 41)
                
        } else {
            
        btnSignFB.frame = CGRect(x: 50,y: btnSignIn.frame.maxY+10, width: btnSizeWidth, height: 41)
         
            
        btnSignUp.frame = CGRect(x: emailTextField.frame.maxX - btnSizeWidth, y: btnSignIn.frame.maxY+10, width: btnSizeWidth, height: 41)
            }
        
       
        
        let gesture = UITapGestureRecognizer.init(target: self, action:#selector(ViewController.bgScrollViewGesture))
        backgroundScrollView .addGestureRecognizer(gesture)
        }
    
    
    func bgScrollViewGesture()
    {
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.resetPasswordTextField.resignFirstResponder()
    }
        
//        //backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.contentOffset.x, CGRectGetMaxY(btnSignUp.frame)+5)
//        
//        
//        if ScreenSize.height == 480 {
//            backgroundImageView.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height + 20);
//            backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.contentOffset.x, CGRectGetMaxY(btnSignUp.frame)+15)
//        }
//      
        
        //        if(UIScreen.mainScreen().bounds.width == 375)
        //        {
        //            btnSignTwitter.frame = CGRectMake(193, ScreenSize.height-110, 106, 38)
        //        }
        //        if(UIScreen.mainScreen().bounds.width == 414)
        //        {
        //            btnSignTwitter.frame = CGRectMake(212, ScreenSize.height-110, 106, 38)
        //        }
    
    //MARK:- Action Methods
    func FPassAction(_ sender: UIButton)
    {
        isForgotValue = 1
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        transparentView = UIView()
        transparentView.frame = self.view.bounds
        self.view.addSubview(transparentView)
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.removeTransparentView(_:)))
        transparentView .addGestureRecognizer(tapgesture)
        
        forgotPasswordView = UIView()
        forgotPasswordView.backgroundColor = UIColor.white
        forgotPasswordView.layer.cornerRadius = 4.0
        if(ScreenSize.height == 480)
        {
        forgotPasswordView.frame = CGRect(x: 30,y: (ScreenSize.height - 150)/2, width: ScreenSize.width - 60, height: 180)
        }
        else
        {
         forgotPasswordView.frame = CGRect(x: 30,y: (ScreenSize.height - 180)/2, width: ScreenSize.width - 60, height: 180)
        }
        self.view.addSubview(forgotPasswordView)
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 10, y: 7, width: forgotPasswordView.frame.size.width - 20, height: 20)
        titleLabel.text = "Forgot password?"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.font = SMLGlobal.sharedInstance.fontSizeBold(15)
        titleLabel.textColor = UIColor.black
        forgotPasswordView.addSubview(titleLabel)
        
        let detailLabel = UILabel()
        detailLabel.frame = CGRect(x: 20, y: titleLabel.frame.maxY + 5, width: forgotPasswordView.frame.size.width - 40, height: 40)
        detailLabel.numberOfLines = 0
        titleLabel.textAlignment = NSTextAlignment.center
        detailLabel.text = "Enter your registered e-mail address,to \nreset your password."
        if(ScreenSize.height == 667)
        {
          detailLabel.font = SMLGlobal.sharedInstance.fontSizeBold(12)
        }
        else
        {
         detailLabel.font = SMLGlobal.sharedInstance.fontSizeBold(11)
        }
        forgotPasswordView.addSubview(detailLabel)
        
        resetPasswordTextField = UITextField()
        resetPasswordTextField.frame = CGRect(x: 20, y: detailLabel.frame.maxY+10, width: forgotPasswordView.frame.size.width - 40, height: 30)
        resetPasswordTextField.delegate = self
        resetPasswordTextField.borderStyle = UITextBorderStyle.roundedRect
        //        resetPasswordTextField.layer.borderColor = UIColor.lightGrayColor().CGColor
        //        resetPasswordTextField.layer.borderWidth = 1.0
        
        let placehoder = NSAttributedString(string: "E-mail Address", attributes:[NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(12),NSForegroundColorAttributeName : TextPlaceHolderColor])
        resetPasswordTextField.attributedPlaceholder = placehoder
        resetPasswordTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        resetPasswordTextField.placeholder = "E-mail Address"
        forgotPasswordView.addSubview(resetPasswordTextField)
        resetPasswordTextField.leftViewMode = UITextFieldViewMode.always
        
        let emailLeftView = UIImageView()
        emailLeftView.image = UIImage(named: "email_icon")
        emailLeftView.frame = CGRect(x: 0, y: 0, width: 40, height: 35)
        resetPasswordTextField.leftView = emailLeftView
        
        //0.90,171
        let frame : CGFloat = (resetPasswordTextField.frame.size.width - 40)/2
        
        let sendButton: UIButton = UIButton.init(type: UIButtonType.custom)
        sendButton.frame = CGRect(x: resetPasswordTextField.frame.origin.x+20, y: resetPasswordTextField.frame.maxY+20, width: frame, height: 30)
        sendButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
        sendButton.backgroundColor = UIColor(red: 0.0/255.0, green: 90.0/255.0, blue: 171.0/255.0, alpha: 1.0)
        sendButton.setTitle("Send", for: UIControlState())
        sendButton.setTitleColor(UIColor.white, for: UIControlState())
        sendButton.layer.cornerRadius = 2.0
        //sendButton.setImage(UIImage(named: "popupsend_button"), forState:  .Normal)
        sendButton.addTarget(self, action: #selector(ViewController.ForgotPassSend(_:)), for: UIControlEvents.touchUpInside)
        forgotPasswordView.addSubview(sendButton)
        
        let cancelButton: UIButton = UIButton.init(type: UIButtonType.custom)
        cancelButton.frame = CGRect(x: sendButton.frame.maxX+10, y: resetPasswordTextField.frame.maxY+20, width: frame, height: 30)
        cancelButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
        cancelButton.backgroundColor = UIColor(red: 254.0/255.0, green: 74.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        cancelButton.setTitle("Cancel", for: UIControlState())
        cancelButton.setTitleColor(UIColor.white, for: UIControlState())
        cancelButton.layer.cornerRadius = 2.0
        cancelButton.addTarget(self, action: #selector(ViewController.cancelBtnAction(_:)), for: UIControlEvents.touchUpInside)
        //cancelButton.setImage(UIImage(named: "popupcancel"), forState:  .Normal)
        forgotPasswordView.addSubview(cancelButton)
    }
    //removeTransparentView
    func removeTransparentView(_ sender:UIGestureRecognizer)
    {
        //forgotPasswordView.frame = CGRectMake(20,230, ScreenSize.width-40, 200)
        isForgotValue = 0
        forgotPasswordView.removeFromSuperview()
        transparentView.removeFromSuperview()
    }
    func ForgotPassSend(_ sender: UIButton)
    {
       // forgotPasswordView.frame = CGRectMake(20,230, ScreenSize.width-40, 200)
        resetPasswordTextField.resignFirstResponder()
        //http://112.196.34.179/stepslocator/index.php/login/wsforgotpassword?&email=
        let parameters : (NSDictionary) = ["email" : resetPasswordTextField.text! as NSString]
        reset()
        if(self.checkResetPasswordField())
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
                SVProgressHUD.show(withStatus: "Loading..", maskType: SVProgressHUDMaskType.black)
            WebserviceManager.sharedInstance.forgotPasswordWebservice(params: parameters, withCompletionBlock: { (responseObject, error) in
               
                if responseObject != nil
                {
                let dict :(NSDictionary) = responseObject as! NSDictionary
                let string : (NSString) = dict.value(forKey: "message") as! NSString
                //Success 1
                
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if(success == 1)
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, string as NSString, title: "")
                    // var userValues : NSDictionary = dict.valueForKey("data") as! NSDictionary
                    self.forgotPasswordView.removeFromSuperview()
                    self.transparentView.removeFromSuperview()
                    isForgotValue = 0
                }
                else
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, string as NSString, title: "")
                    //backgroundScrollView.contentOffset = CGPointZero
                }
                }
                else
                {
                    let string : (NSString) = error!.localizedDescription as NSString
                    SMLGlobal.sharedInstance.displayAlertMessage(self, string as NSString, title: "")
                }
                SVProgressHUD.dismiss()
            })
            }
            else
            {
                SMLGlobal.sharedInstance.NOINTERNETALERT(self)
            }
        }
      }
    
    func checkResetPasswordField() -> Bool
    {
        if(resetPasswordTextField.text == "")
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Please enter email", title: "")
            return false
        }
        else
        {
            if(!self.isValidEmail(resetPasswordTextField.text!))
            {
                print(textVal1)
                if textVal1 == 1 {
                    SMLGlobal.sharedInstance.displayAlertMessage(self,"Please enter email", title: "")

                    resetPasswordTextField.text = ""
                    return false
                }
                SMLGlobal.sharedInstance.displayAlertMessage(self,"Email not valid", title: "")
                return false
            }
            else
            {
                return true
            }
        }
    }
    
    func cancelBtnAction(_ sender: UIButton)
    {
//        if(isForgotPassView == true)
//        {
//            
////            var passFrame : (CGRect) = forgotPasswordView.frame
////            passFrame.origin.y = passFrame.origin.y + 150
////            forgotPasswordView.frame = passFrame
//            isForgotPassView = false
//            
//        }
         isForgotValue = 0
        forgotPasswordView.removeFromSuperview()
        transparentView.removeFromSuperview()
    }
    
    func SignInAction(_ sender: UIButton)
    {
        self.emailTextField .resignFirstResponder()
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.isEnabled = true
        self.passwordTextField.isEnabled = false
        if count1 == 0 {
        //self.btnSignFB.enabled = true
            self.passwordTextField.isEnabled = false
            self.emailTextField.isEnabled = false
            self.btnSignFB.isEnabled = false
            count1 += 1
            
        }
        if count1 == 1 {
            //self.passwordTextField.enabled = false
            self.passwordTextField.isEnabled = true
            self.emailTextField.isEnabled = true
            self.btnSignFB.isEnabled = true
        }
        val()
        if(CheckTextFields())
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
           
           // http://112.196.34.179/stepslocator/index.php/login/wslogin?email=&password=
//            let parameters : (NSDictionary) = ["email" : "roop@gmail.com",
//                                               "password" : "roop123"]
            let parameters : (NSDictionary) = ["email" : emailTextField.text! as NSString,
              "password" : passwordTextField.text! as NSString,
                ]
            //SVProgressHUD.showWithStatus("Please Wait...")
             SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
            WebserviceManager .sharedInstance.getLoginWebservice(params: parameters, withCompletionBlock: { (responseObject, error) in
                
                let dict :(NSDictionary) = responseObject as! NSDictionary
                let string : (NSString) = dict.value(forKey: "message") as! NSString
                if responseObject != nil{
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    
                    
                    if(success == 1)
                    {
                        let userValues : NSDictionary = dict.value(forKey: "data") as! NSDictionary
                        
                        let appUser = SMLAppUser()
                        appUser.userId = userValues.object(forKey: "login_id") as! NSString
                        //appUser.userId = NSString(format: "%d", userValues.objectForKey("login_id") as! Int)
                        appUser.firstName = userValues.object(forKey: "firstname") as! NSString
                        appUser.lastName = userValues.object(forKey: "lastname") as! NSString
                        appUser.userName = userValues.object(forKey: "username") as! NSString
                        appUser.probationName = userValues.object(forKey: "probation_name") as! NSString
                        appUser.probationEmail = userValues.object(forKey: "probation_email") as! NSString
                        appUser.dob = userValues.object(forKey: "dob") as! NSString
                        appUser.email = userValues.object(forKey: "email") as! NSString
                        var profileStr : (NSString) = userValues.value(forKey: "profile_pic") as! NSString
                        if profileStr != ""
                        {
                            profileStr =  profileImagesUrl.appending(profileStr as String) as (NSString)
                        }
                        appUser.profilePic = profileStr
                        appUser.upgrade  = userValues.object(forKey: "user_payment_type") as! NSString
                        appUser.pushNotification = userValues.object(forKey: "pushStatus") as! NSString
                        appUser.emailNotification = userValues.object(forKey: "emailStatus") as! NSString
                        
                        
                        //1 usertype for normal login
                        appUser.userType =  userValues.object(forKey: "usertype") as! NSString
                        SMLAppUser.saveUser(appUser)
                        
                        if(appUser.pushNotification .isEqual(to: "1"))
                        {
                            let delegateObj : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
                            if( UserDefaults.standard.object(forKey: "DeviceToken") != nil)
                            {
                                let deviceToken : (NSString) = UserDefaults.standard.object(forKey: "DeviceToken") as! NSString
                                delegateObj.getDeviceToken(deviceToken, loginId: appUser.userId)
                                delegateObj.sendCurrentLocation()
                            }
                        }
                        self.navigateToHomeView()
                        SVProgressHUD.dismiss()
                    }
                    else
                    {
                        SMLGlobal.sharedInstance.displayAlertMessage(self, string as NSString, title: "")
                        SVProgressHUD.dismiss()
                    }
                }
                else
                {
                    let string : (NSString) = error!.localizedDescription as NSString
                    SMLGlobal.sharedInstance.displayAlertMessage(self, string as NSString, title: "")
                    SVProgressHUD.dismiss()
                }
            })
            }
            else
            {
                SMLGlobal.sharedInstance.NOINTERNETALERT(self)
            }
        }
        else
        {
            
        }
    }
    
    
    func SignUpAction(_ sender: UIButton)
    {
        self.emailTextField .resignFirstResponder()
        self.passwordTextField.resignFirstResponder()

        let SMLRegisterView : SMLRegisterViewController = SMLRegisterViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(SMLRegisterView, animated: true)
    }
    
    func TwitterSignInAction(_ sender : UIButton)
    {
        NSLog("TwitterSign")
    }
    func getFBUserData()
    {
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email,birthday,gender,location"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil)
                {
                    let dict  : (NSDictionary) = result as! NSDictionary
                    self.fbWebservice(dict)
                   
                }
                else
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, "Facebook not connect", title: "")
                    SVProgressHUD.dismiss()
                }
            })
        }
        else
        {
            SVProgressHUD.dismiss()
        }
    }
    
    
    func fbWebservice(_ fbDict :NSDictionary)
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
       // http://112.196.34.179/stepslocator/index.php/login/signupwithfb?firstname=&lastname=&email=&password=&username=&city=&gender=&dob=&usertype=
        let firstName : (NSString) = fbDict.object(forKey: "first_name") as! NSString
        let lastName : (NSString) = fbDict.object(forKey: "last_name") as! NSString
        let email : (NSString) = fbDict.object(forKey: "email") as! NSString
        let firstChar : (NSString) = firstName.substring(with: NSMakeRange(0, 1)) as (NSString)
        let username : (NSString) = NSString(format: "%@.%@", firstChar,lastName)
        let gender : (NSString) = fbDict.object(forKey: "gender") as! NSString
         var dob : (NSString)!
            print(fbDict)
        if fbDict.object(forKey: "birthday") as? NSString != nil
        {
             dob  = fbDict.object(forKey: "birthday") as! (NSString)
        }
        else
        {
            dob = "01/01/1950"
        }
            
        //var dob : (NSString) = fbDict.object(forKey: "birthday") as! (NSString)
//        if fbDict.object(forKey: "birthday") != nil
//        {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd"
//            let date : (Date) = dateFormatter.date(from: dob as String)!
//            dob = dateFormatter.string(from: date as Date) as (NSString)
//        }
//        else
//        {
//            dob = ""
//        }
        
        
//        
//        var location : (NSString) = fbDict.objectForKey("location")?.objectForKey("name") as! NSString
//        var cityArray  : (NSArray) = location.componentsSeparatedByString(",")
//        var user_location : (NSString) = NSString()
//        if(cityArray.count>0)
//        {
//            user_location  = cityArray.objectAtIndex(0) as! (NSString)
//        }
//        else
//        {
//            user_location = ""
//        }

        let DF : (DateFormatter) = DateFormatter()
        DF.dateFormat = "dd/MM/yyyy"
        let user_date : (Date) = DF.date(from: dob as String)! as (Date)
        DF.dateFormat = "yyyy-MM-dd"
        let user_FbDate : (NSString) = DF.string(from: user_date) as (NSString)
        SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        let parameters : (NSDictionary) = ["firstname" : firstName,
            "lastname" : lastName,
            "email" : email,
            "password" : "",
            "username" : username,
            "probation_name" : "",
            "probation_email" : "",
            "dob" : user_FbDate,
            "usertype" : "2"]
        
            
            

            
            
            
           WebserviceManager.sharedInstance.signUpWithFb(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
            let dict :(NSDictionary) = responseObject as! NSDictionary
            let string : (NSString) = dict.value(forKey: "message") as! NSString
            //Success 1
            
            let success : NSInteger  = (responseObject!.value(forKey: "success") as? NSInteger)!
            if(success == 1)
            {
//                var loginValues : NSArray = dict.value(forKey: "data") as! NSArray
//                 if loginValues == 0 {
//                 println("Value Error")
//                 } else {
                
                let loginValues : (NSArray) = dict.value(forKey: "data") as! NSArray
                let userValues : (NSDictionary) = loginValues.object(at: 0) as! NSDictionary

               // let userValues : (NSDictionary) = dict.value(forKey: "data") as! NSDictionary
                // var userValues : NSDictionary = dict.valueForKey("data") as! NSDictionary
//                let alertView = UIAlertView (title: "", message:string as String, delegate: self, cancelButtonTitle: "OK")
//                alertView.show();
                // println(userValues)
                
                
                
                //                var dob : (NSString) = userValues.objectForKey("dob") as! NSString
                //                var df : (NSDateFormatter) = NSDateFormatter()
                //                df.dateFormat = "yyyy-MM-dd"
                //                var dobDate : (NSDate) = df .dateFromString(dob as String)!
                //                df.dateFormat = "dd-MMM-yyyy"
                //                var dobStr : (NSString) = df.stringFromDate(dobDate)
                
                let appUser = SMLAppUser()
                appUser.userId = userValues.value(forKey: "login_id_fk") as! NSString
                appUser.firstName = userValues.value(forKey: "firstname") as! NSString
                appUser.lastName = userValues.value(forKey: "lastname") as! NSString
                appUser.userName = userValues.value(forKey: "username") as! NSString
                appUser.probationName = userValues.value(forKey: "probation_name") as! NSString
                appUser.probationEmail = userValues.value(forKey: "probation_email") as! NSString
                appUser.dob = userValues.value(forKey: "dob") as! NSString
                appUser.email = userValues.value(forKey: "email") as! NSString
                //var profileStr : (NSString) = NSString()
                
                var profileStr : (NSString) = userValues.value(forKey: "profile_pic") as! NSString
                if(profileStr == "")
                {
                    let userType : (NSString) = userValues.value(forKey: "usertype") as! NSString
                    if(userType == "2")
                    {
                        print(fbDict)
                        let pic : (NSDictionary) = fbDict.object(forKey: "picture") as! NSDictionary
                        let data1 : (NSDictionary) = pic.object(forKey: "data") as! NSDictionary
                        let pp = data1.object(forKey: "url") as! NSString
                        print(pp)
//                        let fb_profilePic : (NSString) = ((fbDict.object(forKey: "picture") as AnyObject).object(forKey: "data") as AnyObject).object(forKey: "url") as! NSString
                        profileStr = pp
                    }
                    else
                    {
                        
                    }
                }
                else
                {
                    profileStr =  profileImagesUrl.appending(profileStr as String) as (NSString)
                }
                appUser.profilePic = profileStr
                if((userValues.value(forKey: "user_payment_type")) != nil)
                {
                    appUser.upgrade  = userValues.value(forKey: "user_payment_type") as! NSString
                }
                else
                {
                    appUser.upgrade = "0"
                }
                if(userValues.value(forKey: "push_status") != nil)
                {
                    appUser.pushNotification = userValues.value(forKey: "push_status") as! NSString
                }
                else
                {
                    appUser.pushNotification = "0"
                }
                
                if(userValues.value(forKey: "email_status") != nil )
                {
                    appUser.emailNotification = userValues.value(forKey: "email_status") as! NSString
                }
                else
                {
                    appUser.emailNotification = "0"
                }
                
                //1 usertype for normal login
                appUser.userType =  userValues.value(forKey: "usertype") as! NSString
                SMLAppUser.saveUser(appUser)
                
                if(appUser.pushNotification .isEqual(to: "1"))
                {
                    let delegateObj : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
                    if( UserDefaults.standard.object(forKey: "DeviceToken") != nil)
                    {
                        let deviceToken : (NSString) = UserDefaults.standard.object(forKey: "DeviceToken") as! NSString
                        delegateObj.getDeviceToken(deviceToken, loginId: appUser.userId)
                        delegateObj.sendCurrentLocation()
                    }
                }
                self.navigateToHomeView()
                SVProgressHUD.dismiss()
            }
            else
            {
                SMLGlobal.sharedInstance.displayAlertMessage(self, string as NSString, title: "")
                SVProgressHUD.dismiss()
            }
            }
            else
            {
                let string : (NSString) = error!.localizedDescription as NSString
                SMLGlobal.sharedInstance.displayAlertMessage(self, string as NSString, title: "")
                SVProgressHUD.dismiss()
            }
        }
        }
        else
        {
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }
   
    func FBSignInAction(_ sender : UIButton)
    {
         SVProgressHUD.show(withStatus: "Loading...", maskType: SVProgressHUDMaskType.black)
        if((FBSDKAccessToken .current()) != nil)
        {
            // println("existing")
        }
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager .logIn(withReadPermissions: ["email", "public_profile","user_birthday","user_location"], handler: { (handlerObject, error) -> Void in
      
            if (error == nil)
            {
                self.getFBUserData()
            }
            else
            {
                SMLGlobal.sharedInstance.displayAlertMessage(self, (error?.localizedDescription)! as String as NSString, title: "")
                SVProgressHUD.dismiss()
            }
        })
    }
    func CheckTextFields() ->Bool
    {
       if(self.emailTextField.text == "")
       {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Email field is mandatory", title: "")
            return false;
       }
       else if(!isValidEmail(emailTextField.text!))
       {
        if textVal == 1
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Email field is mandatory", title: "")
            emailTextField.text = ""
            return false;
        }
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Email is not valid", title: "")
            return false;
       }
       else if(self.passwordTextField.text == "")
       {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Password field is mandatory", title: "")
            return false;
       }
       else
       {
            return true;
       }
    }
    
    func navigateToHomeView()
    {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
        let SMLRegisterView : FirstViewController = FirstViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(SMLRegisterView, animated: true)
    }
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
       // println(String(format: "%@", emailTest.evaluateWithObject(testStr)))
        return emailTest.evaluate(with: testStr)
    }
    
    
    //MARK:-TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField == emailTextField
        {
            self.passwordTextField .becomeFirstResponder()
        }
        else if textField == passwordTextField
        {
            self.passwordTextField.resignFirstResponder()
        }
        if ScreenSize.height >= 667
        {
            resetPasswordTextField.resignFirstResponder()
        }
        else
        {
        if (self.resetPasswordTextField.resignFirstResponder())
        {
            isForgotValue = 0
        }
        else
        {
        if(isForgotValue == 2)
        {
            var passFrame : (CGRect) = forgotPasswordView.frame
            passFrame.origin.y = passFrame.origin.y + 150
            forgotPasswordView.frame = passFrame
            isForgotValue = 1
        }
        if ScreenSize.height == 480
        {
        if textFieldVal == 2
        {
        if textField == passwordTextField || textField == emailTextField
        {
//            backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height - 50  )
            textFieldVal = 1
        }
        }
        }
        }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        if ScreenSize.height >= 667
        {
        
        }
        else
        {
        if textField == resetPasswordTextField
        {
            isForgotValue = 0
        } else
        {
              if ScreenSize.height == 480
              {
        if  textFieldVal == 1
        {
        if textField == passwordTextField || textField == emailTextField
        {
//             backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height + 50)
            textFieldVal = 2
        }
        }
        }
        }
        if(isForgotValue == 1)
        {
            var passFrame : (CGRect) = forgotPasswordView.frame
            passFrame.origin.y = passFrame.origin.y - 150
            forgotPasswordView.frame = passFrame
            isForgotValue = 2
        }
        else
        {
         animateViewMoving(true, moveValue: 150)
        }
        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
//        var str = textField.text as NSString
//        var d = 32 as unichar
//        if (textField == emailTextField) {
//            var c:unichar = str.characterAtIndex(0);
//            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
//            if c == d {
//                textVal = 1
//                return true;
//            } else {
//                textVal = 0
//                
//            }
//        }
        if ScreenSize.height >= 667
        {
            
        }
        else {
       // println(isForgotValue)
        NSLog("%@",NSStringFromCGPoint(backgroundScrollView.contentOffset))
        if(isForgotValue == 2)
        {
            var passFrame : (CGRect) = forgotPasswordView.frame
            passFrame.origin.y = passFrame.origin.y + 150
            forgotPasswordView.frame = passFrame
            isForgotValue = 1
        }
        else
        {
        animateViewMoving(false, moveValue: 150)
        }
        }
        return true
    }
    
    func resignAllTextFields()
    {
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        self.resetPasswordTextField.resignFirstResponder()
    }
    
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool
//    {
//        let newLength = count(textField.text) + count(string) - range.length
//    
//        
//        var fullString = textField.text.stringByAppendingString(string) as NSString
//        var length = fullString.length as Int
//        
//        NSLog("%@", fullString)
//        
//        if(string == "")
//        {
//            length = length-1;
//        }
//        NSLog("%d", length)
//        return newLength <= 20
//        
//    }

    func  touchesBegan(_ touches: Set<NSObject>, with event: UIEvent)
    {
        view.endEditing(true)
        super.touchesBegan(touches as! Set<UITouch>, with: event)
    }
    func animateViewMoving (_ up:Bool, moveValue :CGFloat)
    {
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        UIView.beginAnimations( "animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration )
        self.view.frame = self.view.frame.offsetBy(dx: 0,  dy: movement)
        UIView.commitAnimations()
    }
    func keyBoard()
    {
          //self.createUI()
        isForgotValue = 2
        if ScreenSize.height == 480
        {
        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height - 30)
        }
        //backgroundScrollView.contentOffset = CGPointMake(0, 0)
    }
    
    func fore()
    {
        self.passwordTextField.resignFirstResponder()
        self.emailTextField.resignFirstResponder()
        if ( self.resetPasswordTextField.resignFirstResponder()) {
            isForgotValue = 0
        } else
        {
            if(isForgotValue == 2)
            {
                var passFrame : (CGRect) = forgotPasswordView.frame
                passFrame.origin.y = passFrame.origin.y + 150
                forgotPasswordView.frame = passFrame
                isForgotValue = 1
            }
            if ScreenSize.height == 480
            {
                if textFieldVal == 2
                {
                        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height - 50)
                        textFieldVal = 1
                }
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true;
    }

    func val()
    {
        let str = emailTextField.text! as NSString
        //_ = resetPasswordTextField.text! as NSString
        let d = 32 as unichar
        if (emailTextField.text?.characters.count)! >= 2
        {
                if str == ""
                {
                    textVal = 0
                }
                else
                {
                   // var value = str.substring(with: NSRange(location: 0, length: 1))
                    let c:unichar = str.character(at: 0);
                    //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                    if c == d {
                        textVal = 1
                        
                    } else {
                         textVal = 0
                    }
                }
        }
        if emailTextField.text?.characters.count == 1
        {
                let c:unichar = str.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d
                {
                    textVal = 1
                } else {
                    textVal = 0
                }
            }
        }
    
    func reset()
    {
        let str1 = resetPasswordTextField.text! as NSString
        let d = 32 as unichar
        if (resetPasswordTextField.text?.characters.count)! >= 2 {
            if str1 == "" {
                textVal1 = 0
            } else {
                _ = str1.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str1.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    textVal1 = 1
                    
                } else {
                    textVal1 = 0
                }
        }
        }
        
        if resetPasswordTextField.text?.characters.count == 1 {
            let c:unichar = str1.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                textVal1 = 1
                
            } else {
                textVal1 = 0
            }
        }
    }
    //MARK: Keyboard Delegate Methods
    func keyboardWillShow()
    {
        if ScreenSize.height >= 667
        {
            backgroundScrollView.contentSize = CGSize.init(width: backgroundScrollView.frame.size.width, height: backgroundScrollView.frame.size.height + 50)
        }
        else
        {
            backgroundScrollView.contentSize = CGSize.init(width: backgroundScrollView.frame.size.width, height: backgroundScrollView.contentSize.height + 100)
        }
    }
    func keyboardWillHide()
    {
        if ScreenSize.height >= 667
        {
            backgroundScrollView.contentSize = CGSize.init(width: backgroundScrollView.frame.size.width, height: backgroundScrollView.frame.size.height - 50)
        }
        else
        {
            backgroundScrollView.contentSize = CGSize.init(width: backgroundScrollView.frame.size.width, height: backgroundScrollView.contentSize.height - 100)
        }
    }
}





