//
//  addnewNote.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 09/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import CoreData

class addnewNote: UIViewController, UITextFieldDelegate, UITextViewDelegate,UIAlertViewDelegate{
    
    var meetingDateText : UITextField = UITextField()
    var backView : UIView = UIView()
    var scrollView : UIScrollView = UIScrollView()
    var navView: UIView = UIView()
    var datePickerView : UIView!
    var datePicker : UIDatePicker!
      var descriptionText : UITextView = UITextView()
     var meetingTitleText : UITextField = UITextField()
    var textViewVal = 0
    var selectedMeetingDate : UILabel!
    var firstBlnkValue = 0
    var desVal = 0
   // let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
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
        var navMid = navHeight / 2 - 15
        
        /* Home Button*/
        
        var leftButton: UIButton = UIButton()
        leftButton.frame = CGRect(x: 16, y: 30, width: 20, height: 20)
        var img = UIImage(named: "back_errow")
        leftButton.setBackgroundImage(img, for: UIControlState())
        leftButton.addTarget(self, action: #selector(addnewNote.homeClick(_:)), for: UIControlEvents.touchUpInside)
        navView.addSubview(leftButton)
        var titlepos = ScreenSize.width / 2 - 60
        
        /* Navigation Title*/
        
        var titleButton: UIButton = UIButton()
        titleButton.frame = CGRect(x: titlepos - 2, y: navMid + 10, width: 120, height: 30)
        titleButton.setTitle("Add New Note", for: UIControlState())
        titleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        titleButton.setTitleColor(UIColor.white, for: UIControlState())
        navView.addSubview(titleButton)
        
        /* Meeting Title*/
        var meetingTitleLabel : UILabel = UILabel()
        meetingTitleLabel.frame = CGRect(x: 30, y: 15, width: 100, height: 20)
        meetingTitleLabel.text = "Meeting Title"
        meetingTitleLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        meetingTitleLabel.textColor = UIColor.black
        
        scrollView.addSubview(meetingTitleLabel)
        
       
        meetingTitleText.frame = CGRect(x: 30, y: meetingTitleLabel.frame.maxY + 3, width: ScreenSize.width - 60, height: 25)
        //meetingTitleText.placeholder = " Lorem Ipsum"
       // meetingTitleText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        meetingTitleText.textColor = UIColor.black
        meetingTitleText.font = SMLGlobal.sharedInstance.fontSize(12)
        //meetingTitleText.returnKeyType=UIReturnKeyType.Next
        meetingTitleText.layer.borderWidth = 1
        meetingTitleText.tag = 1;
        meetingTitleText.delegate = self
        meetingTitleText.layer.cornerRadius = meetingTitleText.frame.width * 0.015
        meetingTitleText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        scrollView.addSubview(meetingTitleText)
        
        var leftView = UIView()
        leftView.frame = CGRect(x: 0, y: 0, width: 5, height: 5);
        meetingTitleText.leftView = leftView;
        meetingTitleText.leftViewMode = UITextFieldViewMode.always;
        
        var meetingDateLabel : UILabel = UILabel()
        meetingDateLabel.frame = CGRect(x: 30, y: meetingTitleText.frame.maxY + 15, width: 100, height: 20)
        meetingDateLabel.text = "Meeting Date"
        meetingDateLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        meetingDateLabel.textColor = UIColor.black
        scrollView.addSubview(meetingDateLabel)
        
        
        
        meetingDateText.frame = CGRect(x: 30, y: meetingDateLabel.frame.maxY + 3, width: ScreenSize.width - 60, height: 25)
        meetingDateText.placeholder = " Ex:- 06/16/2016"
        meetingDateText.font = SMLGlobal.sharedInstance.fontSize(12)
        //meetingDateText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
         meetingDateText.textColor = UIColor.black
        //meetingDateText.enabled = false
        //meetingDateText.returnKeyType=UIReturnKeyType.Next
        meetingDateText.layer.borderWidth = 1
        meetingDateText.tag = 2;
        meetingDateText.delegate = self
        meetingDateText.layer.cornerRadius = meetingDateText.frame.width * 0.015
        meetingDateText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        
        //scrollView.addSubview(meetingDateText)
        
        
        
//        
        var meetingView : (UIView) = UIView()
        meetingView.frame = CGRect(x: 30, y: meetingDateLabel.frame.maxY + 3, width: ScreenSize.width - 60, height: 25)
        meetingView.layer.borderWidth = 1
        meetingView.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        meetingView.isUserInteractionEnabled = true
        meetingView.layer.cornerRadius = 2.0
        scrollView.isUserInteractionEnabled = true
        scrollView.addSubview(meetingView)
        
        selectedMeetingDate  = UILabel()
        selectedMeetingDate.frame = CGRect(x: 5, y: 0, width: 100, height: 20)
        selectedMeetingDate.text = "Ex:- 06/16/2016"
        selectedMeetingDate.font = SMLGlobal.sharedInstance.fontSize(12)
        selectedMeetingDate.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.4)
        //selectedMeetingDate.textColor = UIColor.blackColor()
        meetingView.addSubview(selectedMeetingDate)
        
        
        var calImageView : (UIImageView) = UIImageView()
        var image = UIImage(named: "meetindate_icon")
        calImageView.image = image
        calImageView.frame = CGRect(x: meetingView.frame.size.width - 30, y: 0, width: 25, height: 25)
        meetingView.addSubview(calImageView)
        
        
        var DobGesture = UITapGestureRecognizer()
        DobGesture .addTarget(self, action:#selector(addnewNote.DOBAction(_:)))
        meetingView.addGestureRecognizer(DobGesture)
        
        
        
        
        
        
        
        
        
        
        
        
        
        
//        var leftViewDate = UIView()
//        leftViewDate.frame = CGRectMake(0, 0, 5, 5);
//        meetingDateText.leftView = leftViewDate;
//        meetingDateText.leftViewMode = UITextFieldViewMode.Always;
//        
//      
//        var calButton = UIButton()
//        calButton.frame = CGRectMake(meetingDateText.frame.width - 30 , 0 , 25, 25)
//        calButton.setBackgroundImage(image, forState: .Normal)
//        
//        meetingDateText.addSubview(calButton)
        
        
        
        var descriptionLabel : UILabel = UILabel()
        descriptionLabel.frame = CGRect(x: 30, y: meetingDateText.frame.maxY + 15, width: 100, height: 20)
        descriptionLabel.text = "Description"
        descriptionLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        descriptionLabel.textColor = UIColor.black
        scrollView.addSubview(descriptionLabel)
        
      
        descriptionText.frame = CGRect(x: 30, y: descriptionLabel.frame.maxY + 3, width: ScreenSize.width - 60, height: 120)
        descriptionText.font = SMLGlobal.sharedInstance.fontSize(12)
        //descriptionText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        descriptionText.textColor = UIColor.black
        //descriptionText.returnKeyType=UIReturnKeyType.Done
        descriptionText.layer.borderWidth = 1
        descriptionText.delegate = self
        descriptionText.layer.cornerRadius = descriptionText.frame.width * 0.015
        descriptionText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        scrollView.addSubview(descriptionText)
        
        var saveButton: UIButton = UIButton()
        saveButton.frame = CGRect(x: ScreenSize.width / 2 - 105, y: descriptionText.frame.maxY + 20, width: 100, height: 35)
        saveButton.backgroundColor = ButtonBlueColor
        saveButton.setTitle("Add", for: UIControlState())
        saveButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        saveButton.layer.cornerRadius = 2.0
        //var saveImg = UIImage(named: "add_button")
       // saveButton.setBackgroundImage(saveImg, forState: .Normal)
        saveButton.addTarget(self, action: #selector(addnewNote.saveButtonClick(_:)), for: UIControlEvents.touchUpInside)
        scrollView.addSubview(saveButton)
        
        var cancleButton: UIButton = UIButton()
        cancleButton.frame = CGRect(x: ScreenSize.width / 2 + 5, y: descriptionText.frame.maxY + 20, width: 111, height: 35)
        cancleButton.backgroundColor = ButtonRedColor
        cancleButton.setTitle("Cancel", for: UIControlState())
        cancleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        cancleButton.layer.cornerRadius = 2.0
        //var cancleimg = UIImage(named: "popupcancel")
       // cancleButton.setBackgroundImage(cancleimg, forState: .Normal)
        cancleButton.addTarget(self, action: #selector(addnewNote.cancleButtonClick(_:)), for: UIControlEvents.touchUpInside)
        scrollView.addSubview(cancleButton)
        
        datePickerView = UIView()
        datePickerView.frame = CGRect(x: 0, y: ScreenSize.height - 250, width: ScreenSize.width, height: 250)
        datePickerView.backgroundColor = UIColor.white
        
        var doneBtn : UIButton!
        doneBtn = UIButton.init(type: UIButtonType.custom)
        doneBtn .setTitleColor(UIColor.black, for: UIControlState())
        
        doneBtn.setTitle("Done", for: UIControlState())
        doneBtn.frame = CGRect(x: 10, y: 5 , width: 50, height: 30)
        doneBtn .addTarget(self, action: #selector(addnewNote.DoneBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(doneBtn)
        
        
        
        var CancelBtn : UIButton!
        CancelBtn = UIButton.init(type: UIButtonType.custom)
        CancelBtn.setTitle("Cancel", for: UIControlState())
        CancelBtn .setTitleColor(UIColor.black, for: UIControlState())
        CancelBtn.frame = CGRect(x: datePickerView.frame.size.width - 80 ,y: 5, width: 70, height: 30)
        CancelBtn .addTarget(self, action: #selector(addnewNote.CancelBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(CancelBtn)
        
        
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: 50, width: ScreenSize.width, height: 200)
        
        datePicker.datePickerMode = UIDatePickerMode.date
        datePickerView.addSubview(datePicker)
        
        
                NotificationCenter.default.addObserver(self, selector: #selector(addnewNote.deleteText), name: NSNotification.Name.UITextFieldTextDidChange, object: meetingTitleText)
        NotificationCenter.default.addObserver(self, selector: #selector(addnewNote.deleteText), name: NSNotification.Name.UITextViewTextDidChange, object: descriptionText)
        
    }
    func deleteText() {
        if meetingTitleText.text?.characters.count == 0 {
            firstBlnkValue = 0
            meetingTitleText.text = ""
            
        }
        print(meetingTitleText.text)
    }
    func deltextView() {
        
        if descriptionText.text.characters.count == 0 {
            textViewVal = 0
            descriptionText.text = ""
            
        }
        print(descriptionText.text)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func DOBAction(_ sender : UIButton)
    {
        descriptionText.resignFirstResponder()
        meetingTitleText.resignFirstResponder()
       // scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + 30)
        //scrollView.contentOffset = CGPointMake(0, 0)
        self.view.addSubview(datePickerView)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        datePickerView.removeFromSuperview()
        if ScreenSize.height >= 667 {
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
        } else {
         scrollView.contentOffset = CGPoint(x: 0, y: 120)
        }
        meetingTitleText.resignFirstResponder()
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        datePickerView.removeFromSuperview()
      
        meetingTitleText.resignFirstResponder()
        if text == " "{
            if textView == descriptionText {
                textViewVal = 1
                
            } else {
                textViewVal = 0
            }
        }

       
        if(text == "\n")
        {
            scrollView.contentOffset = CGPoint(x: 0, y: 0)
            textView.resignFirstResponder()
        }
        
       
        
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        var c = meetingTitleText.text?.characters.count
        
        
        if string == " "
        {
            
            if textField == meetingTitleText {
                
                firstBlnkValue = 1
            }
            else {
                firstBlnkValue = 0
            }
        }
        else
        {
            
        }
        return true
    }
    
    func saveButtonClick(_ sender: UIButton)
    {
        
       noteValidation()
        if(self.checkTextFields())
        {
            if #available(iOS 10.0, OSX 10.12, *) {
                let appDel:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
                let context:NSManagedObjectContext = appDel.managedObjectContext!
                let addNotes = NSEntityDescription.insertNewObject(forEntityName: "MeetingFinder",into: context)
                
                addNotes.setValue(meetingTitleText.text! as NSString, forKey: "meetingName")
                addNotes.setValue(selectedMeetingDate.text! as NSString, forKey: "meetingDate")
                addNotes.setValue(descriptionText.text! as NSString, forKey: "meetingDescription")
                
                var array = NSArray()
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MeetingFinder");
        request.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(request)
                for task in results {
                    array = results as NSArray
                    // println(results)
                    var count : (Int) = array.count + 1
                }
                if(array.count > 0)
                {
                    addNotes.setValue("\(array.count)", forKey: "uniqueID")
                
                }
                else
                {
                    addNotes.setValue("0", forKey: "uniqueID")
                }
                do {
                    try context.save()
                } catch {
                }
                
                let alertView = UIAlertView(title: "", message: "Note Saved", delegate: self, cancelButtonTitle: "Ok")
                alertView.show()
            } catch let error
            {
                let alertView = UIAlertView(title: "Error", message: error.localizedDescription, delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
                print(error.localizedDescription)
            }
            }
            else
            {
                            }
//        var results = try context.execute(request)
//        var error: NSError?
//        if let result = results {
//            array = result
//           // println(results)
//            var count : (Int) = array.count + 1
//            
//        } else
//        {
//           //println("Could not fetch \(error), \(error!.userInfo)")
//        }
//        
//        if(array.count > 0)
//        {
//            addNotes.setValue("\(array.count)", forKey: "uniqueID")
//            
//        }
//        else
//        {
//            addNotes.setValue("0", forKey: "uniqueID")
//        }
//
//        context.save()
//        
//        
//
//        if let err = error
//        {
//            
//            var alertView = UIAlertView(title: "Error", message: err.localizedFailureReason, delegate: nil, cancelButtonTitle: "Ok")
//            alertView.show()
//            
//        } else
//        {
//            var alertView = UIAlertView(title: "", message: "Note Saved", delegate: self, cancelButtonTitle: "Ok")
//            alertView.show()
//            
//            
//        }
        }
       
    }
    
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    
       // println("Save Button")



    
    
    func checkTextFields()->Bool
    {
        if(meetingTitleText.text == "" || firstBlnkValue == 1)
        {
            let alertView = UIAlertView (title: "", message: "Please enter Meeting Title", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            meetingTitleText.text = ""
            return false;
        }
        else if(selectedMeetingDate.text == "Ex:- 06/16/2016")
        {
            let alertView = UIAlertView (title: "", message: "Please enter date", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            return false;
        }
        
        else if(descriptionText.text == "" || desVal == 1)
        {
            let alertView = UIAlertView (title: "", message: "Please enter description", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            descriptionText.text = ""
            return false;
        }
        else
        {
            return true
        }
    }
    func cancleButtonClick(_ sender: UIButton) {
        //println("Cancle Button")
        
         self.navigationController?.popViewController(animated: false)
    }
    func homeClick(_ sender: UIButton) {
        self.navigationController!.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: false)
    }
    
    func CancelBtnAction(_ sender : UIButton)
    {
        datePickerView .removeFromSuperview()
        scrollView.frame = CGRect(x: 0, y: navView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height)
        
       
    }
    func DoneBtnAction(_ sender : UIButton)
    {
        scrollView.frame = CGRect(x: 0, y: navView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height)
        
        var pickerDate : (Date) = datePicker.date
        var currentDate = Date()
        
        
        
        
        var DF = DateFormatter()
        DF.dateFormat = "yyyy-MM-dd hh:mm:ss"
        var dateStr = DF.string(from: pickerDate)
        
        
        var selectedDate : (Date) = DF.date(from: dateStr)!
        DF.dateFormat = "MM-dd-yyyy"
        var selectedDateStr : (NSString) = DF.string(from: selectedDate) as (NSString)
        selectedMeetingDate.text = selectedDateStr as String
        selectedMeetingDate.textColor = UIColor.black
        
        datePickerView .removeFromSuperview()
       
//        if(pickerDate .compare(currentDate) == NSComparisonResult.OrderedSame)
//        {
//            var DF = NSDateFormatter()
//            DF.dateFormat = "yyyy-MM-dd hh:mm:ss"
//            var dateStr = DF.stringFromDate(pickerDate)
//            
//            
//            var selectedDate : (NSDate) = DF.dateFromString(dateStr)!
//            DF.dateFormat = "MM-dd-yyyy"
//            var selectedDateStr : (NSString) = DF.stringFromDate(selectedDate)
//            selectedMeetingDate.text = selectedDateStr as String
//            selectedMeetingDate.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
//            
//            datePickerView .removeFromSuperview()
//        }
//        else if(pickerDate .compare(currentDate) == NSComparisonResult.OrderedDescending)
//        {
//            
//           
//           
//        }
//        else
//        {
//            var alertView = UIAlertView(title: "Wrong Choice", message: "Past date can't be chosen as a Date of Meeting.", delegate: nil, cancelButtonTitle: "Ok")
//            alertView.show()
//        }
        
        
//        if(pickerDate .compare(currentDate) == NSComparisonResult.OrderedAscending)
//        {
//            
//           
//            //println(NSComparisonResult.OrderedDescending)
//            
//        }
        
        
        
        
        
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        datePickerView.removeFromSuperview()
        //meetingDateText.resignFirstResponder()
        meetingTitleText.resignFirstResponder()
        descriptionText.resignFirstResponder()
//        if(textField.tag == 2)
//        {
//            
//            
//            self.view.addSubview(datePickerView)
//        }
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        
        scrollView.contentOffset = CGPoint(x: 0, y: 0)
        textField.resignFirstResponder()
//        meetingTitleText.resignFirstResponder()
//        meetingDateText.resignFirstResponder()
//        descriptionText.resignFirstResponder()
       
        datePickerView .removeFromSuperview()
        return true
    }
    
    func  touchesBegan(_ touches: Set<NSObject>, with event: UIEvent)
    {
        
        view.endEditing(true)
        super.touchesBegan(touches as! Set<UITouch>, with: event)
    }
    
    func noteValidation() {
        
        var  textField: UITextField!
        
        var str = meetingTitleText.text! as NSString
        var str1 = descriptionText.text! as NSString
        
        //        var firstBlnkValue = 0
        //        var textViewVal = 0
        //        var desVal = 0
        
        var d = 32 as unichar
        
        
        if (meetingTitleText.text?.characters.count)! > 2 {
            
            if str == "" {
                firstBlnkValue = 0
                
                //println("Sk Rejabul")
            } else {
                var value = str.substring(with: NSRange(location: 0, length: 1))
                var c:unichar = str.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue = 1
                    
                } else {
                    firstBlnkValue = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if meetingTitleText.text?.characters.count == 1 {
            
            var c:unichar = str.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue = 1
                
            } else {
                firstBlnkValue = 0
                
            }
        }
        if descriptionText.text.characters.count > 2 {
            
            if str1 == "" {
                desVal = 0
                
                //println("Sk Rejabul")
            } else {
                var value = str1.substring(with: NSRange(location: 0, length: 1))
                var c:unichar = str1.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    desVal = 1
                    
                } else {
                    desVal = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if descriptionText.text.characters.count == 1 {
            
            var c:unichar = str1.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                desVal = 1
                
            } else {
                desVal = 0
                
            }
        }
        
        
    }

    
}
