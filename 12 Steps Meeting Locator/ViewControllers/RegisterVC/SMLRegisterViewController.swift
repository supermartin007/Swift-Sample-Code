
//
//  SMLRegisterViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iapp on 01/05/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import StoreKit


class SMLRegisterViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource,UITableViewDelegate,inAppProductsDelegate, SKPaymentTransactionObserver , SKProductsRequestDelegate,UIGestureRecognizerDelegate
{
    var isKeyboardShow : Bool = false
    var textFirstName : UITextField!
    var textLastName :  UITextField!
    var textUserName :  UITextField!
    var textEmail :     UITextField!
    var textPassword :  UITextField!
    var textGender : UITextField!
    var textDOB : UITextField!
    var textCity : UITextField!
    var textConfirmPassword : UITextField!
    var textFirstNameView : UIView!
    var textLastView : UIView!
    var textUserView : UIView!
    var textEmailView : UIView!
    var textPasswordView : UIView!
    var textGenderView : UIView!
    var textDOBView : UIView!
    var textCityView : UIView!
    var textConfirmPasswordView : UIView!
    var btnSubmit   : UIButton!
    var firstBlnkValue = 0
    var firstBlnkValue1 = 0
    var firstBlnkValue2 = 0
    var firstBlnkValue3 = 0
    var firstBlnkValue4 = 0
    var firstBlnkValue5 = 0
    var firstBlnkValue6 = 0
    var firstBlnkValue7 = 0

    var btnSignFB : UIButton!
    var scrollView : UIScrollView!
    var genderTableView : UITableView!
    var cityTableView : UITableView!
    var datePickerView : UIView!
    var datePicker : UIDatePicker!
    var cityArray : NSMutableArray!
    var transparentView : UIView!
    var textClick = 1
    var textBegin = 0
    var dateSelectedStr = NSString()
    var upGradebackView: UIView = UIView()
    var vWGender: UIView = UIView()
    var productArray : (NSMutableArray) = NSMutableArray()
    var productIdentifier :  (NSString) = NSString()
    var inAppProducts : (inAppClass)!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        cityArray = NSMutableArray(array: ["Chandigarh","Mohali","Delhi","Ambala"])
        genderTableView = UITableView()
        cityTableView = UITableView()
        inAppProducts = inAppClass.sharedInstance()
        inAppProducts.delegate = self
        self.createUI()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
    func createUI()
    {
//        var rect = CGRectZero
//        rect.size.width = UIScreen.mainScreen().bounds.size.width
//        rect.size.height = UIScreen.mainScreen().bounds.height
        //BGImage
        var image = AppBackgroundImage
        let ImageBG = UIImageView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height))
        ImageBG.image = image
        self.view .addSubview(ImageBG)
        
        //UIScrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height))
        scrollView.contentSize=CGSize(width: 320, height: 600)
        scrollView.bounces = false
        self.view.addSubview(scrollView)
        
        let backB = UIButton.init(type: UIButtonType.custom)
        backB.frame = CGRect(x: 10, y: 36 ,width: 22,height: 22)
        backB.setBackgroundImage(UIImage(named: "back_errow"), for: UIControlState())
        backB.addTarget(self, action: #selector(SMLRegisterViewController.backBtnAction(_:)), for: UIControlEvents.touchUpInside)
        scrollView.addSubview(backB)
        
        // UILabel.
        let lblwidth = (ScreenSize.width / 2) - 100
        let lblRegister = UILabel(frame: CGRect(x: lblwidth  ,y: 20,width: 200, height: 40))
        lblRegister.text = "REGISTER"
        lblRegister.font = SMLGlobal.sharedInstance.fontSize(24.0)
        lblRegister.textColor = UIColor.white
        lblRegister.textAlignment = NSTextAlignment.center
        scrollView.addSubview(lblRegister)
        let line : UIView = UIView()
        line.frame = CGRect(x: 40, y: lblRegister.frame.height - 4, width: lblRegister.frame.width - 75, height: 1.5)
        line.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 0.5)
        lblRegister.addSubview(line)
        
