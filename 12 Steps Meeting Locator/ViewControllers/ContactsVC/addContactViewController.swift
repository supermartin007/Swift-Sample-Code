//
//  addContactViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 24/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import AddressBook
import AddressBookUI

import ContactsUI
//import Contacts
var importValue = 0
class addContactViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate , ABPeoplePickerNavigationControllerDelegate,CNContactPickerDelegate {
 var addPictureNav: UIView!
      var backView : UIScrollView!
    var importButtopn : UIButton!
    var nubFetchProper = 0
    var numNotFound = 0
     var NTextField : UITextField = UITextField()
      var adbk : ABAddressBook!
     var cNlabelTitle = UILabel()
    var fTextField : UITextField = UITextField()
     var lTextField : UITextField = UITextField()
    var cNTextField : UITextField = UITextField()
    var timer: Timer!
    var firstBlnkValue = 0
    var firstBlnkValue1 = 0
    var completeText : (NSMutableString) = NSMutableString()
    override func viewDidLoad() {
        super.viewDidLoad()
 view.backgroundColor = UIColor.white
     self.createView()
    }
    
    
    func createView() {
        
        addPictureNav = UIView()
        addPictureNav.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        addPictureNav.backgroundColor = UIColor(red: 0 / 255.0, green:135.0 / 255, blue: 206.0 / 255, alpha: 1.0)
        self.view.addSubview(addPictureNav)
        
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        
        let meetingNodeTitel: UILabel = UILabel()
        meetingNodeTitel.text = "Add New Sponsor"
        meetingNodeTitel.font = SMLGlobal.sharedInstance.fontSize(14)
        meetingNodeTitel.frame = CGRect(x: (ScreenSize.width - 130) / 2, y: 29, width: 130, height: 20)
        meetingNodeTitel.textColor = UIColor.white
        
        addPictureNav.addSubview(meetingNodeTitel)
        
        let leftHomeButton : UIButton = UIButton()
        let homeImage: UIImage = UIImage(named: "back_errow")!
        
        leftHomeButton.frame = CGRect(x: 16, y: 29, width: 19 , height: 20)
        leftHomeButton.setBackgroundImage(homeImage, for: UIControlState())
        leftHomeButton.addTarget(self, action: #selector(addContactViewController.homeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addPictureNav.addSubview(leftHomeButton)
        backView = UIScrollView()
        backView.frame = CGRect(x: 0, y: addPictureNav.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - 64)
        backView.backgroundColor = UIColor.white
        self.view.addSubview(backView)
        
        let fNlabelTitle = UILabel()
        fNlabelTitle.frame = CGRect(x: 20, y: 10, width: 100, height: 30)
        fNlabelTitle.text = "First Name"
        fNlabelTitle.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        fNlabelTitle.font = SMLGlobal.sharedInstance.fontSize(12)
        backView.addSubview(fNlabelTitle)
        
        
        
        fTextField.frame = CGRect(x: 20, y: fNlabelTitle.frame.maxY + 5, width: ScreenSize.width - 40, height: 30)
        fTextField.tag = 1
        fTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        
        let attribStr = NSAttributedString(string: "First Name", attributes: [NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(12)])
        fTextField.attributedPlaceholder = attribStr
        //fTextField.becomeFirstResponder()
        fTextField.delegate = self
        fTextField.layer.borderWidth = 1
        fTextField.layer.cornerRadius = 5
        fTextField.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
        backView.addSubview(fTextField)
        let leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        fTextField.leftView = leftView;
        fTextField.leftViewMode = UITextFieldViewMode.always;
        let lNlabelTitle = UILabel()
        lNlabelTitle.frame = CGRect(x: 20, y: fTextField.frame.maxY + 10, width: 100, height: 30)
        lNlabelTitle.text = "Last Name"
        lNlabelTitle.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        lNlabelTitle.font = SMLGlobal.sharedInstance.fontSize(12)
        backView.addSubview(lNlabelTitle)
        
        
        
        lTextField.frame = CGRect(x: 20, y: lNlabelTitle.frame.maxY + 5, width: ScreenSize.width - 40, height: 30)
        lTextField.tag = 2
        lTextField.delegate = self
        lTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        
        let attribStr1 = NSAttributedString(string: "Last Name", attributes: [NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(12)])
        lTextField.attributedPlaceholder = attribStr1
        //lTextField.becomeFirstResponder()
        lTextField.layer.borderWidth = 1
        lTextField.layer.cornerRadius = 5
        lTextField.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
        backView.addSubview(lTextField)
        let leftView1 = UIView()
        leftView1.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        lTextField.leftView = leftView1;
        lTextField.leftViewMode = UITextFieldViewMode.always;
        
        
        cNlabelTitle.frame = CGRect(x: 20, y: lTextField.frame.maxY + 10, width: 100, height: 30)
        cNlabelTitle.text = "Contact Number"
        cNlabelTitle.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        cNlabelTitle.font = SMLGlobal.sharedInstance.fontSize(12)
        backView.addSubview(cNlabelTitle)
        
        
        
        cNTextField.frame = CGRect(x: 20, y: cNlabelTitle.frame.maxY + 5, width: 40, height: 30)
        cNTextField.tag = 3
        //cNTextField.becomeFirstResponder()
        cNTextField.layer.borderWidth = 1
        cNTextField.delegate = self
        cNTextField.layer.cornerRadius = 5
        cNTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        
        let attribStr3 = NSAttributedString(string: "Code", attributes: [NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(12)])
        cNTextField.attributedPlaceholder = attribStr3
        //cNTextField.keyboardType = UIKeyboardType.NumberPad
        cNTextField.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
       // backView.addSubview(cNTextField)
        let leftView2 = UIView()
        leftView2.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        cNTextField.leftView = leftView2;
        cNTextField.leftViewMode = UITextFieldViewMode.always;
        
        
        NTextField.frame = CGRect(x: 20, y: cNlabelTitle.frame.maxY + 5, width: ScreenSize.width - 40, height: 30)
        NTextField.tag = 3
        NTextField.font = SMLGlobal.sharedInstance.fontSize(12)
        
        let attribStr2 = NSAttributedString(string: "ContactNo.", attributes: [NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(12)])
        NTextField.attributedPlaceholder = attribStr2
        //NTextField.becomeFirstResponder()
        NTextField.layer.borderWidth = 1
        NTextField.delegate = self
        NTextField.layer.cornerRadius = 5
        NTextField.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
        backView.addSubview(NTextField)
        let leftView3 = UIView()
        leftView3.frame = CGRect(x: 0, y: 0, width: 5, height: 30);
        NTextField.leftView = leftView3;
        NTextField.leftViewMode = UITextFieldViewMode.always;
        
        let orLabel = UILabel()
        orLabel.frame = CGRect(x: (ScreenSize.width - 30) / 2, y: cNTextField.frame.maxY + 5, width: 30, height: 30)
        orLabel.text = "Or"
        orLabel.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        orLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        backView.addSubview(orLabel)
        
        importButtopn  = UIButton.init(type: UIButtonType.custom)
        importButtopn.frame = CGRect(x: (ScreenSize.width - 200) / 2, y: orLabel.frame.maxY, width: 200, height: 30)
        importButtopn.setTitle("Import Phone Contact", for: UIControlState())
        importButtopn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
        importButtopn.layer.borderWidth = 1
        importButtopn.layer.cornerRadius = 5
        importButtopn.backgroundColor = NavigationColor
        importButtopn.addTarget(self, action: #selector(addContactViewController.numberFetch(_:)), for: UIControlEvents.touchUpInside)
        importButtopn.layer.borderColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.1).cgColor
        importButtopn.setTitleColor(UIColor.white, for: UIControlState())
        backView.addSubview(importButtopn)
        
        let saveButton: UIButton = UIButton()
        saveButton.frame = CGRect(x: ScreenSize.width / 2 - 105, y: importButtopn.frame.maxY + 20, width: 100, height: 35)
        //var saveImg = UIImage(named: "add_button")
        // saveButton.setBackgroundImage(saveImg, forState: .Normal)
        saveButton.backgroundColor = ButtonBlueColor
        saveButton.setTitle("Add", for: UIControlState())
        saveButton.setTitleColor(UIColor.white, for: UIControlState())
        saveButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14.0)
        saveButton.layer.cornerRadius = 2.0
        saveButton.addTarget(self, action: #selector(addContactViewController.saveButtonClick(_:)), for: UIControlEvents.touchUpInside)
        backView.addSubview(saveButton)
        
        let cancleButton: UIButton = UIButton()
        cancleButton.frame = CGRect(x: ScreenSize.width / 2 + 5, y: importButtopn.frame.maxY + 20, width: 100, height: 35)
        //var cancleimg = UIImage(named: "popupcancel")
        //cancleButton.setBackgroundImage(cancleimg, forState: .Normal)
        cancleButton.backgroundColor = ButtonRedColor
        cancleButton.setTitle("Cancel", for: UIControlState())
        cancleButton.setTitleColor(UIColor.white, for: UIControlState())
        cancleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14.0)
        cancleButton.layer.cornerRadius = 2.0
        cancleButton.addTarget(self, action: #selector(addContactViewController.cancleButtonClick(_:)), for: UIControlEvents.touchUpInside)
        backView.addSubview(cancleButton)
        
        
        backView.isScrollEnabled = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func homeButtonClick(_ sender: UIButton) {
        navigationItem.hidesBackButton = true
        navigationController?.popViewController(animated: true)
    }
    
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
               if(textField == NTextField  || textField == cNTextField)
        {
            let invalidCharacters = CharacterSet(charactersIn: "0123456789_.-+").inverted
            let startIndex = string.startIndex
            let endIndex = string.endIndex
            let range = startIndex..<endIndex
            if string.rangeOfCharacter(from: invalidCharacters, options: String.CompareOptions.caseInsensitive, range: range) != nil
//            if let range = string.rangeOfCharacterFromSet(invalidCharacters, options: nil, range:Range<String.Index>(start: string.startIndex, end: string.endIndex))
            {
                UIAlertView(title: "", message: "Please enter valid Contact No.", delegate: nil, cancelButtonTitle: "OK").show()
                return false
            }
            else
            {
                
            }
//
            
            
//        var newString = NTextField.text.stringByReplacingCharactersInRange(range, withString: string)
//        var exp = "^([0-9]+)?(\\.([0-9]{1,2})?)?$"
//            var lengthCount : (Int) = count(newString)
//            var regex : (NSRegularExpression) = NSRegularExpression(pattern: exp, options: NSRegularExpressionOptions.CaseInsensitive, error: nil)!
//            var numberOfMatches : (Int)  = regex .numberOfMatchesInString(newString, options:nil, range: NSMakeRange(0,lengthCount))
//            
//            if(numberOfMatches == 0)
//            {
//                return false
//            }
//            
//            var newString = NTextField.text .stringByReplacingCharactersInRange(range, withString: string)
//            var exp = "^([0-9]+)?(\\.([0-9]{1,2})?)?$"
//            var regex : (NSRegularExpression) =
//            
//            NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//            NSString *expression = @"^([0-9]+)?(\\.([0-9]{1,2})?)?$";
//            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression
//            options:NSRegularExpressionCaseInsensitive
//            error:nil];
//            NSUInteger numberOfMatches = [regex numberOfMatchesInString:newString
//            options:0
//            range:NSMakeRange(0, [newString length])];
//            if (numberOfMatches == 0)
//            return NO;
            
            
            
            
//            var phoneRegex : (NSString) = "[0-9]"
//            //"[789][0-9]{9}"
//            var predicate : (NSPredicate) = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
//            var count1 : (Int)  = count(NTextField.text)
//            if(string == "")
//            {
//               completeText.deleteCharactersInRange(NSMakeRange(count1-1, 1))
//            }
//            else
//            {
//                completeText.appendString(string)
//            }
//            
//            if(!predicate.evaluateWithObject(NTextField.text))
//            {
//                UIAlertView(title: "", message: "Plz enter valid mobile number", delegate: nil, cancelButtonTitle: "OK").show()
//                
//            }
//            else
//            {
//               
//            }
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
                backView.contentOffset = CGPoint(x: 0, y: 10 * tagValue);
            }
            else
            {
                backView.contentOffset = CGPoint(x: 0, y: 30 * tagValue);
            }
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        backView.contentOffset = CGPoint(x: 0, y: 0)
        textField.resignFirstResponder()
         return true
    }
    
    func saveButtonClick(_ sender: UIButton)
    {
     //http://112.196.34.179/stepslocator/index.php/login/wsAddSponsors?userId=10&firstname=developer&lastname=Iapp&number=9988997766&country_code=35tyf766
        conValidation()
        if(self .checkTextFields())
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
            //SVProgressHUD.showWithStatus("Loading")
            SVProgressHUD.show(withStatus: "Loading...", maskType: SVProgressHUDMaskType.black)
            let user : (SMLAppUser) = SMLAppUser.getUser()
            let loginId : (NSString) = user.userId
            let parameters : (NSDictionary) = ["userId" : loginId,
                                               "firstname" : fTextField.text! as NSString,
                                                "lastname" : lTextField.text! as NSString,
                                                "number" : NTextField.text! as NSString,
                                                "country_code" : cNTextField.text! as NSString]
            
            WebserviceManager.sharedInstance.addSponsors(params: parameters, withCompletionBlock: { (responseObject, error) in
                if responseObject != nil
                {
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    
                    if success == 0
                    {
                        let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                        let alertView = UIAlertView(title: "", message:message as String, delegate: nil, cancelButtonTitle: "Ok")
                        alertView.show()
                        SVProgressHUD .dismiss()
                        
                        
                    }
                    else if success == 1
                    {
                        self.numNotFound = 0
                        let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                        let alertView = UIAlertView(title: "", message:message as String, delegate: self, cancelButtonTitle: "Ok")
                        alertView.show()
                        SVProgressHUD .dismiss()
                    }
                }
                else
                {
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
    
    func checkTextFields()->Bool
    {
        if fTextField.text == "" || firstBlnkValue == 1
        {
            let alertView = UIAlertView(title: "", message: "First Name field is mandatory", delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()
            fTextField.text = ""
            return false
        }
        else if lTextField.text == "" || firstBlnkValue1 == 1
        {
            let alertView = UIAlertView(title: "", message: "Last Name field is mandatory", delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()
            lTextField.text = "" 
            
            return false
        }
        else if  NTextField.text == ""
        {
            let alertView = UIAlertView(title: "", message: "Enter Contact No. field is mandatory", delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()
            return false
        }
        
//        else if(self.isValidNumber(NTextField.text))
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
        //[789][0-9]{9}
        //var value : (Bool) = false
        //\\b[\\d]{3}\\-[\\d]{3}\\-[\\d]{4}\\b
        //var phoneRegex : (NSString) = "\\b[\\d]{3}\\-[\\d]{3}\\-[\\d]{4}\\b"
       // var phoneRegex : (NSString) = "^((\\+)|(00))[0-9]{6,14}$"
       // var phoneRegex : (NSString) = "^((\\+)|(00))[0-9]{6,14}$"
        //[789][0-9]{9}
        let phoneRegex : (NSString) = "[0-9]"
        let predicate : (NSPredicate) = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate .evaluate(with: str)
//        if(value == false)
//        {
//            var phoneRegex1 : (NSString) = "^((\\+)|(00))[0-9]{6,14}$"
//            var predicate1 : (NSPredicate) = NSPredicate(format: "SELF MATCHES %@", phoneRegex1)
//            value = predicate1 .evaluateWithObject(str)
//            return value
//        }
//        else
//        {
//            return value
//        }
       // return predicate .evaluateWithObject(str)
        //NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
//        NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
//        
//        return [phoneTest evaluateWithObject:phoneNumber];
       
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if numNotFound == 1 {
        
            timer.invalidate()
            numNotFound == 0
        } else {
        self.navigationController?.popViewController(animated: false)
        }
    }
    
    func cancleButtonClick(_ sender: UIButton) {
        
        if nubFetchProper == 1 {
            cNTextField.isHidden = false
        } else if nubFetchProper == 0 {
            cNTextField.isHidden = true
            NTextField.frame = CGRect(x: cNTextField.frame.maxX + 5, y: cNlabelTitle.frame.maxY + 5, width: ScreenSize.width - 85, height: 30)
        }
        self.navigationController?.popViewController(animated: false)
        
    }
    
    func displayContacts()
    {
//               let _addressBook = ABPeoplePickerNavigationController()
//        _addressBook.peoplePickerDelegate = self
//        self.present(_addressBook, animated: false, completion: nil)
      
       
        if #available(iOS 9.0, *) {
            let contactPicker = CNContactPickerViewController()
            contactPicker.delegate = self
            contactPicker.displayedPropertyKeys =
                [CNContactPhoneNumbersKey]
            self.present(contactPicker, animated: true, completion: nil)


        } else {
            // Fallback on earlier versions
        }
        

    }
    @available(iOS 9.0, *)
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        //Dismiss the picker VC
        picker.dismiss(animated: true, completion: nil)
         //See if the contact has multiple phone numbers
        if contact.phoneNumbers.count > 1 {
            //If so we need the user to select which phone number we want them to use
            let multiplePhoneNumbersAlert = UIAlertController(title: "Which one?", message: "This contact has multiple phone numbers, which one did you want use?", preferredStyle: UIAlertControllerStyle.alert)
            //Loop through all the phone numbers that we got back
            for number in contact.phoneNumbers {
                
                //Each object in the phone numbers array has a value property that is a CNPhoneNumber object, Make sure we can get that
                if let actualNumber = number.value as? CNPhoneNumber {
                    //Get the label for the phone number
                    var phoneNumberLabel = number.label
                    //Strip off all the extra crap that comes through in that label
                     phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: "_", with: "", options: String.CompareOptions.literal, range: nil)
                      phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: "$", with: "", options: String.CompareOptions.literal, range: nil)
                    phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: "!", with: "", options: String.CompareOptions.literal, range: nil)
                    phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: "<", with: "", options: String.CompareOptions.literal, range: nil)
                    phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: ">", with: "", options: String.CompareOptions.literal, range: nil)
                    //Create a title for the action for the UIAlertVC that we display to the user to pick phone numbers
                    let actionTitle = phoneNumberLabel! + " - " + actualNumber.stringValue
                    //Create the alert action
                    
//                    let numberAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: { (theAction) in
//                        
//                    })
                    let numberAction = UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default, handler: { (theAction) -> Void in
                        //Create an empty string for the contacts name
                        var nameToSave = ""
                        var lastName   = ""
                        //See if we can get A frist name
                        if contact.givenName == "" {
                            //If Not check for a last name
                            if contact.familyName == "" {
                                //If no last name set name to Unknown Name
                                nameToSave = contact.familyName
                            }
                            else
                            {
                                nameToSave = contact.familyName
                            }
                        }
                        else
                        {
                            nameToSave = contact.givenName
                            if contact.familyName != "" {
                                //If no last name set name to Unknown Name
                                lastName = contact.familyName
                            }
                        }
                      
                        //Do what you need to do with your new contact information here!
                        //Get the string value of the phone number like this:
                        //actualNumber.stringValue
                        
                        self.fTextField.text = nameToSave;
                        self.lTextField.text = lastName
                        self.NTextField.text = actualNumber.stringValue
                    })
                    //Add the action to the AlertController
                    multiplePhoneNumbersAlert.addAction(numberAction)
                }
            }
            //Add a cancel action
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (theAction) -> Void in
                //Cancel action completion
                print("User Cancelled")
            })
            //Add the cancel action
            multiplePhoneNumbersAlert.addAction(cancelAction)
            //Present the ALert controller
            self.present(multiplePhoneNumbersAlert, animated: true, completion: nil)
        }else{
            //Make sure we have at least one phone number
            if contact.phoneNumbers.count > 0 {
                
                //self.showContactView.hidden = false
                
                //If so get the CNPhoneNumber object from the first item in the array of phone numbers
                 if let actualNumber = contact.phoneNumbers.first?.value
                 {
                    // http://tinyurl.com/jhcfgsg              //Get the label for the phone number
                    var phoneNumberLabel = contact.phoneNumbers.first!.label
                    //Strip off all the extra crap that comes through in that label
                    phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: "_", with: "", options: String.CompareOptions.literal, range: nil)
                    phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: "$", with: "", options: String.CompareOptions.literal, range: nil)
                    phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: "!", with: "", options: String.CompareOptions.literal, range: nil)
                    phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: "<", with: "", options: String.CompareOptions.literal, range: nil)
                    phoneNumberLabel = phoneNumberLabel?.replacingOccurrences(of: ">", with: "", options: String.CompareOptions.literal, range: nil)
                    
                    //Create an empty string for the contacts name
                    var nameToSave = ""
                    var lastName = ""
                    //See if we can get A frist name
                    if contact.givenName == "" {
                        //If Not check for a last name
                        if contact.familyName == "" {
                            //If no last name set name to Unknown Name
                            nameToSave = contact.familyName
                        }else{
                            nameToSave = contact.familyName
                        }
                    }else
                    {
                        nameToSave = contact.givenName
                        if contact.familyName != ""
                        {
                                //If no last name set name to Unknown Name
                            lastName = contact.familyName
                        }
                    }
                    
                    fTextField.text = nameToSave
                    self.lTextField.text = lastName
                    // See if we can get image data
                    if let imageData = contact.imageData {
                        //If so create the image
                        //self.imgContact.image = userImage;
                    }
                    //Do what you need to do with your new contact information here!
                    //Get the string value of the phone number like this:
                    print(actualNumber.stringValue)
                    self.NTextField.text = actualNumber.stringValue
                }
            }else{
                
//                self.statusLabel.hidden = false;
//                self.statusLabel.text = NO_PHONE_NUMBERS
                
            }
        }
    }
    
