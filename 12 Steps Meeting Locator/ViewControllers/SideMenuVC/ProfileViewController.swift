//
//  ProfileViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 09/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit



class ProfileViewController: UIViewController,UITextFieldDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var firstNameTextField : UITextField!
    var lastNameTextField : UITextField!
    var userNameTextField : UITextField!
    var emailTextField : UITextField!
    var firstBlnkValue = 0
     var firstBlnkValue1 = 0
     var firstBlnkValue2 = 0
     var firstBlnkValue3 = 0
     var firstBlnkValue4 = 0
    //var genderTextField : UITextField!
    var cityTextField : UITextField!
   // var dobTextField : UITextField!
    var backgroundScrollView : UIScrollView!
    var datePickerView : UIView!
    var datePicker : UIDatePicker!
    var genderTableView : UITableView!
    var profileImgView : UIImageView!
    var base64String = NSString()
    var editBtn : (UIButton) = UIButton.init(type: UIButtonType.custom)
    var dateSelectedStr : (NSString) = NSString()
    
    
    var selectedDob : (UILabel)!
    var probationNameTextField : (UITextField)!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       self.navigationController?.isNavigationBarHidden = true
       self.createUI()
        

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillShow:", name: UIKeyboardDidShowNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "KeyboardWillHide:", name: UIKeyboardDidHideNotification, object: nil)
    }
    
    