//        lblRegister.font = SMLGlobal.sharedInstance.fontSize(24.0)
//        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
//        let underlineAttributedString = NSAttributedString(string: "REGISTER", attributes: underlineAttribute)
//        lblRegister.attributedText = underlineAttributedString
//        lblRegister.textColor = UIColor .whiteColor()
//        lblRegister.textAlignment = NSTextAlignment.Center
//        scrollView.addSubview(lblRegister)
         //var placeholderColor : (UIColor) =
        
        //TextField
        let  textFieldWidth:CGFloat = ScreenSize.width-80;
        let textField_X:CGFloat  = 40
        let textFieldHeight:CGFloat  = 40
        let  txtFont : UIFont = SMLGlobal.sharedInstance.fontSize(12.0)
        
        //First Name
        let textFieldFirstNameView: UIView = UIView()
        textFieldFirstNameView.frame = CGRect(x: textField_X , y: lblRegister.frame.maxY + 30, width: textFieldWidth , height: textFieldHeight)
        textFieldFirstNameView.layer.cornerRadius = 5
        textFieldFirstNameView.layer.borderWidth = 0.5
        textFieldFirstNameView.backgroundColor = UIColor.white
        scrollView.addSubview(textFieldFirstNameView)
        
        self.textFirstName = UITextField()
        self.textFirstName.frame = CGRect(x: 36 , y: 0, width: textFieldWidth - 36 , height: textFieldHeight)
        self.textFirstName.tag = 1
        let FirstPlaceholder = NSAttributedString(string: "First Name", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
        self.textFirstName.attributedPlaceholder = FirstPlaceholder;
        self.textFirstName.backgroundColor = UIColor.white
        self.textFirstName.delegate = self
        self.textFirstName.borderStyle = UITextBorderStyle.roundedRect;
        self.textFirstName.autocorrectionType = UITextAutocorrectionType.no
        self.textFirstName.returnKeyType=UIReturnKeyType.next
        self.textFirstName.leftViewMode = UITextFieldViewMode.always
        self.textFirstName.font = txtFont
        textFieldFirstNameView.addSubview(self.textFirstName)
        let line1 = UIView()
        line1.frame = CGRect(x: 35, y: 0, width: 2, height: textFirstName.frame.height)
        line1.backgroundColor = UIColor.white
        textFieldFirstNameView.addSubview(line1)
        let fNameImage = UIImageView(frame: CGRect(x: 12, y: 7, width: 25, height: 25))
        fNameImage.image = UIImage(named: "first_name")
        textFieldFirstNameView.addSubview(fNameImage)
        
        let textFieldLastNameView: UIView = UIView()
        textFieldLastNameView.frame = CGRect(x: textField_X , y: textFieldFirstNameView.frame.maxY + 10, width: textFieldWidth , height: textFieldHeight)
        textFieldLastNameView.layer.cornerRadius = 5
        textFieldLastNameView.layer.borderWidth = 0.5
        textFieldLastNameView.backgroundColor = UIColor.white
        scrollView.addSubview(textFieldLastNameView)
        
        self.textLastName = UITextField()
        self.textLastName.frame = CGRect(x: 36, y: 0, width: textFieldWidth - 36, height: textFieldHeight)
        self.textLastName.tag = 2
        self.textLastName.backgroundColor = UIColor.white
        self.textLastName.delegate=self
        self.textLastName.borderStyle = UITextBorderStyle.roundedRect;
        let FirstPlaceholder1 = NSAttributedString(string: "Last Name", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor,NSFontAttributeName : txtFont])
        self.textLastName.attributedPlaceholder = FirstPlaceholder1;
        self.textLastName.autocorrectionType = UITextAutocorrectionType.no
        self.textLastName.returnKeyType=UIReturnKeyType.next
        self.textLastName.leftViewMode = UITextFieldViewMode.always
        self.textLastName.font = txtFont
        textFieldLastNameView.addSubview(self.textLastName)
        
        let line2 = UIView()
        line2.frame = CGRect(x: 35, y: 0, width: 2, height: textLastName.frame.height)
        line2.backgroundColor = UIColor.white
        textFieldLastNameView.addSubview(line2)

        let LNameImage = UIImageView(frame: CGRect(x: 12, y: 7, width: 25, height: 25))
        LNameImage.image = UIImage(named: "last_name")
         textFieldLastNameView.addSubview(LNameImage)
        
        let textUserNameView: UIView = UIView()
        textUserNameView.frame = CGRect(x: textField_X , y: textFieldLastNameView.frame.maxY + 10, width: textFieldWidth , height: textFieldHeight)
        textUserNameView.layer.cornerRadius = 5
        textUserNameView.layer.borderWidth = 0.5
        textUserNameView.backgroundColor = UIColor.white
        scrollView.addSubview(textUserNameView)
        
        self.textUserName = UITextField()
        self.textUserName.frame = CGRect(x: 36, y: 0, width: textFieldWidth - 36, height: textFieldHeight)
        self.textUserName.tag = 3
        self.textUserName.backgroundColor = UIColor.white
        self.textUserName.delegate=self
        self.textUserName.borderStyle = UITextBorderStyle.roundedRect;
        let FirstPlaceholder2 = NSAttributedString(string: "User Name", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor,NSFontAttributeName : txtFont])
        self.textUserName.attributedPlaceholder = FirstPlaceholder2;
        self.textUserName.autocorrectionType = UITextAutocorrectionType.no
        self.textUserName.returnKeyType=UIReturnKeyType.next
        self.textUserName.leftViewMode = UITextFieldViewMode.always
           self.textUserName.font = txtFont
        textUserNameView.addSubview(self.textUserName)
        
        let line3 = UIView()
        line3.frame = CGRect(x: 35, y: 0, width: 2, height: textUserName.frame.height)
        line3.backgroundColor = UIColor.white
        textUserNameView.addSubview(line3)
        
        let UNameImage = UIImageView(frame: CGRect(x: 12, y: 7, width: 25, height: 25))
        UNameImage.image = UIImage(named: "user_name")
       textUserNameView.addSubview(UNameImage)

        let textEmailView: UIView = UIView()
        textEmailView.frame = CGRect(x: textField_X , y: textUserNameView.frame.maxY + 10, width: textFieldWidth , height: textFieldHeight)
        textEmailView.layer.cornerRadius = 5
        textEmailView.layer.borderWidth = 0.5
        textEmailView.backgroundColor = UIColor.white
        scrollView.addSubview(textEmailView)
        
        //Email
        self.textEmail = UITextField()
        self.textEmail.frame =  CGRect(x: 36, y: 0, width: textFieldWidth - 36, height: textFieldHeight)
        self.textEmail.tag = 4
        self.textEmail.backgroundColor = UIColor.white
        self.textEmail.delegate=self;
        self.textEmail.borderStyle = UITextBorderStyle.roundedRect;
        let FirstPlaceholder3 = NSAttributedString(string: "E-mail" , attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor ,NSFontAttributeName : txtFont])
        self.textEmail.attributedPlaceholder = FirstPlaceholder3;
        self.textEmail.keyboardType=UIKeyboardType.emailAddress
        self.textEmail.autocorrectionType = UITextAutocorrectionType.no
        self.textEmail.leftViewMode = UITextFieldViewMode.always
           self.textEmail.font = txtFont
        self.textEmail.returnKeyType=UIReturnKeyType.next
        textEmailView.addSubview(self.textEmail)

        let line4 = UIView()
        line4.frame = CGRect(x: 35, y: 0, width: 2, height: textUserName.frame.height)
        line4.backgroundColor = UIColor.white
        textEmailView.addSubview(line4)
        image = UIImage(named: "e-mailreg")
        let EmailImage = UIImageView(frame: CGRect(x: 12, y: 7, width: 25, height: 25))
        EmailImage.image=image
        textEmailView.addSubview(EmailImage)

        //Gender
         vWGender = UIView(frame:  CGRect(x: textField_X , y: textEmailView.frame.maxY + 10 ,width: textFieldWidth,height: textFieldHeight))
        vWGender.layer.cornerRadius = 5
        vWGender.backgroundColor = UIColor.white
        scrollView.addSubview(vWGender)
        
        let tapGestre = UITapGestureRecognizer()
        tapGestre .addTarget(self, action:#selector(SMLRegisterViewController.GenderAction(_:)))
        vWGender.addGestureRecognizer(tapGestre)
        
        self.textGender = UITextField()
        self.textGender.frame =  CGRect(x: textField_X , y: 0  ,width: textFieldWidth-70 ,height: textFieldHeight)
        self.textGender.tag = 5
        self.textGender.backgroundColor = UIColor.white
        self.textGender.delegate=self;
       // self.textGender.borderStyle = UITextBorderStyle.RoundedRect;
        let FirstPlaceholder5 = NSAttributedString(string: "Probation/Parole Officer Name" , attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor , NSFontAttributeName : txtFont])
        self.textGender.attributedPlaceholder = FirstPlaceholder5;
        self.textGender.font = txtFont
        self.textGender.autocorrectionType = UITextAutocorrectionType.no
        self.textGender.leftViewMode = UITextFieldViewMode.always
        vWGender.addSubview(self.textGender)
        self.textGender.text = ""
        
//        image = UIImage(named: "down_errow")
//        let imageViewArrow = UIImageView(frame: CGRect(x: textFieldWidth - 40 , y: 11, width: 18, height: 18))
//        imageViewArrow.image = image
//        vWGender.addSubview(imageViewArrow)
        
        image = UIImage(named: "first_name")
        let imageFaceGen = UIImageView(frame: CGRect(x: 12, y: 7, width: 25, height: 25))
        imageFaceGen.image=image
        vWGender.addSubview(imageFaceGen)