//    private func contactPicker(picker: CNContactPickerViewController, didSelectContacts ContctAryVar: [CNContact])
//    {
////        for ContctVar in ContctAryVar
////        {
////            let ContctDtlVar = ContctDtlCls()
////            ContctDtlVar.ManNamVar = CNContactFormatter.stringFromContact(ContctVar, style: .FullName)!
////            
////            for ContctNumVar: CNLabeledValue in ContctVar.phoneNumbers
////            {
////                var MobNumVar  = ((ContctNumVar.value as! CNPhoneNumber).valueForKey("digits") as? String)!
////                if(MobNumVar.Len() > 10)
////                {
////                    MobNumVar = MobNumVar.GetLstSubSrgFnc(10)
////                }
////                ContctDtlVar.MobNumVar = MobNumVar
////                ContctDtlAryVar.append(ContctDtlVar)
////            }
////        }
//
//    }
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController, didSelectPerson person: ABRecord)
    {

        if nubFetchProper == 0 {
            cNTextField.isHidden = false
        } else if nubFetchProper == 1 {
            cNTextField.isHidden = true
            NTextField.frame = CGRect(x: 20, y: cNlabelTitle.frame.maxY + 5, width: ScreenSize.width - 40, height: 30)
            backView.addSubview(NTextField)
        }

        cNTextField.isHidden = true
 
        
        let firstNameTemp = ABRecordCopyValue(person, kABPersonPhoneProperty)
        
 
        
      
      if(firstNameTemp == nil)
      {
        timer  = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addContactViewController.messageFor(_:)), userInfo: nil, repeats: true)
        numNotFound = 1
         return
       
        }
        
      
        
        var multiValue : (ABMultiValue) = ABRecordCopyValue(person, kABPersonPhoneProperty).takeRetainedValue()
        var twitter : NSString!
        var facebook : NSString!
        
        let unmanagedPhones = ABRecordCopyValue(person, kABPersonPhoneProperty)
        let phones: ABMultiValue =
        Unmanaged.fromOpaque(unmanagedPhones!.toOpaque()).takeUnretainedValue()
            as NSObject as ABMultiValue
        
        let countOfPhones = ABMultiValueGetCount(phones)
        if countOfPhones == 0 {
            NTextField.text = ""
            numNotFound = 1
            if  ABRecordCopyValue(person, kABPersonFirstNameProperty) == nil {
                fTextField.text = ""
                //fTextField.placeholder = "First Name is Not Available"
            } else {
                
                
                let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as! String
                fTextField.text = firstName
                
                
            }
            // Get the last name.
            
            // var last = kABPersonLastNameProperty as String
            if  ABRecordCopyValue(person, kABPersonLastNameProperty) == nil {
                lTextField.text = ""
                // lTextField.placeholder = "Last Name is Not Available"
            } else {
                
                let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as! String
                
                
                lTextField.text = lastName
                
            }

            timer  = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addContactViewController.messageFor(_:)), userInfo: nil, repeats: true)
            
        }
        
        for index in 0..<countOfPhones{
            let unmanagedPhone = ABMultiValueCopyValueAtIndex(phones, index)
            let phone: NSString = Unmanaged.fromOpaque(
                unmanagedPhone!.toOpaque()).takeUnretainedValue() as NSObject as! String as NSString
            
            
            if phone == "" {
                NTextField.text = ""
                
                  timer  = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(addContactViewController.messageFor(_:)), userInfo: nil, repeats: true)
               numNotFound = 1
            } else {
            
           // let myNSString = str as NSString
           // myNSString.substringWithRange(NSRange(location: 0, length: 3))
            
            if ((phone as NSString).range(of: "+").location == NSNotFound)
            {
                numNotFound = 0
                let lengthCount : (Int) = String(phone).characters.count
                // var firstChar : (NSString) = firstName.substringWithRange(NSMakeRange(0, 1))
             
                var code : (NSString) =  phone.substring(with: NSMakeRange(0, 3)) as (NSString)
                var mobNo :(NSString) =  phone.substring(with: NSMakeRange(3, lengthCount - 3)) as (NSString)
                
                NTextField.text = phone as String
                //cNTextField.text = code as String
                numNotFound = 0
            }
            else
            {
               NTextField.text = phone as String
                nubFetchProper = 0
            }
            
            

        }
        
        
       
        
        // Get the first name.
        if  ABRecordCopyValue(person, kABPersonFirstNameProperty) == nil {
            fTextField.text = ""
            //fTextField.placeholder = "First Name is Not Available"
        } else {
            
        
       let firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty).takeRetainedValue() as! String
        fTextField.text = firstName

      
        }
        // Get the last name.

       // var last = kABPersonLastNameProperty as String
        if  ABRecordCopyValue(person, kABPersonLastNameProperty) == nil {
             lTextField.text = ""
           // lTextField.placeholder = "Last Name is Not Available"
        } else {
        
        let lastName = ABRecordCopyValue(person, kABPersonLastNameProperty).takeRetainedValue() as! String
     
     
        lTextField.text = lastName
        
        }
     
        }
        
    }
    func peoplePickerNavigationControllerDidCancel(_ peoplePicker: ABPeoplePickerNavigationController!)
    {
        self.dismiss(animated: false, completion: nil)
    }
    
    func peoplePickerNavigationController(_ peoplePicker: ABPeoplePickerNavigationController!, shouldContinueAfterSelectingPerson person: ABRecord!) -> Bool {
        
        peoplePickerNavigationController(peoplePicker, didSelectPerson: person)
        
        peoplePicker.dismiss(animated: true, completion: nil)
        
        return false;
    }
    
    func numberFetch(_ sender:UIButton)
    {
        nubFetchProper = 1
      
        self.displayContacts()
    }
    
    
   
    func messageFor(_ timer:Timer) {
        if numNotFound == 1 {
            let alertView = UIAlertView(title: "", message: "Contact Number is Blank", delegate: self, cancelButtonTitle: "Ok")
            alertView.show()
            timer.invalidate()
        }
    }
    
    func conValidation() {
        
        var  textField: UITextField!
        
        var str = fTextField.text! as NSString
        var str1 = lTextField.text! as NSString
        
        //        var firstBlnkValue = 0
        //        var textViewVal = 0
        //        var desVal = 0
        
        var d = 32 as unichar
        
        
        if (fTextField.text?.characters.count)! > 2 {
            
            if str == "" {
                firstBlnkValue = 0
                
                //println("Sk Rejabul")
            } else {
                var value = str.substring(with: NSRange(location: 0, length: 1))
                var c:unichar = str.character(at: 0);
                
                if c == d {
                    firstBlnkValue = 1
                    
                } else {
                    firstBlnkValue = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if fTextField.text?.characters.count == 1 {
            
            var c:unichar = str.character(at: 0);
            
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
                var value = str1.substring(with: NSRange(location: 0, length: 1))
                var c:unichar = str1.character(at: 0);
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
            
            var c:unichar = str1.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue1 = 1
                
            } else {
                firstBlnkValue1 = 0
                
            }
        }
        
        
    }
    
    

   
}
