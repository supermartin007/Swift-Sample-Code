//
//  contactViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 24/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

var firstNameEdit = UILabel()
var secondNameEdit = UILabel()
var countryCode = UILabel()
var phoneNumber = UILabel()


class contactViewController: UIViewController, UITextFieldDelegate,ABPeoplePickerNavigationControllerDelegate,UIAlertViewDelegate {
    
    var backView : UIView = UIView()
    var scrollView : UIScrollView = UIScrollView()
    var navView: UIView = UIView()
    var NTextField : UITextField = UITextField()
    var fTextField : UITextField = UITextField()
    var lTextField : UITextField = UITextField()
    var cNTextField : UITextField = UITextField()
    var importButtopn : UIButton!
    var firstBlnkValue = 0
     var firstBlnkValue1 = 0
    var editDict = NSDictionary()

    override func viewDidLoad() {
        
       // println(editDict)
        super.viewDidLoad()
        /* Hide navugation Bar*/
        self.navigationController!.isNavigationBarHidden = true
        
        
        
        /* Hide navugation Back Button*/
        
        self.navigationItem.hidesBackButton = true
        
        /* Navigation Bar View*/
        //var nheight =  navigationController?.navigationBar.frame.height + 20
        navView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        navView.backgroundColor = UIColor(red: 0 / 255.0, green:135.0 / 255, blue: 206.0 / 255, alpha: 1.0)
        self.view.addSubview(navView)
        
        scrollView.frame = CGRect(x: 0, y: navView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height)
        scrollView.backgroundColor = UIColor.white
        self.view.addSubview(scrollView)
        
        let navHeight = navView.frame.height
        let navMid = navHeight / 2 - 15
        
        /* Home Button*/
        
        let leftButton: UIButton = UIButton()
        leftButton.frame = CGRect(x: 20, y: navMid + 13, width: 20, height: 20)
        let img = UIImage(named: "back_errow")
        leftButton.setBackgroundImage(img, for: UIControlState())
        leftButton.addTarget(self, action: #selector(contactViewController.homeClick(_:)), for: UIControlEvents.touchUpInside)
        navView.addSubview(leftButton)
        let titlepos = (ScreenSize.width - 120) / 2
        /* Navigation Title*/
        
        let titleButton: UIButton = UIButton()
        titleButton.frame = CGRect(x: titlepos - 2, y: navMid + 10, width: 120, height: 30)
        titleButton.setTitle("Edit Call Sponsor", for: UIControlState())
        titleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        titleButton.setTitleColor(UIColor.white, for: UIControlState())
        navView.addSubview(titleButton)
        
        
        let fNlabelTitle = UILabel()
        fNlabelTitle.frame = CGRect(x: 20, y: 10, width: 100, height: 30)
        fNlabelTitle.text = "First Name"
        fNlabelTitle.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        fNlabelTitle.font = SMLGlobal.sharedInstance.fontSize(12)
        scrollView.addSubview(fNlabelTitle)
        
        
        
        fTextField.frame = CGRect(x: 20, y: fNlabelTitle.frame.maxY + 5, width: ScreenSize.width - 40, height: 30)
        fTextField.tag = 1
        fTextField.becomeFirstResponder()
        fTextField.text = editDict .object(forKey: "firstname") as! NSString as String
        fTextField.delegate = self
        fTextField.layer.borderWidth = 1
        fTextField.layer.cornerRadius = 5
        fTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        let attrStr : (NSAttributedString) = NSAttributedString(string: "First Name", attributes: [NSFontAttributeName:SMLGlobal.sharedInstance.fontSize(12)])
        fTextField.attributedPlaceholder = attrStr
        fTextField.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
        scrollView.addSubview(fTextField)
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        fTextField.leftView = leftView;
        fTextField.leftViewMode = UITextFieldViewMode.always;
        let lNlabelTitle = UILabel()
        lNlabelTitle.frame = CGRect(x: 20, y: fTextField.frame.maxY + 10, width: 100, height: 30)
        lNlabelTitle.text = "Last Name"
        lNlabelTitle.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        lNlabelTitle.font = SMLGlobal.sharedInstance.fontSize(12)
        scrollView.addSubview(lNlabelTitle)
        
        
        
        lTextField.frame = CGRect(x: 20, y: lNlabelTitle.frame.maxY + 5, width: ScreenSize.width - 40, height: 30)
        lTextField.tag = 2
        lTextField.text = editDict .object(forKey: "lastname") as! NSString as String
        lTextField.delegate = self
        lTextField.becomeFirstResponder()
        lTextField.layer.borderWidth = 1
        lTextField.layer.cornerRadius = 5
        lTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        let attrStr1 : (NSAttributedString) = NSAttributedString(string: "Last Name", attributes: [NSFontAttributeName:SMLGlobal.sharedInstance.fontSize(12)])
        lTextField.attributedPlaceholder = attrStr1
        lTextField.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
        scrollView.addSubview(lTextField)
        
        let leftView1 = UIView()
        leftView1.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        lTextField.leftView = leftView1;
        lTextField.leftViewMode = UITextFieldViewMode.always;
        
        let cNlabelTitle = UILabel()
        cNlabelTitle.frame = CGRect(x: 20, y: lTextField.frame.maxY + 10, width: 100, height: 30)
        cNlabelTitle.text = "Contact Number"
        cNlabelTitle.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        cNlabelTitle.font = SMLGlobal.sharedInstance.fontSize(12)
        scrollView.addSubview(cNlabelTitle)
        
        
        
        cNTextField.frame = CGRect(x: 20, y: cNlabelTitle.frame.maxY + 5, width: 40, height: 30)
        cNTextField.tag = 3
        cNTextField.becomeFirstResponder()
        cNTextField.layer.borderWidth = 1
        cNTextField.delegate = self
        cNTextField.layer.cornerRadius = 5
        
        
        cNTextField.text = editDict .object(forKey: "country_code") as! NSString as String
        cNTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        let attrStr2 : (NSAttributedString) = NSAttributedString(string: "Code", attributes: [NSFontAttributeName:SMLGlobal.sharedInstance.fontSize(12)])
        cNTextField.attributedPlaceholder = attrStr2
        cNTextField.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
        //scrollView.addSubview(cNTextField)
        let leftView2 = UIView()
        leftView2.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        cNTextField.leftView = leftView2;
        cNTextField.leftViewMode = UITextFieldViewMode.always;
        
        
        NTextField.frame = CGRect(x: 20, y: cNlabelTitle.frame.maxY + 5, width: ScreenSize.width - 40, height: 30)
        NTextField.tag = 3
        NTextField.text = editDict .object(forKey: "phone_number") as! NSString as String
        NTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        let attrStr3 : (NSAttributedString) = NSAttributedString(string: "Contact No.", attributes: [NSFontAttributeName:SMLGlobal.sharedInstance.fontSize(12)])
        NTextField.attributedPlaceholder = attrStr3
        NTextField.becomeFirstResponder()
        NTextField.layer.borderWidth = 1
        NTextField.delegate = self
        NTextField.layer.cornerRadius = 5
        NTextField.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
        scrollView.addSubview(NTextField)
        let leftView3 = UIView()
        leftView3.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        NTextField.leftView = leftView3;
        NTextField.leftViewMode = UITextFieldViewMode.always;
        
        
        
        let orLabel = UILabel()
        orLabel.frame = CGRect(x: (ScreenSize.width - 30) / 2, y: cNTextField.frame.maxY + 5, width: 30, height: 30)
        orLabel.text = "Or"
        orLabel.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        orLabel.font = SMLGlobal.sharedInstance.fontSize(12)
      //  scrollView.addSubview(orLabel)
        
        importButtopn  = UIButton.init(type: UIButtonType.custom)
        importButtopn.frame = CGRect(x: (ScreenSize.width - 200) / 2, y: orLabel.frame.maxY, width: 200, height: 30)
        importButtopn.setTitle("Import Phone Contact", for: UIControlState())
        importButtopn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
        importButtopn.layer.borderWidth = 1
        importButtopn.layer.cornerRadius = 5
        importButtopn.backgroundColor =  NavigationColor
        importButtopn.addTarget(self, action: #selector(contactViewController.numberFetch(_:)), for: UIControlEvents.touchUpInside)
        importButtopn.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
        importButtopn.setTitleColor(UIColor.white, for: UIControlState())
       // scrollView.addSubview(importButtopn)
        
        let saveButton: UIButton = UIButton()
        saveButton.frame = CGRect(x: ScreenSize.width / 2 - 105, y: importButtopn.frame.maxY + 20, width: 100, height: 35)
        saveButton.backgroundColor = ButtonBlueColor
        saveButton.setTitle("Save", for: UIControlState())
        saveButton.setTitleColor(UIColor.white, for: UIControlState())
        saveButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14.0)
        saveButton.layer.cornerRadius = 2.0
        //var saveImg = UIImage(named: "Save_Button")
        //saveButton.setImage(saveImg, forState: .Normal)
        saveButton.addTarget(self, action: #selector(contactViewController.saveButtonClick(_:)), for: UIControlEvents.touchUpInside)
        scrollView.addSubview(saveButton)
        
        let cancleButton: UIButton = UIButton()
        cancleButton.frame = CGRect(x: ScreenSize.width / 2 + 5, y: importButtopn.frame.maxY + 20, width: 100, height: 35)
        cancleButton.backgroundColor = ButtonRedColor
        cancleButton.setTitle("Cancel", for: UIControlState())
        cancleButton.setTitleColor(UIColor.white, for: UIControlState())
        cancleButton.layer.cornerRadius = 2.0
        cancleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14.0)
        //var cancleimg = UIImage(named: "popupcancel")
        //cancleButton.setImage(cancleimg, forState: .Normal)
        cancleButton.addTarget(self, action: #selector(contactViewController.saveButtonClick(_:)), for: UIControlEvents.touchUpInside)
        scrollView.addSubview(cancleButton)
    }
//    func whiteSpaceCheck() ->Bool {
//        var textField = UITextField()
//        var val = 5
//        
//        var rawString: NSString = fTextField.text
//        
//        
//        
//        var whitespace: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()
//        var trimmed: NSString = rawString.stringByTrimmingCharactersInSet(whitespace)
//        val = trimmed.length
//        println(trimmed)
//        var numberOfSpaces = count(fTextField.text.componentsSeparatedByString(" "))
//        var numberOfSpaces1 = count(lTextField.text.componentsSeparatedByString(" "))
//        
//        println(numberOfSpaces)
//        if firstBlnkValue == 1 {
//            var alertView = UIAlertView (title: "", message: "First Name field is mandatory", delegate: nil, cancelButtonTitle: "OK")
//            alertView.show();
//            fTextField.text = ""
//            return false;
//            
//        } else if firstBlnkValue == 2 {
//            var alertView = UIAlertView (title: "", message: "Last Name field is mandatory", delegate: nil, cancelButtonTitle: "OK")
//            alertView.show();
//            lTextField.text = ""
//            return false;
//            
//        } else {
//            return true;
//        }
//    }
  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    func homeClick(_ sender: UIButton) {
        navigationItem.hidesBackButton = true
        navigationController?.popViewController(animated: true)
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == NTextField  || textField == cNTextField)
        {
            
            let start = string.startIndex
            let end = string.endIndex
            let range = start..<end
            let invalidCharacters = CharacterSet(charactersIn: "0123456789_.-+").inverted
            if string.rangeOfCharacter(from: invalidCharacters, options: NSString.CompareOptions.caseInsensitive, range:range) != nil
            {
                SMLGlobal.sharedInstance.displayAlertMessage(self, "Please enter valid Contact No.", title: "")
                return false
            }
            else
            {
                
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let tagValue : CGFloat =  CGFloat(textField.tag)
        if(tagValue>1)
        {
            if(ScreenSize.height == 667)
            {
                scrollView.contentOffset = CGPoint(x: 0, y: 10 * tagValue);
            }
            else
            {
                scrollView.contentOffset = CGPoint(x: 0, y: 30 * tagValue);
            }
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        textField.resignFirstResponder()
        return true
    }
    
    func numberFetch(_ sender: UIButton)
    {
      self.displayContacts()
    }

    func saveButtonClick(_ sender: UIButton)
    {
        conValidation()
      
        if(self .checkTextFields())
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
            
             SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
          //http://112.196.34.179/stepslocator/index.php/login/wsUpdateSponsors?sponsorId=49&firstname=developerIapp&lastname=Php&number=9988776655&country_code=&*klnhg15277
            let ids : (NSString) = editDict.object(forKey: "id") as! String as (NSString)
            let parameters : (NSDictionary) = ["sponsorId" : ids,
                "firstname" : fTextField.text! as NSString,
                "lastname" : lTextField.text! as NSString,
                "number" : NTextField.text! as NSString
                ,"country_code" : cNTextField.text! as NSString]
            
            WebserviceManager.sharedInstance.updateCallSponsors(params: parameters) { (responseObject, error) in
                if responseObject != nil
                {
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    if success == 0
                    {
                        let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                        SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                        SVProgressHUD .dismiss()
                    }
                    else if success == 1
                    {
                        let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                        let alertView = UIAlertView(title: "", message:message as String, delegate: self, cancelButtonTitle: "Ok")
                        alertView.show()
                        SVProgressHUD .dismiss()
                    }
                }
                else
                {
                    SVProgressHUD .dismiss()
                }
            }
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
    
    
    func cancleButtonClick(_ sender: UIButton)
    {
     self.navigationController?.popViewController(animated: false)
    }
    
    
    
    func checkTextFields()->Bool
    {
        if fTextField.text == "" || firstBlnkValue == 1
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "First Name field is mandatory", title: "")
            fTextField.text = ""
            return false
        }
        else if lTextField.text == ""  || firstBlnkValue1 == 1
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Last Name field is mandatory", title: "")
            lTextField.text = ""
            
            return false
        }
        else if  NTextField.text == ""
        {
             SMLGlobal.sharedInstance.displayAlertMessage(self, "Enter Contact No. field is mandatory", title: "")
            return false
        }
            
        //else if(!self.isValidNumber(NTextField.text))
//        {
//            var alertView = UIAlertView(title: "", message: "Contact No. is not valid", delegate: nil, cancelButtonTitle: "Ok")
//            alertView.show()
//            return false
//        }
//        else if(!self.isValidNumber(cNTextField.text))
//        {
//            var alertView = UIAlertView(title: "", message: "Code is not valid", delegate: nil, cancelButtonTitle: "Ok")
//            alertView.show()
//            return false
//        }
        else
        {
            return true
        }
        
    }
    
    func isValidNumber(_ str : NSString)->Bool
    {
    let phoneRegex : (NSString) = "^((\\+)|(00))[0-9]{6,14}$"
    let predicate : (NSPredicate) = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
    return predicate .evaluate(with: str)
    //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    //        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    //
    //        return [phoneTest evaluateWithObject:phoneNumber];
    
    }

    func displayContacts()
    {
        
        let _addressBook = ABPeoplePickerNavigationController()
        _addressBook.peoplePickerDelegate = self
        self.present(_addressBook, animated: false, completion: nil)
        
    }
    
    func peoplePickerNavigationControllerDidCancel(_ peoplePicker: ABPeoplePickerNavigationController) {
        
        SMLGlobal.sharedInstance.displayAlertMessage(self, "You are not Selected Any Contact Number", title: "")
    }
   
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord) {
        
        let unmanagedPhones = ABRecordCopyValue(person, kABPersonPhoneProperty)
        let phones: ABMultiValue =
        Unmanaged.fromOpaque(unmanagedPhones!.toOpaque()).takeUnretainedValue()
            as NSObject as ABMultiValue
        
        let countOfPhones = ABMultiValueGetCount(phones)
        
        for index in 0..<countOfPhones{
            let unmanagedPhone = ABMultiValueCopyValueAtIndex(phones, index)
            let phone: String = Unmanaged.fromOpaque(
                unmanagedPhone!.toOpaque()).takeUnretainedValue() as NSObject as! String
            
            
            
            
            // let myNSString = str as NSString
            // myNSString.substringWithRange(NSRange(location: 0, length: 3))
            
            if #available(iOS 8.0, *) {
                if (phone as String).contains("+")
                {
                    let lengthCount : (Int) = phone.characters.count
                    let start = phone.startIndex
                    let end = phone.index(phone.startIndex, offsetBy: 3)
                    let range = start..<end
                    let range1 = phone.startIndex..<phone.index(phone.startIndex, offsetBy: lengthCount - 3)
                    // var firstChar : (NSString) = firstName.substringWithRange(NSMakeRange(0, 1))
                    let code : (NSString) =  phone.substring(with: range) as (NSString)
                    let mobNo :(NSString) =  phone.substring(with: range1) as (NSString)
                    
                    NTextField.text = mobNo as String
                    cNTextField.text = code as String
                }
                else
                {
                    NTextField.text = phone as String
                }
            } else {
                // Fallback on earlier versions
            }
            
            
            
            //            if(phone.rangeOfString("+", options: nil, range: NSMakeRange(0, count(phone)), locale: nil).locatio == NSNotFound)
            //            {
            //                var code : (NSString)  = phone.substringWithRange(NSMakeRange(0, 3))
            //                var mobNo :(NSString) = phone.substringWithRange(NSMakeRange(3, count(phone) - 3))
            //
            //                NTextField.text = mobNo
            //                cNTextField.text = code
            //            }
            //            else
            //            {
            //
            //            }
            // NTextField.text = phone
           // println(phone)
        }
        
        
        
        
        // Get the first name.
        let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as! String
        fTextField.text = firstName
        
        
        
        // Get the last name.
        let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as! String
        lTextField.text = lastName    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func conValidation() {
        
        
        var str = fTextField.text! as String
        var str1 = lTextField.text! as String
        
        //        var firstBlnkValue = 0
        //        var textViewVal = 0
        //        var desVal = 0
        
        let d = 32 as unichar
        
        
        if (fTextField.text?.characters.count)! > 2 {
            
            if str == "" {
                firstBlnkValue = 0
            } else {
//                let start = str.index(str.startIndex, offsetBy: 0)
//                let end   = str.index(str.endIndex, offsetBy: 1)
//                let range = start..<end
//                var value = str.substring(with:range)
//                    str.substringWithRange(NSRange(location: 0, length: 1))
                let c:unichar = str.utf16.first!
                
                if c == d {
                    firstBlnkValue = 1
                    
                } else {
                    firstBlnkValue = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if fTextField.text?.characters.count == 1 {
            
            let c:unichar = str.utf16.first!;
            
            if c == d {
                firstBlnkValue = 1
                
            } else {
                firstBlnkValue = 0
                
            }
        }
        if (lTextField.text?.characters.count)! > 2 {
            
            if str1 == "" {
                firstBlnkValue1 = 0
                
                //println("Sk Rejabul")
            } else {
//                let start = str1.index(str1.startIndex, offsetBy: 0)
//                let end = str1.index(str1.endIndex, offsetBy: 1)
//                let range = start..<end
//                var value = str1.substring(with: range)
                let c:unichar = str1.utf16.first!;
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue1 = 1
                    
                } else {
                    firstBlnkValue1 = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if lTextField.text?.characters.count == 1 {
            
            let c:unichar = str1.utf16.first!;
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue1 = 1
                
            } else {
                firstBlnkValue1 = 0
                
            }
        }
    }
    




}