//
        let vWDOB = UIView(frame:  CGRect(x: textField_X , y: vWGender.frame.maxY + 10 ,width: textFieldWidth,height: textFieldHeight))
        vWDOB.layer.cornerRadius = 5
        vWDOB.backgroundColor = UIColor.white
        scrollView.addSubview(vWDOB)
        
        let DobGesture = UITapGestureRecognizer()
        DobGesture .addTarget(self, action:#selector(SMLRegisterViewController.DOBAction(_:)))
        vWDOB.addGestureRecognizer(DobGesture)
        
        self.textDOB = UITextField()
        self.textDOB.frame =  CGRect(x: textField_X , y: 0  ,width: textFieldWidth-70 ,height: textFieldHeight)
        self.textDOB.tag = 6
        self.textDOB.backgroundColor =  UIColor.white
        self.textDOB.delegate=self;
        self.textDOB.isUserInteractionEnabled = false
           self.textDOB.font = txtFont
        //self.textDOB.borderStyle = UITextBorderStyle.RoundedRect;
        let FirstPlaceholder6 = NSAttributedString(string: "Date Of Birth" , attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor , NSFontAttributeName : txtFont])
        self.textDOB.attributedPlaceholder = FirstPlaceholder6;
        self.textDOB.autocorrectionType = UITextAutocorrectionType.no
        self.textDOB.leftViewMode = UITextFieldViewMode.always
        vWDOB.addSubview(self.textDOB)

        image = UIImage(named: "clander")
        let imageViewCalender = UIImageView(frame: CGRect(x: textFieldWidth - 40 , y: 7 , width: 25, height: 25))
        imageViewCalender.image = image
        vWDOB.addSubview(imageViewCalender)
        
        image = UIImage(named: "date_birth")
        let imageFaceDOB = UIImageView(frame: CGRect(x: 10, y: 7, width: 25, height: 25))
        imageFaceDOB.image=image
        vWDOB.addSubview(imageFaceDOB)
        
        let vWCity = UIView(frame: CGRect(x: textField_X , y: vWDOB.frame.maxY + 10 ,width: textFieldWidth,height: textFieldHeight))
        vWCity.layer.cornerRadius = 5
         vWCity.layer.borderWidth = 0.5
        vWCity.backgroundColor = UIColor.white
        scrollView.addSubview(vWCity)
        
        self.textCity = UITextField()
        self.textCity.frame =  CGRect(x: 36 , y: 0  ,width: textFieldWidth - 40 ,height: textFieldHeight)
        self.textCity.tag = 7
        self.textCity.backgroundColor =  UIColor.white
        self.textCity.delegate=self;
        self.textCity.isUserInteractionEnabled = true
        self.textCity.font = txtFont
        //self.textCity.borderStyle = UITextBorderStyle.RoundedRect;
        let FirstPlaceholder7 = NSAttributedString(string: "Probation/Parole Officer Email" , attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor , NSFontAttributeName : txtFont])
        self.textCity.attributedPlaceholder = FirstPlaceholder7;
        self.textCity.returnKeyType =  UIReturnKeyType.next
        self.textCity.autocorrectionType = UITextAutocorrectionType.no
        self.textCity.leftViewMode = UITextFieldViewMode.always
        vWCity.addSubview(self.textCity)
        self.textCity.text = ""
        
        image = UIImage(named: "e-mailreg")
        let cityImage = UIImageView(frame: CGRect(x: 12, y: 7, width: 25, height: 25))
        cityImage.image=image
        vWCity.addSubview(cityImage)

        //Password
        let textPasswordView: UIView = UIView()
        textPasswordView.frame = CGRect(x: textField_X , y: vWCity.frame.maxY + 10, width: textFieldWidth , height: textFieldHeight)
        textPasswordView.layer.cornerRadius = 5
        textPasswordView.layer.borderWidth = 0.5
        textPasswordView.backgroundColor = UIColor.white
        scrollView.addSubview(textPasswordView)
        
        self.textPassword = UITextField()
        self.textPassword.frame =  CGRect(x: 36 , y: 0 ,width: textFieldWidth - 40,height: textFieldHeight)
        self.textPassword.tag = 8
        self.textPassword.backgroundColor = UIColor.white
        self.textPassword.delegate=self;
           self.textPassword.font = txtFont
       // self.textPassword.borderStyle = UITextBorderStyle.RoundedRect;
        let FirstPlaceholder4 = NSAttributedString(string: "Password" , attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor , NSFontAttributeName : txtFont])
        self.textPassword.attributedPlaceholder = FirstPlaceholder4;
        self.textPassword.isSecureTextEntry=true
         self.textPassword.returnKeyType =  UIReturnKeyType.next
        self.textPassword.autocorrectionType = UITextAutocorrectionType.no
        self.textPassword.leftViewMode = UITextFieldViewMode.always
        textPasswordView.addSubview(self.textPassword)
        
        image = UIImage(named: "passwordreg")
        let PassImage = UIImageView(frame: CGRect(x: 12, y: 7, width: 25, height: 25))
        PassImage.image=image
        //self.textPassword.leftView = PassImage
        textPasswordView.addSubview(PassImage)
        
        let textConfirmPasswordView: UIView = UIView()
        textConfirmPasswordView.frame = CGRect(x: textField_X , y: textPasswordView.frame.maxY + 10, width: textFieldWidth , height: textFieldHeight)
        textConfirmPasswordView.layer.cornerRadius = 5
        textConfirmPasswordView.layer.borderWidth = 0.5
        textConfirmPasswordView.backgroundColor = UIColor.white
        scrollView.addSubview(textConfirmPasswordView)

        self.textConfirmPassword = UITextField()
        self.textConfirmPassword.frame =  CGRect(x: 36 , y: 0 ,width: textFieldWidth - 40,height: textFieldHeight)
        self.textConfirmPassword.tag = 9
        self.textConfirmPassword.backgroundColor = UIColor.white
        self.textConfirmPassword.delegate=self;
        //self.textConfirmPassword.borderStyle = UITextBorderStyle.RoundedRect;
        let FirstPlaceholder10 = NSAttributedString(string: "Confirm Password" , attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor , NSFontAttributeName : txtFont])
        self.textConfirmPassword.attributedPlaceholder = FirstPlaceholder10;
        self.textConfirmPassword.isSecureTextEntry=true
         self.textConfirmPassword.returnKeyType =  UIReturnKeyType.done
        self.textConfirmPassword.autocorrectionType = UITextAutocorrectionType.no
        self.textConfirmPassword.leftViewMode = UITextFieldViewMode.always
           self.textConfirmPassword.font = txtFont
        textConfirmPasswordView.addSubview(self.textConfirmPassword)
        
        let cImage : (UIImage) = UIImage(named: "passwordreg")!
        let CPassImage = UIImageView(frame: CGRect(x: 10, y: 7, width: 25, height: 25))
        CPassImage.image=cImage
        textConfirmPasswordView.addSubview(CPassImage)
        //self.textConfirmPassword.leftView = CPassImage
        
        //CGRectMake(textField_X , CGRectGetMaxY(vWDOB.frame) + 20 ,textFieldWidth,textFieldHeight
        
        btnSubmit = UIButton.init(type: UIButtonType.custom)
        btnSubmit.frame = CGRect(x: textField_X , y: textConfirmPasswordView.frame.maxY + 20 ,width: textFieldWidth,height: 43)
        image = UIImage(named: "submit")
       // btnSubmit.setTitle("Submit", forState: UIControlState.Normal)
        btnSubmit .setImage(image, for: UIControlState())
        btnSubmit.addTarget(self, action: #selector(SMLRegisterViewController.submitAction(_:)), for: UIControlEvents.touchUpInside)
        scrollView.addSubview(btnSubmit)
        
        let backBtn = UIButton.init(type: UIButtonType.custom)
        backBtn.frame = CGRect(x: textField_X , y: btnSubmit.frame.maxY + 10 ,width: textFieldWidth,height: 43)
        backBtn.setImage(UIImage(named: "register_cancel"), for: UIControlState())
        backBtn.addTarget(self, action: #selector(SMLRegisterViewController.backBtnAction(_:)), for: UIControlEvents.touchUpInside)
        scrollView.addSubview(backBtn)
        
    
        if ScreenSize.height >= 667 {
            
        } else {
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: backBtn.frame.maxY + 30)
        
        }
        
        
        
        datePickerView = UIView()
        datePickerView.frame = CGRect(x: 0, y: self.view.frame.size.height - 250, width: ScreenSize.width, height: 250)
        datePickerView.backgroundColor = UIColor.white
        //scrollView.addSubview(datePickerView)
        
        var doneBtn : UIButton!
        doneBtn = UIButton.init(type: UIButtonType.custom)
        doneBtn .setTitleColor(UIColor.black, for: UIControlState())
        
        doneBtn.setTitle("Done", for: UIControlState())
        doneBtn.frame = CGRect(x: 10, y: 5 , width: 50, height: 30)
        doneBtn .addTarget(self, action: #selector(SMLRegisterViewController.DoneBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(doneBtn)
        
        var CancelBtn : UIButton!
        CancelBtn = UIButton.init(type: UIButtonType.custom)
        CancelBtn.setTitle("Cancel", for: UIControlState())
        CancelBtn .setTitleColor(UIColor.black, for: UIControlState())
        CancelBtn.frame = CGRect(x: datePickerView.frame.size.width - 80 ,y: 5, width: 70, height: 30)
        CancelBtn .addTarget(self, action: #selector(SMLRegisterViewController.CancelBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(CancelBtn)
        
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: 50, width: ScreenSize.width, height: 200)
        datePicker.datePickerMode = UIDatePickerMode.date
        datePickerView.addSubview(datePicker)
        
        self.genderTableView = UITableView(frame:CGRect(x: vWGender.frame.origin.x, y: vWGender.frame.maxY, width: textPasswordView.frame.size.width,height: 90))
        self.genderTableView.dataSource = self
        self.genderTableView.delegate = self
        self.genderTableView.layer.cornerRadius = 4.0
         self.scrollView.addSubview(self.genderTableView)
        genderTableView.isHidden = true
        
        let gesture = UITapGestureRecognizer.init(target: self, action:#selector(SMLRegisterViewController.bgScrollViewGesture))
        gesture.delegate = self
        scrollView .addGestureRecognizer(gesture)
    }

    func bgScrollViewGesture()
    {
       self.resignAllTextFields()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
       
        if textField == textFirstName
        {
            textLastName .becomeFirstResponder()
        }
        else if textField == textLastName
        {
            textUserName.becomeFirstResponder()
        }
        else if textField == textUserName
        {
            textEmail.becomeFirstResponder()
        }
        else if textField == textEmail
        {
            textCity.becomeFirstResponder()
        }
        else if textField == textCity
        {
            textPassword.becomeFirstResponder()
        }
        else if textField == textPassword
        {
            textConfirmPassword.becomeFirstResponder()
        }
        else if textField == textConfirmPassword
        {
            textConfirmPassword.resignFirstResponder()
        }
        
        if ScreenSize.height == 667
        {
            print(textField.tag)
            if textField.tag < 7
            {
                print(textField.tag)
                scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
            else if textField == textConfirmPassword
            {
                scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
            else
            {
                scrollView.contentOffset = CGPoint(x: 0, y: scrollView.contentOffset.y + 50)
            }
        }
        else if ScreenSize.height == 480
        {
            if textField.tag <= 3
            {
                scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
            else
            {
               scrollView.contentOffset = CGPoint(x: 0, y: 160)
            }
        }
        else
        {
            if textField.tag <= 3
            {
                scrollView.contentOffset = CGPoint(x: 0, y: 0)
            }
            else
            {
            scrollView.contentOffset = CGPoint(x: 0, y: 70)
            }
        }
        //self.resignAllTextFields()
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        datePickerView.removeFromSuperview()
        self.genderTableView.removeFromSuperview()
        let tagValue : CGFloat =  CGFloat(textField.tag)
        if(ScreenSize.height == 667)
        {
        if(tagValue>4)
        {
               scrollView.contentOffset = CGPoint(x: 0, y: 10 * tagValue);
        }
        }
        else
        {
            if(tagValue>1)
            {
                if ScreenSize.height == 480 {
                scrollView.contentOffset = CGPoint(x: 0, y: 35 * tagValue);
                } else {
                     scrollView.contentOffset = CGPoint(x: 0, y: 25 * tagValue);
                }
            }
        }
        return
    }
  
 
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        return true
    }

    func  touchesBegan(_ touches: Set<NSObject>, with event: UIEvent)
    {
        view.endEditing(true)
        super.touchesBegan(touches as! Set<UITouch>, with: event)
    }
    
    //MARK: - Table View Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if(tableView  ==  self.genderTableView)
        {
            return 2
        }
        else
        {
            return cityArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell?.textLabel?.textColor = UIColor.black
        }
        if(tableView == self.genderTableView)
        {
            if((indexPath as NSIndexPath).row == 0)
            {
            cell?.textLabel?.text = "Male"
            
            }
            else
            {
                cell?.textLabel?.text = "Female"
            }
        }
        else
        {
            cell?.textLabel?.text = cityArray.object(at: indexPath.row) as? String
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       if(tableView == genderTableView)
       {
        genderTableView.removeFromSuperview()
        self.textGender.textColor = UIColor.black
        if ((indexPath as NSIndexPath).row == 0)
        {
         self.textGender.text = "Male"
        }
        else
        {
         self.textGender.text = "Female"
        }
       }
       else
       {
        cityTableView.removeFromSuperview();
        transparentView.removeFromSuperview();
        self.textCity.text = cityArray.object(at: (indexPath as NSIndexPath).row) as? String
        }
    }
    //MARK: - Actions
    func backBtnAction(_ sender : UIButton)
    {
        self.resignAllTextFields()
        self.navigationController?.popViewController(animated: false)
    }
    
    func CancelBtnAction(_ sender : UIButton)
    {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        datePickerView .removeFromSuperview()
    }
    func DoneBtnAction(_ sender : UIButton)
    {
       // scrollView.contentOffset = CGPointMake(0, 0)
        if ScreenSize.height == 667 {
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
        }
        let pickerDate : (Date) = datePicker.date
        let currentDate = Date()
        if(pickerDate .compare(currentDate) == ComparisonResult.orderedAscending)
        {
            let DF = DateFormatter()
            DF.dateFormat = "yyyy-MM-dd"
            dateSelectedStr =  DF.string(from: pickerDate) as NSString
            let selectedDate : (Date) = DF.date(from: dateSelectedStr as String)!
             DF.dateFormat = "dd-MM-yyyy"
            let selectedDateStr : (NSString) = DF.string(from: selectedDate) as (NSString)
            textDOB.text = selectedDateStr as String;
            datePickerView .removeFromSuperview()
        }
        else
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Future date can't be chosen as a Date of birth.", title: "")
        }
    }
    
    func GenderAction(_ sender : UIButton)
    {
        self.resignAllTextFields()
        datePickerView .removeFromSuperview()
       // scrollView.contentOffset = CGPointMake(0, 0)
        for vw in scrollView.subviews
        {
            if !vw.isEqual(genderTableView)
            {
                genderTableView.isHidden = false
                scrollView.addSubview(genderTableView)
            }
        }
        textPassword.resignFirstResponder()
    }
    
    func DOBAction(_ sender : UIButton)
    {
        self.resignAllTextFields()
        if ScreenSize.height == 480 {
               scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.frame.origin.y+140)
        } else {
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: scrollView.frame.origin.y+100)
        }
        //scrollView.contentOffset = CGPointMake(0, 0)
        self.view.addSubview(datePickerView)
    }
    func CityAction(_ sender : UIButton)
    {
        self.resignAllTextFields()
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        transparentView = UIView()
        transparentView.frame =  self.view.bounds;
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        scrollView.addSubview(transparentView);
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(SMLRegisterViewController.removeTransparentView(_:)))
        transparentView.addGestureRecognizer(tapGesture)
        cityTableView = UITableView()
        cityTableView.frame = CGRect(x: (ScreenSize.width-250)/2, y: (ScreenSize.height-200)/2 , width: 250,height: 200)
        cityTableView.dataSource = self
        cityTableView.delegate = self
        scrollView.addSubview(cityTableView)
        textCity.resignFirstResponder()
    }
    
    func submitAction(_ sender : UIButton)
    {
        resignAllTextFields()
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        var username = NSString()
        if(textUserName.text == nil )
        {
           username = ""
        }
        else
        {
            username = textUserName.text! as NSString
        }
        var lastName = NSString()
        if(textLastName.text == nil )
        {
            lastName = ""
        }
        else
        {
            lastName = textLastName.text! as NSString
        }
        // http://112.196.34.179/stepslocator/index.php/login/wsregistration?firstname=&lastname=&email=&password=&username=&probation_email=&probation_name=&dob=
        
        
   
        
        
        
        let parameters : (NSDictionary) = ["firstname" : textFirstName.text! as NSString,
                                            "lastname" : lastName,
                                            "email"    : textEmail.text! as NSString,
                                            "password" : textPassword.text! as NSString,
                                            "username" : username,
                                            "probation_email": textCity.text! as NSString,
                                            "probation_name" : textGender.text! as NSString,
                                            "dob"      : dateSelectedStr,
                                            "usertype" : "1",
                                            "confirm_password" : textConfirmPassword.text! as NSString]
        
        

 
        regVal()
       if(CheckTextFields())
       {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
        SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        WebserviceManager .sharedInstance.getRegisterWebservice(params: parameters, withCompletionBlock: { (responseObject, error) in
            
            if responseObject != nil
            {
                let dict :(NSDictionary) = responseObject as! NSDictionary
                let string : (NSString) = dict.value(forKey: "message") as! NSString
                let success : (NSInteger) = dict.value(forKey: "success") as! NSInteger
                //If success is 1
                if(success == 1)
                {
                    let userValues : NSDictionary = dict.value(forKey: "data") as! NSDictionary
                    self.textConfirmPassword.isEnabled = false
                    //                    var dob : (NSString) = userValues.objectForKey("dob") as! NSString
                    //                    var df : (NSDateFormatter) = NSDateFormatter()
                    //                    df.dateFormat = "yyyy-MM-dd"
                    //                    var dobDate : (NSDate) = df .dateFromString(dob as String)!
                    //                    df.dateFormat = "dd-MMM-yyyy"
                    //                    var dobStr : (NSString) = df.stringFromDate(dobDate)
                    let appUser = SMLAppUser()
                    //let x:NSNumber = 6.0
                    let s : NSString = userValues.object(forKey: "login_id") as! NSString
                    
                    // let s:String = String(format:"%f", x.doubleValue) //formats the string to accept double/float
                    appUser.userId = s
                    //appUser.userId = userValues.objectForKey("login_id") as! NSString
                    //appUser.userId = NSString(format: "%d", userValues.objectForKey("login_id") as! Int)
                    appUser.firstName = userValues.object(forKey: "firstname") as! NSString
                    appUser.lastName = userValues.object(forKey: "lastname") as! NSString
                    appUser.userName = userValues.object(forKey: "username") as! NSString
                    appUser.probationName = userValues.object(forKey: "probation_name") as! NSString
                    appUser.probationEmail = userValues.object(forKey: "probation_email") as! NSString
                    appUser.dob = userValues.object(forKey: "dob") as! NSString
                    appUser.email = userValues.object(forKey: "email") as! NSString
                    var profileStr : (NSString) = userValues.value(forKey: "profile_pic") as! NSString
                    appUser.upgrade  = userValues.object(forKey: "user_payment_role") as! NSString
                    appUser.pushNotification = userValues.object(forKey: "push_status") as! NSString
                    appUser.emailNotification = userValues.object(forKey: "email_status") as! NSString
                    if(profileStr == "")
                    {
                        
                    }
                    else
                    {
                        profileStr =  profileImagesUrl.appending(profileStr as String) as (NSString)
                    }
                    appUser.profilePic = profileStr

                    //1 usertype for normal login
                    appUser.userType =  userValues.object(forKey: "usertype") as! NSString
                    SMLAppUser.saveUser(appUser)
                    
                    let delegateObj : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
                    if(appUser.pushNotification .isEqual(to: "1"))
                    {
                        if( UserDefaults.standard.object(forKey: "DeviceToken") != nil)
                        {
                            let deviceToken : (NSString) = UserDefaults.standard.object(forKey: "DeviceToken") as! NSString
                            delegateObj.getDeviceToken(deviceToken, loginId: appUser.userId)
                            
                            delegateObj.sendCurrentLocation()
                        }
                    }
                                        //else
                    //                    {
                    //                         var delegateObj : (AppDelegate) = UIApplication.sharedApplication().delegate as! AppDelegate
                    //                        var deviceToken : (NSString) = "First_User" as NSString
                    //                        delegateObj.getDeviceToken(deviceToken, loginId: appUser.userId)
                    //                        delegateObj.sendCurrentLocation()
                    //                    }
                    
                    if(appUser.upgrade == "0")
                    {
                    //    self.displayUpgrade()
                    }
                    //                    var alertViewSucess = UIAlertView (title: "", message:string as String, delegate: self, cancelButtonTitle: "OK")
                    //                    alertViewSucess.show();
                    //                        NSUserDefaults.standardUserDefaults() .setObject(userValues, forKey: "UserData")
                    //                        NSUserDefaults.standardUserDefaults().synchronize()
                    
                    
                    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    
                    appDelegate.objRootViewController = FirstViewController(nibName: nil, bundle: nil)
                    appDelegate.callMethod(appDelegate.objRootViewController!)
                }
                    //If success is 0
                else
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, string as NSString, title: "")
                }
                SVProgressHUD.dismiss()
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
         firstBlnkValue = 0
        }
    }
    
    func displayUpgrade()
    {
        
        self.upGradebackView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        self.upGradebackView.backgroundColor = UIColor(white: 0.05, alpha: 0.5)
        self.view.addSubview(self.upGradebackView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SMLRegisterViewController.removeUpgradeView(_:)))
        self.upGradebackView.addGestureRecognizer(tapGesture)
        
        let backGroundView: UIView = UIView()
        backGroundView.frame = CGRect(x: 20, y: (ScreenSize.height - 268)/2, width: ScreenSize.width - 40, height: 268)
        backGroundView.layer.cornerRadius = backGroundView.frame.size.width * 0.02
        backGroundView.backgroundColor = UIColor.white
        self.upGradebackView.addSubview(backGroundView)
        let topLabel: UILabel = UILabel()
        topLabel.frame = CGRect(x: (backGroundView.frame.size.width / 2) - 75, y: 10, width: backGroundView.frame.width - 50, height: 20)
        topLabel.text = "Upgrade to Premium"
        topLabel.textColor = UIColor.black
        topLabel.font = SMLGlobal.sharedInstance.fontSizeBold(15)
        backGroundView.addSubview(topLabel)
        
        let upgradeHeader: UILabel = UILabel()
        upgradeHeader.frame = CGRect(x: 0, y: topLabel.frame.maxY + 10, width: backGroundView.frame.width, height: 20)
        upgradeHeader.text = "Upgrade to our Paid Version and receive:"
        upgradeHeader.font = SMLGlobal.sharedInstance.fontSizeBold(12)
        upgradeHeader.textAlignment = NSTextAlignment.center
        upgradeHeader.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        backGroundView.addSubview(upgradeHeader)
        
        let label1: UILabel = UILabel()
        label1.frame = CGRect(x: 25, y: upgradeHeader.frame.maxY + 10, width: upGradebackView.frame.size.width - 50, height: 15)
        if ScreenSize.height >= 667 {
            label1.frame = CGRect(x: 50, y: upgradeHeader.frame.maxY + 10, width: upGradebackView.frame.size.width - 50, height: 15)
        }
        label1.text = "-   GPS CHECK-IN Feature"
        label1.font = SMLGlobal.sharedInstance.fontSizeBold(11)
        label1.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        backGroundView.addSubview(label1)
        
        let label2: UILabel = UILabel()
        label2.frame = CGRect(x: 25, y: label1.frame.maxY + 10, width: upGradebackView.frame.size.width - 50, height: 30)
        if ScreenSize.height >= 667 {
            label2.frame = CGRect(x: 50, y: label1.frame.maxY + 10, width: upGradebackView.frame.size.width , height: 30)
        }
        label2.numberOfLines = 0
        label2.text = "-   Track your success online and on \n     your phone"
        label2.font = SMLGlobal.sharedInstance.fontSizeBold(11)
        label2.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        backGroundView.addSubview(label2)
        
        let label3: UILabel = UILabel()
        label3.frame = CGRect(x: 25, y: label2.frame.maxY + 10, width: upGradebackView.frame.size.width - 50, height: 30)
        if ScreenSize.height >= 667 {
            label3.frame = CGRect(x: 50, y: label2.frame.maxY + 10, width: upGradebackView.frame.size.width - 50, height: 30)
        }
        label3.text = "-   Receive Push Notifications When new \n    meetings are added in your area"
        label3.numberOfLines = 0
        label3.lineBreakMode = NSLineBreakMode.byWordWrapping
        label3.font = SMLGlobal.sharedInstance.fontSizeBold(11)
        label3.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        backGroundView.addSubview(label3)
        
        let label4: UILabel = UILabel()
        label4.frame = CGRect(x: 25, y: label3.frame.maxY + 10, width: upGradebackView.frame.size.width - 50, height: 15)
        if ScreenSize.height >= 667 {
            label4.frame = CGRect(x: 50, y: label3.frame.maxY + 10, width: upGradebackView.frame.size.width - 50, height: 15)
        }
        label4.text = "-   All Ads are removed in paid version"
        label4.font = SMLGlobal.sharedInstance.fontSizeBold(11)
        label4.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        backGroundView.addSubview(label4)
        
        let upgradeText: UITextView = UITextView()
        upgradeText.frame = CGRect(x: 25, y: upgradeHeader.frame.maxY + 10, width: 220, height: 140)
        upgradeText.text = "-   GPS CHECK-IN Feature\n \n-   Track your success online and on \n    your phone\n \n-   Receive Push Notifications When new\n    meetings are added in your area\n \n-   All Ads are removed in paid version"
        upgradeText.font = SMLGlobal.sharedInstance.fontSizeBold(10)
        upgradeText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        upgradeText.isEditable = false
        //backGroundView.addSubview(upgradeText)
        
        let upgradeButton: UIButton = UIButton()
        upgradeButton.frame = CGRect(x: (backGroundView.frame.width / 2) - 116, y: label4.frame.maxY + 20, width: 111, height: 37)
        //25,85,171
        let upImg = UIImage(named: "upgrad_button")
        //upgradeButton.backgroundColor = UIColor.blackColor()
        upgradeButton.setBackgroundImage(upImg, for: UIControlState())
        upgradeButton.addTarget(self, action: #selector(SMLRegisterViewController.upgradeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        backGroundView.addSubview(upgradeButton)
        
        let cancleButton: UIButton = UIButton()
        cancleButton.frame = CGRect(x: upgradeButton.frame.maxX+5, y: label4.frame.maxY + 20, width: 111, height: 37)
        //cancleButton.backgroundColor = UIColor.blackColor()
        let cnImg = UIImage(named: "popupcancel")
        cancleButton.setBackgroundImage(cnImg, for: UIControlState())
        cancleButton.addTarget(self, action: #selector(SMLRegisterViewController.cancleButtonClick1(_:)), for: UIControlEvents.touchUpInside)
        backGroundView.addSubview(cancleButton)
    }
    func removeUpgradeView(_ gesture : UITapGestureRecognizer)
    {
        upGradebackView.removeFromSuperview()
    }
    func upgradeButtonClick(_ sender: UIButton)
    {
        let alertController : (UIAlertController) = UIAlertController.init(title: "", message: "Do you want to upgrade this for $5.99", preferredStyle: UIAlertControllerStyle.alert)
        self.present(alertController, animated: true, completion: nil)
        
        let okAlert : (UIAlertAction) = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            self.purchaseWithId(PRODUCTID as NSString)
        })
        alertController .addAction(okAlert)
        
        //Cancel Action
        let cancelAlert : (UIAlertAction) = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            
        })
        alertController .addAction(cancelAlert)
    }
    
    func cancleButtonClick1(_ sender: UIButton)
    {
        upGradebackView.removeFromSuperview()
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
//        var secviewControler: ViewController   = ViewController()
//        navigationController?.pushViewController(secviewControler, animated: false)
    }
    func resignAllTextFields()
    {
        textEmail .resignFirstResponder()
        textFirstName.resignFirstResponder()
        textLastName.resignFirstResponder()
        textUserName.resignFirstResponder()
        textGender.resignFirstResponder()
        textDOB.resignFirstResponder()
        textCity.resignFirstResponder()
        textPassword.resignFirstResponder()
        textConfirmPassword.resignFirstResponder()
    }
    
    func removeTransparentView (_ recognizer : UITapGestureRecognizer)
    {
        //recognizer.view!.removeFromSuperview()
        cityTableView .removeFromSuperview()
        transparentView.removeFromSuperview()
    }

    func whiteSpaceCheck() ->Bool
    {
//        let rawString: NSString = textFirstName.text! as NSString
        // let whitespace: CharacterSet = CharacterSet.whitespacesAndNewlines
        //let trimmed: NSString = rawString.trimmingCharacters(in: whitespace) as NSString
        let numberOfSpaces =  textFirstName.text?.components(separatedBy: " ").count
        let numberOfSpaces1 = textLastName.text?.components(separatedBy: " ").count
        let numberOfSpaces2 = textUserName.text?.components(separatedBy: " ").count
        let numberOfSpaces3 = textEmail.text?.components(separatedBy: " ").count
        let numberOfSpaces4 = textCity.text?.components(separatedBy: " ").count
        let numberOfSpaces5 = textPassword.text?.components(separatedBy: " ").count
        let numberOfSpaces6 = textConfirmPassword.text?.components(separatedBy: " ").count
        if firstBlnkValue == 1
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in First Name field", title: "")
            textFirstName.text = ""
            return false;
        
        } else if firstBlnkValue == 2
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in Last Name field", title: "")
            textLastName.text = ""
            return false;
            
        }else if firstBlnkValue == 3
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in User Name field", title: "")
            textUserName.text = ""
            return false;
            
        }else if firstBlnkValue == 4
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in Email field", title: "")
            textEmail.text = ""
            return false;
            
        }else if firstBlnkValue == 5
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in Probation Email field", title: "")
            textCity.text = ""
            return false;
            
        }else if firstBlnkValue == 6 {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in Password field", title: "")
            textPassword.text = ""
            return false;
            
        } else if firstBlnkValue == 7 {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in Confirm Password field", title: "")
             textConfirmPassword.text = ""
            return false;
            
        }
        if numberOfSpaces! > 2 {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in First Name field", title: "")

             textFirstName.text = ""
            return false;
        } else if numberOfSpaces1! > 2 {
            SMLGlobal.sharedInstance.displayAlertMessage(self,  "Please remove space in Last Name field", title: "")

            textLastName.text = ""
            return false;
        }else if numberOfSpaces2! > 2 {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in User Name field", title: "")
             textUserName.text = ""
            return false;
        }else if numberOfSpaces3! > 2 {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in Email Name field", title: "")
              textEmail.text = ""
            return false;
        }else if numberOfSpaces4! > 2 {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in Probation Email field", title: "")
             textCity.text = ""
            return false;
        }else if numberOfSpaces5! > 2 {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in Password Name field", title: "")
            textPassword.text = ""
            return false;
        }else if numberOfSpaces6! > 2 {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please remove space in Confirm Password Name field", title: "")
            textConfirmPassword.text = ""
            return false;
        }
        else {
            return true;
        }
    }
    
    
    func CheckTextFields() ->Bool
    {
         let cou = textPassword.text?.characters.count
         let cou1 = textConfirmPassword.text?.characters.count
        let isEqual = (self.textPassword.text == self.textConfirmPassword.text)
//        now isEqual is true.
        if(self.textFirstName.text == "" || firstBlnkValue == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"First Name field is mandatory", title: "")
            textFirstName.text = ""
            return false;
        }
        else if(self.textLastName.text == "" || firstBlnkValue1 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Last Name field is mandatory", title: "")
            textLastName.text = ""
            return false;
        }
        else if(self.textUserName.text == "" || firstBlnkValue2 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"User Name field is mandatory", title: "")
            textUserName.text = ""
            return false;
        }
        else if(self.textEmail.text == "" )
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Email field is mandatory", title: "")
            return false;
        }
        else if(!isValidEmail(self.textEmail.text!))
        {
            if firstBlnkValue3 == 1 {
                SMLGlobal.sharedInstance.displayAlertMessage(self,"Email field is mandatory", title: "")

                textEmail.text = ""
                 return false;
            }
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Email is not valid", title: "")
            return false;
        }

        else if(self.textDOB.text == "")
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Please select Dob", title: "")
            return false;
        }
        
        if ((textGender.text?.characters.count)! > 0)
        {
            let str4 = textGender.text! as NSString

            let d = 32 as unichar
            let c:unichar = str4.character(at: 0)
            if c == d
            {
                SMLGlobal.sharedInstance.displayAlertMessage(self, "Please Enter valid Probation Name", title: "")
                textGender.text = ""
                return false;

            }
        }
        
        
        if firstBlnkValue == 1
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please Enter valid Probation Name", title: "")
            textGender.text = ""
            return false;
            
        }
        else if(self.textCity.text != "")
        {
            if(!isValidEmail(self.textCity.text!))
            {
             self.textCity.text = ""
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Probation Email is not valid", title: "")
            return false;
            }
        }