//    func KeyboardWillShow(note :NSNotification)
//    {
//        if ScreenSize.height == 480 {
//            
//        } else {
//             backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.contentSize.width, backgroundScrollView.contentSize.height+230)
//        }
//     
//    }
//    
//    
//    func KeyboardWillHide(note :NSNotification)
//    {
//        if ScreenSize.height == 480 {
//            
//        } else {
//            backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.contentSize.width, backgroundScrollView.contentSize.height-230)
//        }
//    }
//    
//    
    
    func createUI()
    {
        
        let  appUser : (SMLAppUser) = SMLAppUser.getUser()
        self.view.backgroundColor = UIColor.white
        //CustomView
        let customView =  UIView()
        customView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        customView.backgroundColor = UIColor(red: 0/255.0, green:135/255, blue: 206/255, alpha: 1.0)
        self.view.addSubview(customView)
        //navigationView
        let navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 25, width: ScreenSize.width, height: 44)
        navigationView.backgroundColor = UIColor(red: 51.0/255.0, green: 188.0/255.0, blue: 250.0/255.0, alpha:1.0)
        customView.addSubview(navigationView)
        
        //Profile Title
        let titleLabel = UILabel()
        titleLabel.text = "Profile"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.frame = CGRect(x: 30, y: (navigationView.frame.size.height-30)/2, width: navigationView.frame.size.width - 60, height: 30)
        titleLabel.textColor = UIColor.white
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(13)
        navigationView.addSubview(titleLabel)
        
        //backBtn
        let backBtn :(UIButton) = UIButton.init(type: UIButtonType.custom)
        backBtn.frame = CGRect(x: 5, y: (navigationView.frame.size.height-40)/2, width: 40, height: 40)
        backBtn.addTarget(self, action: #selector(ProfileViewController.backBtnAction(_:)), for: UIControlEvents.touchUpInside)
        backBtn.setImage(UIImage(named: "home"), for: UIControlState())
        navigationView.addSubview(backBtn)
        
        backgroundScrollView = UIScrollView()
        backgroundScrollView.frame = CGRect(x: 0, y: navigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - navigationView.frame.maxY)
        backgroundScrollView.isScrollEnabled = true
        self.view.addSubview(backgroundScrollView)
        
        let profilebackView = UIView()
        profilebackView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 120)
        profilebackView.backgroundColor =  UIColor(red: 0/255.0, green:135/255, blue: 206/255, alpha: 1.0)
        backgroundScrollView.addSubview(profilebackView)
        
        //ProfileImageView
        profileImgView = UIImageView()
        let profileStr : (NSString) = appUser.profilePic
        if profileStr == ""
        {
            profileImgView.image = UIImage(named: "noImageAvailable")
        }
        else
        {

            let profileUrl : (URL) = URL(string: NSString(format: "%@", profileStr) as String)!
            profileImgView.sd_setImage(with: profileUrl)

        }
        profileImgView.frame = CGRect(x: (ScreenSize.width-70)/2, y: 5, width: 70, height: 70)
        profileImgView.clipsToBounds = true
       // profileImgView.backgroundColor = UIColor.grayColor()
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width/2
        profileImgView.isUserInteractionEnabled = false
        profilebackView.addSubview(profileImgView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.profileGesture(_:)))
        profileImgView.addGestureRecognizer(tapGesture)
        //UserName
        let userName  = UILabel()
        let userNameStr : (NSString) =  "\(appUser.firstName)  \(appUser.lastName)" as (NSString)
        //println(userNameStr)
        userName.text = userNameStr as String
        userName.textAlignment = NSTextAlignment.center
        userName.frame = CGRect(x: 0, y: profileImgView.frame.maxY+5, width: customView.frame.size.width, height: 20)
        userName.font = SMLGlobal.sharedInstance.fontSize(15)
        userName.textColor = UIColor.white
        profilebackView.addSubview(userName)
        
        //Email
        let email  = UILabel()
        email.text = appUser.email as String
        email.textAlignment = NSTextAlignment.center
        email.frame = CGRect(x: 0, y: userName.frame.maxY+3, width: customView.frame.size.width, height: 15)
        email.font = SMLGlobal.sharedInstance.fontSize(12)
        email.textColor = UIColor.white
        profilebackView.addSubview(email)
        
        //ScrollView
        //Firstname Label
        let firstNameLabel  = UILabel()
        firstNameLabel.text = "First Name"
        firstNameLabel.textAlignment = NSTextAlignment.left
        firstNameLabel.frame = CGRect(x: 10, y: profilebackView.frame.maxY+10,width: 70, height: 30)
        firstNameLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        firstNameLabel.textColor = UIColor.black
        backgroundScrollView.addSubview(firstNameLabel)
        
        //First name TextField
        firstNameTextField = UITextField()
        firstNameTextField.textColor = UIColor.gray
        firstNameTextField.frame = CGRect(x: firstNameLabel.frame.maxX + 10,y: firstNameLabel.frame.origin.y, width: ScreenSize.width - (firstNameLabel.frame.maxX + 20), height: 30)
        firstNameTextField.font = SMLGlobal.sharedInstance.fontSize(13)
        firstNameTextField.textAlignment = NSTextAlignment.right
        firstNameTextField.delegate = self
        firstNameTextField.tag = 1
        firstNameTextField.isEnabled = false
        firstNameTextField.text = appUser.firstName as String
        firstNameTextField.keyboardType = UIKeyboardType.emailAddress
        firstNameTextField.returnKeyType = UIReturnKeyType.next
        firstNameTextField.autocorrectionType = UITextAutocorrectionType.no
        firstNameTextField.leftViewMode = UITextFieldViewMode.always;
        firstNameTextField.backgroundColor = UIColor.white;
        //firstNameTextField.borderStyle = UITextBorderStyle.RoundedRect;
        backgroundScrollView.addSubview(firstNameTextField)
        
        let lastNameView = UIView()
        lastNameView.frame = CGRect(x: 0, y: firstNameLabel.frame.maxY+10, width: ScreenSize.width, height: 30)
        lastNameView.backgroundColor = UIColor(red: 239.0/255.0, green: 253.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        backgroundScrollView.addSubview(lastNameView)
        
        //Last name Label
        let lastNameLabel  = UILabel()
        lastNameLabel.text = "Last Name"
        lastNameLabel.textAlignment = NSTextAlignment.left
        lastNameLabel.frame = CGRect(x: 10, y: 0, width: 70, height: 30)
        lastNameLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        lastNameLabel.textColor = UIColor.black
        lastNameView.addSubview(lastNameLabel)
        //Last name TextField
        lastNameTextField = UITextField()
        lastNameTextField.textColor = UIColor.gray
        lastNameTextField.frame = CGRect(x: lastNameLabel.frame.maxX + 10, y: lastNameLabel.frame.origin.y, width: ScreenSize.width - (lastNameLabel.frame.maxX + 20) , height: 30)
        lastNameTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        lastNameTextField.textAlignment = NSTextAlignment.right
        lastNameTextField.delegate = self
        lastNameTextField.tag = 2
        lastNameTextField.text = appUser.lastName as String
        lastNameTextField.isEnabled = false
        //        var FirstPlaceholder = NSAttributedString(string: "E-mail Address", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : textFont])
        //firstNameTextField.attributedPlaceholder = FirstPlaceholder;
        lastNameTextField.keyboardType = UIKeyboardType.emailAddress
        lastNameTextField.returnKeyType = UIReturnKeyType.next
        lastNameTextField.autocorrectionType = UITextAutocorrectionType.no
        lastNameTextField.leftViewMode = UITextFieldViewMode.always;
        lastNameTextField.backgroundColor = UIColor.clear;
        //lastNameTextField.borderStyle = UITextBorderStyle.RoundedRect;
        lastNameView.addSubview(lastNameTextField)

        //Last name Label
        let userNameLabel  = UILabel()
        userNameLabel.text = "User Name"
        userNameLabel.textAlignment = NSTextAlignment.left
        userNameLabel.frame = CGRect(x: 10, y: lastNameView.frame.maxY+10, width: 70, height: 30)
        userNameLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        userNameLabel.textColor = UIColor.black
        backgroundScrollView.addSubview(userNameLabel)
        //Last name TextField
        userNameTextField = UITextField()
        userNameTextField.textColor = UIColor.gray
        userNameTextField.frame = CGRect(x: userNameLabel.frame.maxX + 10, y: userNameLabel.frame.origin.y, width: ScreenSize.width - (userNameLabel.frame.maxX + 20) , height: 30)
        //emailTextField.placeholder = "E-mail Address"
        userNameTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        userNameTextField.textAlignment = NSTextAlignment.right
        userNameTextField.delegate = self
        userNameTextField.tag = 3
        userNameTextField.text = appUser.userName as String
        userNameTextField.isEnabled = false
        //        var FirstPlaceholder = NSAttributedString(string: "E-mail Address", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : textFont])
        //firstNameTextField.attributedPlaceholder = FirstPlaceholder;
        userNameTextField.keyboardType = UIKeyboardType.emailAddress
        userNameTextField.returnKeyType = UIReturnKeyType.next
        userNameTextField.autocorrectionType = UITextAutocorrectionType.no
        userNameTextField.leftViewMode = UITextFieldViewMode.always;
        userNameTextField.backgroundColor = UIColor.white;
        //userNameTextField.borderStyle = UITextBorderStyle.RoundedRect;
        backgroundScrollView.addSubview(userNameTextField)
        
        
        let emailView = UIView()
        emailView.frame = CGRect(x: 0, y: userNameTextField.frame.maxY+10, width: ScreenSize.width, height: 30)
        emailView.backgroundColor = UIColor(red: 239.0/255.0, green: 253.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        backgroundScrollView.addSubview(emailView)
        
        //Last name Label
        let emailLabel  = UILabel()
        emailLabel.text = "E-mail"
        emailLabel.textAlignment = NSTextAlignment.left
        emailLabel.frame = CGRect(x: 10, y: 0,width: 70, height: 30)
        emailLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        emailLabel.textColor = UIColor.black
        emailView.addSubview(emailLabel)
        
        //Last name TextField
        emailTextField = UITextField()
        emailTextField.textColor = UIColor.gray
        emailTextField.frame = CGRect(x: ScreenSize.width/2 , y: emailLabel.frame.origin.y, width: ScreenSize.width/2 - 10 , height: 30)
        //emailTextField.placeholder = "E-mail Address"
        emailTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        emailTextField.textAlignment = NSTextAlignment.right
        emailTextField.delegate = self
        emailTextField.tag = 4
        emailTextField.text = appUser.email as String
        emailTextField.isEnabled = false
        //        var FirstPlaceholder = NSAttributedString(string: "E-mail Address", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : textFont])
        //firstNameTextField.attributedPlaceholder = FirstPlaceholder;
        emailTextField.keyboardType = UIKeyboardType.emailAddress
        emailTextField.returnKeyType = UIReturnKeyType.next
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        emailTextField.leftViewMode = UITextFieldViewMode.always;
        emailTextField.backgroundColor = UIColor.clear;
        //userNameTextField.borderStyle = UITextBorderStyle.RoundedRect;
        emailView.addSubview(emailTextField)
        
        let genderLabel  = UILabel()
        genderLabel.text = "Parole Officer Name"
        genderLabel.textAlignment = NSTextAlignment.left
        genderLabel.frame = CGRect(x: 10, y: emailView.frame.maxY+10, width: ScreenSize.width/2-10, height: 30)
        genderLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        genderLabel.textColor = UIColor.black
        backgroundScrollView.addSubview(genderLabel)
        
    
        
        
        //GenderTextField
//        genderTextField = UITextField()
//        genderTextField.textColor = UIColor.grayColor()
//        genderTextField.frame = CGRectMake(CGRectGetMaxX(genderLabel.frame) + 10, genderLabel.frame.origin.y, ScreenSize.width - (CGRectGetMaxX(genderLabel.frame) + 20) , 30)
//        //emailTextField.placeholder = "E-mail Address"
//        genderTextField.font = SMLGlobal.sharedInstance.fontSize(12)
//        genderTextField.textAlignment = NSTextAlignment.Right
//        genderTextField.delegate = self
//        genderTextField.tag = 5
//        genderTextField.text = appUser.gender as String
//        genderTextField.enabled = false
//        //        var FirstPlaceholder = NSAttributedString(string: "E-mail Address", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : textFont])
//        //firstNameTextField.attributedPlaceholder = FirstPlaceholder;
//        genderTextField.keyboardType = UIKeyboardType.EmailAddress
//        genderTextField.returnKeyType = UIReturnKeyType.Done
//        genderTextField.autocorrectionType = UITextAutocorrectionType.No
//        genderTextField.leftViewMode = UITextFieldViewMode.Always;
//        genderTextField.backgroundColor = UIColor.whiteColor();
        //userNameTextField.borderStyle = UITextBorderStyle.RoundedRect;
       // backgroundScrollView.addSubview(genderTextField)
        
        
        probationNameTextField = UITextField()
        probationNameTextField.delegate = self;
        probationNameTextField.textAlignment = NSTextAlignment.right
        probationNameTextField.frame = CGRect(x: ScreenSize.width/2, y: genderLabel.frame.origin.y, width: ScreenSize.width/2 - 10, height: 30)
        probationNameTextField.tag = 5
        probationNameTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        probationNameTextField.textColor = UIColor.gray
        probationNameTextField.isUserInteractionEnabled = false
        probationNameTextField.backgroundColor = UIColor.clear
        backgroundScrollView.addSubview(probationNameTextField)
        probationNameTextField.placeholder = "N/A"

        let cityValue =  appUser.probationName as String
            probationNameTextField.text = cityValue
        
        

   
        let cityView = UIView()
        cityView.frame = CGRect(x: 0, y: probationNameTextField.frame.maxY+10, width: ScreenSize.width, height: 30)
        cityView.backgroundColor = UIColor(red: 239.0/255.0, green: 253.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        backgroundScrollView.addSubview(cityView)
        let cityLabel  = UILabel()
        cityLabel.text = "Parole Officer Email"
        cityLabel.textAlignment = NSTextAlignment.left
        cityLabel.frame = CGRect(x: 10, y: 0, width: ScreenSize.width/2-10, height: 30)
        cityLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        cityLabel.textColor = UIColor.black
        cityView.addSubview(cityLabel)
        
        //GenderTextField
        cityTextField = UITextField()
        cityTextField.textColor = UIColor.gray
        
        
        
        cityTextField.frame = CGRect(x:ScreenSize.width/2, y: cityLabel.frame.origin.y, width: ScreenSize.width/2 - 10 , height: 30)
        //emailTextField.placeholder = "E-mail Address"
        cityTextField.font = SMLGlobal.sharedInstance.fontSize(12)
       
        cityTextField.textAlignment = NSTextAlignment.right
        cityTextField.delegate = self
        cityTextField.tag = 6
        cityTextField.placeholder = "N/A"

        let cityVa =  appUser.probationEmail as NSString
          cityTextField.text = cityVa as String
        
        cityTextField.isEnabled = false
        //        var FirstPlaceholder = NSAttributedString(string: "E-mail Address", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : textFont])
        //firstNameTextField.attributedPlaceholder = FirstPlaceholder;
        cityTextField.keyboardType = UIKeyboardType.emailAddress
        cityTextField.returnKeyType = UIReturnKeyType.done
        cityTextField.autocorrectionType = UITextAutocorrectionType.no
        cityTextField.leftViewMode = UITextFieldViewMode.always;
        cityTextField.backgroundColor = UIColor.clear;
        //userNameTextField.borderStyle = UITextBorderStyle.RoundedRect;
        cityView.addSubview(cityTextField)

        let dobLabel  = UILabel()
        dobLabel.text = "Date of Birth"
        dobLabel.textAlignment = NSTextAlignment.left
        dobLabel.frame = CGRect(x: 10, y: cityView.frame.maxY+10, width: 100, height: 30)
        dobLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        dobLabel.textColor = UIColor.black
        backgroundScrollView.addSubview(dobLabel)
        
        selectedDob = UILabel()
        selectedDob.frame =  CGRect(x: dobLabel.frame.maxX + 10, y: dobLabel.frame.origin.y, width: ScreenSize.width - (dobLabel.frame.maxX + 20) , height: 30)
        selectedDob.isUserInteractionEnabled = false
        selectedDob.backgroundColor = UIColor.white
        selectedDob.font = SMLGlobal.sharedInstance.fontSize(12)
        selectedDob.textColor = UIColor.gray
        selectedDob.textAlignment = NSTextAlignment.right
        backgroundScrollView.addSubview(selectedDob)
        
        let DobGesture : (UITapGestureRecognizer) = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.DobGesture(_:)))
        selectedDob.addGestureRecognizer(DobGesture)
        let dateStr : (NSString) = appUser.dob as String as String as (NSString)
        if(dateStr == "")
        {
            selectedDob.text = "0000-00-00"
        }
        else
        {
            let DF = DateFormatter()
            DF.dateFormat = "yyyy-MM-dd"
            let date =  DF.date(from: dateStr as String)
            dateSelectedStr = dateStr
            if(date == nil)
            {
               selectedDob.text = "0000-00-00"
            }
            else
            {
                DF.dateFormat = "dd-MMM-yyyy"
                let selectedDateStr : (NSString) = DF.string(from: date!) as (NSString)
                selectedDob.text = selectedDateStr as String;
            }
        }
        
        let btn_X : CGFloat = (ScreenSize.width - 210)/2
        editBtn.addTarget(self, action: #selector(ProfileViewController.EditBtnAction(_:)), for:  .touchUpInside)
        editBtn.backgroundColor = UIColor(red: 0.0/255.0, green: 87.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        editBtn.setTitle("Edit", for: UIControlState())
        editBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        editBtn.layer.cornerRadius = 2.0
       // editBtn.setImage(UIImage(named: "edit_button"), forState: UIControlState.Normal)
        editBtn.frame = CGRect(x: btn_X, y: selectedDob.frame.maxY+20, width: 100 , height: 35)
        backgroundScrollView.addSubview(editBtn)
        
        let cancelBtn : (UIButton) = UIButton.init(type: UIButtonType.custom)
        cancelBtn.backgroundColor = UIColor(red: 246.0/255.0, green: 79.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        cancelBtn.setTitle("Cancel", for: UIControlState())
        cancelBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
          cancelBtn.layer.cornerRadius = 2.0
        //cancelBtn.setImage(UIImage(named: "cancel"), forState: UIControlState.Normal)
        cancelBtn.addTarget(self, action: #selector(ProfileViewController.CancelBtnAction(_:)), for:  .touchUpInside)
        cancelBtn.frame = CGRect(x: editBtn.frame.maxX + 10, y: selectedDob.frame.maxY+20, width: 100 , height: 35)
        backgroundScrollView.addSubview(cancelBtn)
        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width, height: cancelBtn.frame.maxY+10)
        backgroundScrollView.bounces = false
        
        datePickerView = UIView()
        datePickerView.frame = CGRect(x: 0, y: self.view.frame.size.height - 250, width: ScreenSize.width, height: 250)
        datePickerView.backgroundColor = UIColor.white
        let doneBtn : UIButton!
        doneBtn = UIButton.init(type: UIButtonType.custom)
        doneBtn .setTitleColor(UIColor.black, for: UIControlState())
        doneBtn.setTitle("Done", for: UIControlState())
        doneBtn.frame = CGRect(x: 10, y: 5 , width: 50, height: 30)
        doneBtn .addTarget(self, action: #selector(ProfileViewController.PickerDoneBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(doneBtn)
        
        var CancelBtn : UIButton!
        CancelBtn = UIButton.init(type: UIButtonType.custom)
        CancelBtn.setTitle("Cancel", for: UIControlState())
        CancelBtn .setTitleColor(UIColor.black, for: UIControlState())
        CancelBtn.frame = CGRect(x: datePickerView.frame.size.width - 80 ,y: 5, width: 70, height: 30)
        CancelBtn .addTarget(self, action: #selector(ProfileViewController.PickerCancelBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(CancelBtn)
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: 50, width: ScreenSize.width, height: 200)
        datePicker.datePickerMode = UIDatePickerMode.date
        datePickerView.addSubview(datePicker)
        
        self.genderTableView = UITableView(frame:CGRect(x: probationNameTextField.frame.maxX - 100, y: probationNameTextField.frame.maxY ,width: 100 ,height: 90))
        genderTableView.layer.borderColor = UIColor.black.cgColor
        genderTableView.layer.borderWidth = 1.0
        genderTableView.layer.cornerRadius = 5.0
        self.genderTableView.dataSource = self
        self.genderTableView.delegate = self
        self.genderTableView.layer.cornerRadius = 4.0
        
    }
    //MARK:-  Actions
    func GenderGesture(_ gesture : UITapGestureRecognizer)
    {
        self.resignAllTextFields()
        backgroundScrollView.addSubview(self.genderTableView)
    }
    func DobGesture(_ gesture : UITapGestureRecognizer)
    {
        if ScreenSize.height >= 667 {
            backgroundScrollView.contentOffset = CGPoint(x: backgroundScrollView.frame.origin.x, y: backgroundScrollView.frame.origin.y + 50)
            backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.frame.size.height+110)
        } else {
            backgroundScrollView.contentOffset = CGPoint(x: backgroundScrollView.frame.origin.x, y: backgroundScrollView.frame.origin.y + 180)
            backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.frame.size.height+230)
        }
        self.resignAllTextFields()
        self.view.addSubview(datePickerView)
    }
    
    func resignAllTextFields()
    {
        emailTextField.resignFirstResponder()
        firstNameTextField.resignFirstResponder()
        lastNameTextField.resignFirstResponder()
        userNameTextField.resignFirstResponder()
        datePickerView.removeFromSuperview()
        genderTableView.removeFromSuperview()
        cityTextField.resignFirstResponder()
        probationNameTextField.resignFirstResponder()
        
    }
    func EditBtnAction(_ sender:UIButton)
    {
        backgroundScrollView.contentOffset = CGPoint(x: 0, y: 0)
            if(sender.title(for: UIControlState()) == "Edit")
            {
                sender.setTitle("Save", for:  UIControlState())
                self.allTextFieldsEnable()
            }
            else
            {
                sender.setTitle("Edit", for:  UIControlState())
                self.allTextFieldsDisable()
                profVal()
                if(self.checkTextField())
                {
                self.saveProfileAction()
                }
                else {
                    sender.setTitle("Save", for:  UIControlState())
                    self.allTextFieldsEnable()
                }
            }
    }
    func saveProfileAction()
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        datePickerView.removeFromSuperview()
        SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        let userData :(SMLAppUser) = SMLAppUser.getUser()
        var PImage : (UIImage) = UIImage()
       // PImage = profileImgView.image!
        if(profileImgView.image == UIImage(named:""))
        {
          // PImage = profileImgView.image!
            base64String = ""
        }
        else
        {
          PImage = profileImgView.image!
            let imageData = UIImageJPEGRepresentation(PImage, 1.0)
            base64String = (imageData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters))! as String as NSString
        }
        let gender :(NSString) = probationNameTextField.text! as (NSString)
        //http://112.196.34.179/stepslocator/index.php/login/wseditprofile?user_id=&first_name=&last_name=&email=&city=&gender=&dob=&profile_pic=
        let parameters : (NSDictionary) = ["user_id" : userData.userId,
            "first_name" : firstNameTextField.text! as NSString,
            "last_name" : lastNameTextField.text! as NSString,
            "email" : emailTextField.text! as NSString,
            "probation_email" : cityTextField.text! as NSString,
            "probation_name"  : gender ,
            "dob" : dateSelectedStr,
            "profile_pic" : base64String]
        WebserviceManager.sharedInstance.editProfile(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let dict :(NSDictionary) = responseObject as! NSDictionary
                let string : (NSString) = dict.value(forKey: "message") as! NSString
                //Success 1
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if(success == 1)
                {
                    let userValues : NSDictionary = dict.object(forKey: "data") as! NSDictionary
                    SMLGlobal.sharedInstance.displayAlertMessage(self, string, title: "")
                    userData.userId = userValues.value(forKey: "user_id") as! NSString
                    //userData.userId = NSString(format: "%d", userValues.objectForKey("user_id") as! Int)
                    userData.probationName = userValues.value(forKey:"probation_name") as! NSString
                    userData.firstName = userValues.value(forKey: "first_name") as! NSString
                    userData.lastName = userValues.value(forKey: "last_name") as! NSString
                    //userData.userName = userValues.valueForKey("user_name")  as! NSString
                    userData.probationEmail = userValues.value(forKey: "probation_email") as! NSString
                    var profileStr : (NSString) = userValues.value(forKey: "profile_pic") as! NSString
                    profileStr =  profileImagesUrl.appending(profileStr as String) as (NSString)
                    userData.profilePic = profileStr
                    print(profileStr)
                    userData.dob = userValues.value(forKey: "dob") as! NSString
                    let paymentRole : (NSString) = userData.upgrade
                    userData.upgrade = paymentRole
                    let push : (NSString) = userData.pushNotification
                    userData.pushNotification = push
                    let email : (NSString) = userData.emailNotification
                    userData.emailNotification = email
                    SMLAppUser.saveUser(userData)
                    SVProgressHUD.dismiss()
                }
                else
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, string, title: "")
                    SVProgressHUD.dismiss()
                }
            }
            else
            {
                
            }
        }
        }
        else
        {
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }
    
    func checkTextField()->Bool
    {
        //let isEqual = (self.textPassword.text == self.textConfirmPassword.text)
        //        now isEqual is true.
        if(self.firstNameTextField.text == "" || firstBlnkValue == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "First Name field is mandatory", title: "")
            firstNameTextField.text = ""
            return false;
        }
        else if(self.lastNameTextField.text == "" || firstBlnkValue1 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Last Name field is mandatory", title: "")
            lastNameTextField.text = ""
            return false;
        }
        else if(self.userNameTextField.text == "" || firstBlnkValue2 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "User Name field is mandatory", title: "")
            userNameTextField.text = ""
            return false;
        }

        if ((probationNameTextField.text?.characters.count)! > 0)
        {
            let str4 = probationNameTextField.text! as NSString
            
            let d = 32 as unichar
            let c:unichar = str4.character(at: 0)
            if c == d
            {
                SMLGlobal.sharedInstance.displayAlertMessage(self, "Please Enter valid Probation Name", title: "")
                probationNameTextField.text = ""
                return false;
                
            }
        }

        else if (self.cityTextField.text != "")
        {
            if(!isValidEmail(cityTextField.text!))
            {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please Enter valid Probation Email", title: "")
            cityTextField.text = ""
            return false;
           }
        }
        else if firstBlnkValue3 == 1
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please Enter valid  Email", title: "")
            cityTextField.text = ""
            return false;
        }

        else if(self.selectedDob.text == "")
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please select Dob", title: "")
            return false;
        }
  
            return true
    }
    
    func isValidCity(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let cityCheck = "[A-Za-z  ]{1,20}"
        
        let cityTest = NSPredicate(format:"SELF MATCHES %@", cityCheck)
       // println(String(format: "%@", cityTest.evaluateWithObject(testStr)))
        return cityTest.evaluate(with: testStr)
    }
    func allTextFieldsEnable()
    {
        profileImgView.isUserInteractionEnabled = true
        firstNameTextField.isEnabled = true
        lastNameTextField.isEnabled = true
        userNameTextField.isEnabled = true
        probationNameTextField.isUserInteractionEnabled = true
        cityTextField.isEnabled = true
        selectedDob.isUserInteractionEnabled = true
    }
    
    func allTextFieldsDisable()
    {
        profileImgView.isUserInteractionEnabled = false
        firstNameTextField.isEnabled = false
        lastNameTextField.isEnabled = false
        userNameTextField.isEnabled = false
        probationNameTextField.isUserInteractionEnabled = false
        cityTextField.isEnabled = false
        selectedDob.isUserInteractionEnabled = false
        
    }
    func CancelBtnAction(_ sender:UIButton)
    {
//        
//        backgroundScrollView.contentOffset = CGPointMake(0, 50)
//        backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.frame.size.width, backgroundScrollView.contentSize.height - 10 )
        let user : (SMLAppUser) = SMLAppUser.getUser()
        if(editBtn.currentTitle == "Save")
        {
            if ScreenSize.height == 667 {
                backgroundScrollView.contentOffset = CGPoint(x: 0, y: 0)
                backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height-240)
            } else if ScreenSize.height == 480  {
                backgroundScrollView.contentOffset = CGPoint(x: 0, y: 50)
                backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height-10)
            } else {
                backgroundScrollView.contentOffset = CGPoint(x: 0, y: 0)
                backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height-240)
            }
            datePickerView.removeFromSuperview()
            editBtn.setTitle("Edit", for:  UIControlState())
            self.allTextFieldsDisable()
            
            firstNameTextField.text = user.firstName as String
            lastNameTextField.text = user.lastName as String
            userNameTextField.text = user.userName as String
            let gen = user.probationName as String
           

            emailTextField.text = user.email as String
            let cityValue =  user.probationEmail as String
            if cityValue == "" {
                cityTextField.placeholder = "probationEmail"
            } else {
                cityTextField.text = cityValue
            }
            var dateStr : (NSString) = user.dob as String as String as (NSString)
            if(dateStr == "")
            {
              dateStr = "0000-00-00"
                selectedDob.text = dateStr as String
            }
            else
            {
                let DF = DateFormatter()
                DF.dateFormat = "yyyy-MM-dd"
                let date =  DF.date(from: dateStr as String)
                
                if  dateStr == "0000-00-00" {
                } else {
                DF.dateFormat = "dd-MMM-yyyy"
                let selectedDateStr : (NSString) = DF.string(from: date!) as (NSString)
                selectedDob.text = selectedDateStr as String;
                }
            }
        }
        else
        {
            let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let view = FirstViewController(nibName: nil, bundle: nil)
            delegate.callMethod(view)
        }
    }
    
    func profileGesture(_ gesture : UITapGestureRecognizer)
    {
        let actionSheet = UIActionSheet(title: "", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Open Camera", otherButtonTitles: "Gallery")
        actionSheet.show(in: self.view)
    }
    
    func backBtnAction(_ sender:UIButton)
    {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
    }
    
    func PickerDoneBtnAction(_ sender:UIButton)
    {
        if ScreenSize.height == 480 {
             backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.frame.size.height+50)
        } else {
         backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.frame.size.height-230)
        }
        //backgroundScrollView.contentOffset = CGPointMake(0, 0)
        let pickerDate : (Date) = datePicker.date
        let currentDate = Date()
        if(pickerDate .compare(currentDate) == ComparisonResult.orderedAscending)
        {
//            var DF = NSDateFormatter()
//            DF.dateFormat = "yyyy-MM-dd hh:mm:ss"
//            var dateStr = DF.stringFromDate(pickerDate)
//            
//            
//            
//            
//            var selectedDate : (NSDate) = DF.dateFromString(dateStr)!
//            DF.dateFormat = "dd-MMM-yyyy"
//            var selectedDateStr : (NSString) = DF.stringFromDate(selectedDate)
//            dobTextField.text = selectedDateStr as String;
            
            
            
            
            
            let DF = DateFormatter()
            DF.dateFormat = "yyyy-MM-dd"
            dateSelectedStr =  DF.string(from: pickerDate) as (NSString)
            
            
            
            var selectedDate : (Date) = DF.date(from: dateSelectedStr as String)!
            DF.dateFormat = "dd-MMM-yyyy"
            var selectedDateStr : (NSString) = DF.string(from: selectedDate) as (NSString)
            selectedDob.text = selectedDateStr as String;
            
            datePickerView .removeFromSuperview()
        }
        else
        {
            var alertView = UIAlertView(title: "", message: "Future date can't be chosen as a Date of birth.", delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()
        }
    }
    func PickerCancelBtnAction(_ sender:UIButton)
    {
       
        //backgroundScrollView.contentOffset = CGPointMake(0, 0)
       
        if ScreenSize.height == 667 {
            backgroundScrollView.contentOffset = CGPoint(x: 0, y: 0)
             backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height-240)
        } else if ScreenSize.height == 480  {
            backgroundScrollView.contentOffset = CGPoint(x: 0, y: 50)
            backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height-140)
        } else {
            backgroundScrollView.contentOffset = CGPoint(x: 0, y: 0)
             backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.contentSize.width, height: backgroundScrollView.contentSize.height-240)
        }
        datePickerView.removeFromSuperview()
    }
    
    
    //MARK:- Table View Delaget Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellIdentifier : (NSString) = "Cell Identifier"
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier as String)
            cell?.textLabel?.textColor = UIColor.black
            cell?.textLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
            
        }
        
        if((indexPath as NSIndexPath).row == 0)
        {
            cell?.textLabel?.text = "Male"
        }
        else
        {
            cell?.textLabel?.text = "Female"
        }
        
        return cell!
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.genderTableView.removeFromSuperview()
        if((indexPath as NSIndexPath).row == 0)
        {
          probationNameTextField.text = "Male"
        }
        else
        {
           probationNameTextField.text = "Female"
        }
        
    }
    //MARK:- TextField Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        datePickerView.removeFromSuperview()
        genderTableView.removeFromSuperview()
        
        let tagValue : CGFloat =  CGFloat(textField.tag)
        print(tagValue)
        if(tagValue > 1)
        {
            if ScreenSize.height == 480 {
            backgroundScrollView.contentOffset = CGPoint(x: backgroundScrollView.frame.origin.x,y: 50 * tagValue)
            } else {
                 backgroundScrollView.contentOffset = CGPoint(x: backgroundScrollView.frame.origin.x,y: 25 * tagValue)
            }
        }
        
        

    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
        
      
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var tagValue : CGFloat =  CGFloat(textField.tag)
//        if(tagValue > 1)
//        {
//            if ScreenSize.height == 480 {
//                backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.frame.origin.x, backgroundScrollView.contentSize.height - (50 * tagValue))
//            } else {
//                 backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.frame.origin.x, backgroundScrollView.contentSize.height - (20 * tagValue))
//            }
        //}

         if ScreenSize.height == 480 {
        backgroundScrollView.contentOffset = CGPoint(x: 0,y: 50)
         } else if ScreenSize.height == 667 {
            backgroundScrollView.contentOffset = CGPoint(x: 0,y: 0)
         } else {
            backgroundScrollView.contentOffset = CGPoint(x: 0,y: 0)
        }
        self.resignAllTextFields()
        if textField == firstNameTextField
        {
            lastNameTextField.becomeFirstResponder()
        }
        else if textField == lastNameTextField
        {
            userNameTextField.becomeFirstResponder()
        }
        else if textField == userNameTextField
        {
            emailTextField.becomeFirstResponder()
        }
        else if textField == emailTextField
        {
            cityTextField.becomeFirstResponder()
        }
        else if textField == probationNameTextField
        {
            probationNameTextField.becomeFirstResponder()
        }
        else
        {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //var countText : (Int) = count(textField.text)
       
            var countText : (Int) = textField.text!.characters.count
            if(range.location == countText && string == " ")
            {
                textField.text = textField.text? .appending("\u{00a0}")
//                textField.text = textField.text .stringByAppendingString("\u{00a0}")
                var hel = textField.text
               
            }
        
        return true
    }

    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        
         let imagePicker = UIImagePickerController()

        if(buttonIndex == 0)
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                
                
                
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
                //println("Camera")
                
                self.present(imagePicker, animated: true, completion: nil)
            
            }
            else
            {
                 UIAlertView(title: "", message: "Camera not available", delegate: nil, cancelButtonTitle: "Ok", otherButtonTitles:"").show()
            }

           //println("0")
        }
        //Cancel
        else if (buttonIndex == 1)
        {
          //println("1")
        }
            //Gallery
        else if(buttonIndex == 2)
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum)
            {
                            imagePicker.delegate = self
                            imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
                            imagePicker.allowsEditing = false
    
                            self.present(imagePicker, animated: true, completion: nil)
          // println("1")
        }
        }
    }
    
   
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        
         profileImgView.image = image
        self.dismiss(animated: true, completion:nil)
    }
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        //println(String(format: "%@", emailTest.evaluateWithObject(testStr)))
        return emailTest.evaluate(with: testStr)
    }
    func profVal() {
        var  textField: UITextField!
        var str = firstNameTextField.text! as NSString
        var str1 = lastNameTextField.text! as NSString
        var str2 = userNameTextField.text! as NSString
        var str3 = cityTextField.text!     as NSString
     
        var d = 32 as unichar
        var e = 160 as unichar
        if (firstNameTextField.text?.characters.count)! >= 2 {
            if str == ""
            {
                firstBlnkValue = 0
                //println("Sk Rejabul")
            } else {
                var value = str.substring(with: NSRange(location: 0, length: 1))
                var c  : unichar = str.character(at: 0)
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d  || c == e{
                    firstBlnkValue = 1
                    
                } else {
                    firstBlnkValue = 0
                }
            }
        }
        
        if firstNameTextField.text?.characters.count == 1 {
            
            var c:unichar = str.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d  || c == e {
                firstBlnkValue = 1
                
            } else {
                firstBlnkValue = 0
                
            }
        }
        if (lastNameTextField.text?.characters.count)! > 2 {
            
            if str1 == "" {
                firstBlnkValue1 = 0
                
                //println("Sk Rejabul")
            } else {
                var c:unichar = str1.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d  || c == e {
                    firstBlnkValue1 = 1
                    
                } else {
                    firstBlnkValue1 = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if lastNameTextField.text?.characters.count == 1 {
            
            var c:unichar = str1.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d  || c == e {
                firstBlnkValue1 = 1
                
            } else {
                firstBlnkValue1 = 0
                
            }
        }
        if (userNameTextField.text?.characters.count)! > 2 {
            
            if str == "" {
                firstBlnkValue2 = 0
                
                //println("Sk Rejabul")
            } else {
                var value = str2.substring(with: NSRange(location: 0, length: 1))
                var c:unichar = str2.character(at: 0);
                if c == d  || c == e{
                    firstBlnkValue2 = 1
                    
                } else {
                    firstBlnkValue2 = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if userNameTextField.text?.characters.count == 1 {
            
            var c:unichar = str2.character(at: 0);
            if c == d  || c == e{
                firstBlnkValue2 = 1
                
            } else {
                firstBlnkValue2 = 0
                
            }
        }
//        if (cityTextField.text?.characters.count)! > 2 {
//            
//            if str == "" {
//                firstBlnkValue3 = 0
//                
//                //println("Sk Rejabul")
//            } else {
//                var value = str3.substring(with: NSRange(location: 0, length: 1))
//                var c:unichar = str3.character(at: 0);
//                if c == d  || c == e{
//                    firstBlnkValue3 = 1
//                    
//                } else {
//                    firstBlnkValue3 = 0
//                }
//                
//                // println("Sk Rejabul")
//            }
//        }
        

        
    }
    

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