//        else if(!isValidCity(self.textCity.text!))
//        {
//            SMLGlobal.sharedInstance.displayAlertMessage(self,"Number or Special characters are not acceptable at city", title: "")
//             textCity.text = ""
//            return false;
//        }
        else if(self.textPassword.text == "" )
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Password field is mandatory", title: "")
            textPassword.text = ""
            return false;
        }
        else if (cou! <= 4) {
           
            SMLGlobal.sharedInstance.displayAlertMessage(self,"The New Password field must be at least 5 characters", title: "")
            textPassword.text = ""
            return false;
        }
        else if(self.textConfirmPassword.text == "")
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Confirm Password field is mandatory", title: "")
            textConfirmPassword.text = ""
            return false;
        }
        else if cou1! <= 4
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Re-Password field must be at least 5 characters", title: "")
            textConfirmPassword.text = ""
            return false
        }
        else if(!isEqual)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self,"Password and Confirm Password doesn't match", title: "")
            return false;
        }
            return true;
    }
    
    
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        //println(String(format: "%@", emailTest.evaluateWithObject(testStr)))
        return emailTest.evaluate(with: testStr)
    }
    
    
    func isValidCity(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let cityCheck = "[A-Za-z ]{1,20}"
        
        let cityTest = NSPredicate(format:"SELF MATCHES %@", cityCheck)
      //  println(String(format: "%@", cityTest.evaluateWithObject(testStr)))
        return cityTest.evaluate(with: testStr)
    }

    
    //MARK:- In app Purchase Methods
    
//    func upgradeBtnAction(sender:UIButton)
//    {
//        
//        var alertView :(UIAlertView) = UIAlertView(title: "", message: "Do you want to upgrade this for $9.99", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
//        alertView.show()
//        
//    }
//    
//    func cancelBtnAction(sender:UIButton)
//    {
//        self.navigationController?.popViewControllerAnimated(false)
//    }
    
//    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
//        
//        if(buttonIndex == 0)
//        {
//            
//        }
//        else
//        {
//            purchaseWithId(PRODUCTID)
//        }
//        
//    }
    
    
    
    
    
    // MARK:- In App Purchase Maethods
    func purchaseWithId(_ productId:NSString)
    {
        
        self.productArray = NSMutableArray()
        
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        self.productArray = delegate.productArray
        self.productIdentifier = productId
        
        //var timer :(Timer) = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(SMLRegisterViewController.working), userInfo: nil, repeats: false)
        //self.pe
        //[self performSelector:@selector(working) withObject:nil afterDelay:0.1];
    }
    func restoreWithProductId(_ productId:NSString)
    {
        self.productArray = NSMutableArray()
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        self.productArray = delegate.productArray
        //[self RestoreTransaction:nil];
    }
    //MARK:- In-App-Purchase
    func working()
    {
            if(self.productArray.count != 0)
            {
                let product : (SKProduct) = self.productArray[0] as! (SKProduct)
                self.inAppProducts .buyProduct(product)
            }
            else
            {
                SMLGlobal.sharedInstance.displayAlertMessage(self, "Please wait while load Products", title: "Alert")
            }
    }
    
    func didFinish(with transaction: SKPaymentTransaction)
    {
        
        upGradebackView.removeFromSuperview()
        let user : (SMLAppUser) = SMLAppUser.getUser()
        user.upgrade = "1"
        SMLAppUser.saveUser(user)
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        delegate.upgradeRole()
        SVProgressHUD.dismiss()
    }
    
    func didFailWithError(_ error: Error!, transaction: SKPaymentTransaction)
    {
        
    }
    
    //MARK :- Restore methods
    func startRestore()
    {
        
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error)
    {
        
    }
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue)
    {
        if(queue.transactions.count == 0)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "There is no products purchased by you", title: "Restore")
        }
        else
        {
            
            UIAlertView(title: "Restore", message: "Product Restored Successfully", delegate: nil, cancelButtonTitle: "OK").show()
            
            let user : (SMLAppUser) = SMLAppUser.getUser()
            user.upgrade = "1"
            SMLAppUser.saveUser(user)
            let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
            delegate.upgradeRole()
            SVProgressHUD.dismiss()
            
            let userDefault : (UserDefaults) = UserDefaults.standard
            userDefault.set(true, forKey: "Upgrade")
            userDefault.synchronize()
            
        
        }
    }
    
    //MARK :- Request For products
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        
    }
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
    func  passwordCheck()->Bool
    {
            if textPassword.text == ""
            {
                SMLGlobal.sharedInstance.displayAlertMessage(self, "Password field is mandatory", title: "")
                return false
            }
            else
            {
                let cou = textPassword.text?.characters.count
                if cou! <= 4 {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, "The New Password field must be at least 5 characters", title: "")
                    return false
                }
            }
            if textConfirmPassword.text == ""
            {
                SMLGlobal.sharedInstance.displayAlertMessage(self, "Re-Password field is mandatory", title: "")
                return false
            }
            else
            {
                let cou1 = textConfirmPassword.text?.characters.count
                if cou1! <= 4
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, "Re-Password field must be at least 5 characters", title: "")
                }
            return false
            }
    }
    
    func regVal() {
        
            let str =  textFirstName.text! as NSString
            let str1 = textLastName.text! as NSString
            let str2 = textUserName.text! as NSString
            let str3 = textEmail.text! as NSString
            let str4 = textCity.text! as NSString
            let str5 = textGender.text! as NSString
            let d = 32 as unichar
            if (textFirstName.text?.characters.count)! >= 2
            {
                if str == ""
                {
                    firstBlnkValue = 0
                    //println("Sk Rejabul")
                }
                else
                {
                    let c:unichar = str.character(at: 0);
                    //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                    if c == d {
                        firstBlnkValue = 1
                        
                    } else {
                        firstBlnkValue = 0
                    }
                }
            }
            if textFirstName.text?.characters.count == 1 {
                let c:unichar = str.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue = 1
                    
                } else {
                    firstBlnkValue = 0
                }
            }
            if (textLastName.text?.characters.count)! >= 2 {
            
            if str1 == "" {
                firstBlnkValue1 = 0
                
                //println("Sk Rejabul")
            } else {
                let c:unichar = str1.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue1 = 1
                    
                } else {
                    firstBlnkValue1 = 0
                }
            }
        }
        
        if textLastName.text?.characters.count == 1 {
            let c:unichar = str1.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue1 = 1
                
            } else {
                firstBlnkValue1 = 0
            }
        }
        if (textUserName.text?.characters.count)! >= 2 {
            if str == "" {
                firstBlnkValue2 = 0
                
                //println("Sk Rejabul")
            } else {
                let c:unichar = str2.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue2 = 1
                    
                } else {
                    firstBlnkValue2 = 0
                }
            }
        }
        
        if textUserName.text?.characters.count == 1 {
            let c:unichar = str2.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue2 = 1
                
            } else {
                firstBlnkValue2 = 0
            }
        }
        if (textEmail.text?.characters.count)! >= 2 {
            if str == "" {
                firstBlnkValue3 = 0
                
                //println("Sk Rejabul")
            } else {
                let c:unichar = str3.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue3 = 1
                    
                } else {
                    firstBlnkValue3 = 0
                }
            }
        }
        
        if textEmail.text?.characters.count == 1 {
            let c:unichar = str3.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue3 = 1
                
            } else {
                firstBlnkValue3 = 0
            }
        }
        if (textGender.text?.characters.count)! >= 2 {
            
            if str == "" {
                firstBlnkValue7 = 0
                
                //println("Sk Rejabul")
            } else {
                // var value = str4.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str5.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue7 = 1
                    
                } else {
                    firstBlnkValue7 = 0
                }
            }
        }

        if (textCity.text?.characters.count)! >= 2 {
            
            if str == "" {
                firstBlnkValue4 = 0
                
                //println("Sk Rejabul")
            } else {
               // var value = str4.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str4.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue4 = 1
                    
                } else {
                    firstBlnkValue4 = 0
                }
            }
        }
        
        if textCity.text?.characters.count == 1 {
            
            let c:unichar = str4.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue4 = 1
            } else {
                firstBlnkValue4 = 0
            }
        }
        }
    
    //MARK: Keyboard Delegate Methods
    func keyboardWillShow()
    {
        if !isKeyboardShow
        {
            isKeyboardShow = true
        if ScreenSize.height >= 667
        {
            scrollView.contentSize = CGSize.init(width: scrollView.frame.size.width, height: scrollView.frame.size.height + 200)
        }
        else
        {
            scrollView.contentSize = CGSize.init(width: scrollView.frame.size.width, height: scrollView.contentSize.height + 200)
        }
        }
    }
    func keyboardWillHide()
    {
        if isKeyboardShow == true
        {
        isKeyboardShow = false
        if ScreenSize.height >= 667
        {
            scrollView.contentSize = CGSize.init(width: scrollView.frame.size.width, height: backgroundScrollView.frame.size.height - 200)
        }
        else
        {
            scrollView.contentSize = CGSize.init(width: scrollView.frame.size.width, height: scrollView.contentSize.height - 200)
        }
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
        if (touch.view?.isDescendant(of: genderTableView))!
        {
            return false
        }
        return true
    }

    
}
