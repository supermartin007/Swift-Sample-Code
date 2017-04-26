//
//  meetingNotes.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 09/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import CoreData
var meetingNamemeetingNotes = UILabel()
var meetingDatemeetingNotes = UILabel()
var meetingDescriptionmeetingNotes = UILabel()


class meetingNotes: UIViewController, UITextFieldDelegate,UITextViewDelegate,UIAlertViewDelegate {
    
   // var meetingDateText : UITextField = UITextField()
    var backView : UIView = UIView()
    var scrollView : UIScrollView = UIScrollView()
    var navView: UIView = UIView()
    var datePickerView : UIView!
    var datePicker : UIDatePicker!
    var meetingTitleText : UITextField = UITextField()
    var firstBlnkValue = 0
    var desVal = 0
   // let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
     var descriptionText : UITextView = UITextView()
    
    var selectedMeetingDate : (UILabel)!
    
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
        
        var navHeight = navView.frame.height
        var navMid = navHeight / 2 - 15
        
        /* Home Button*/
        
        var leftButton: UIButton = UIButton()
        leftButton.frame = CGRect(x: 20, y: navMid + 13, width: 20, height: 20)
        var img = UIImage(named: "back_errow")
        leftButton.setBackgroundImage(img, for: UIControlState())
        leftButton.addTarget(self, action: #selector(meetingNotes.homeClick(_:)), for: UIControlEvents.touchUpInside)
        navView.addSubview(leftButton)
        var titlepos = ScreenSize.width / 2 - 60
        
        /* Navigation Title*/
        
        var titleButton: UIButton = UIButton()
        titleButton.frame = CGRect(x: titlepos - 2, y: navMid + 10, width: 120, height: 30)
        titleButton.setTitle("Meeting Notes", for: UIControlState())
        titleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        titleButton.setTitleColor(UIColor.white, for: UIControlState())
        navView.addSubview(titleButton)
        
        /* Meeting Title*/
        var meetingTitleLabel : UILabel = UILabel()
        meetingTitleLabel.frame = CGRect(x: 30, y: 20, width: 100, height: 20)
        meetingTitleLabel.text = "Meeting Title"
        meetingTitleLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        meetingTitleLabel.textColor = UIColor.black
        
        scrollView.addSubview(meetingTitleLabel)
        
        
        meetingTitleText.frame = CGRect(x: 30, y: meetingTitleLabel.frame.maxY + 1, width: ScreenSize.width - 60, height: 25)
        //meetingTitleText.placeholder = " Lorem Ipsum"
         meetingTitleText.textColor = UIColor.black
         meetingTitleText.text =  meetingNamemeetingNotes.text
        meetingTitleText.font = SMLGlobal.sharedInstance.fontSize(12)
        meetingTitleText.layer.borderWidth = 1
        meetingTitleText.delegate = self
        meetingTitleText.layer.cornerRadius = meetingTitleText.frame.width * 0.015
        meetingTitleText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        scrollView.addSubview(meetingTitleText)
        
        
        
        var left : (UIView) = UIView ()
        left.frame = CGRect(x: 0, y: 0, width: 5, height: 5)
        meetingTitleText.leftView = left
        meetingTitleText.leftViewMode = UITextFieldViewMode.always
        
        var meetingDateLabel : UILabel = UILabel()
        meetingDateLabel.frame = CGRect(x: 30, y: meetingTitleText.frame.maxY + 10, width: 100, height: 20)
        meetingDateLabel.text = "Meeting Date"
        meetingDateLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        meetingDateLabel.textColor = UIColor.black
        //meetingDateLabel.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.4)
        scrollView.addSubview(meetingDateLabel)
        
        
//        meetingDateText.frame = CGRectMake(30, CGRectGetMaxY(meetingDateLabel.frame) + 1, ScreenSize.width - 60, 25)
//        meetingDateText.text = meetingDatemeetingNotes.text
//        meetingDateText.font = SMLGlobal.sharedInstance.fontSize(12)
//        meetingDateText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
//        meetingDateText.layer.borderWidth = 1
//        meetingDateText.delegate = self
//        meetingDateText.layer.cornerRadius = meetingDateText.frame.width * 0.015
//        meetingDateText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).CGColor
        
        //scrollView.addSubview(meetingDateText)
        
        var image = UIImage(named: "clander")
//        var calButton = UIButton()
//        calButton.frame = CGRectMake(meetingDateText.frame.width - 30 , 0 , 25, 25)
//        calButton.setBackgroundImage(image, forState: .Normal)
        
        //meetingDateText.addSubview(calButton)
        
        
        
        
        
        var meetingView : (UIView) = UIView()
        meetingView.frame = CGRect(x: 30, y: meetingDateLabel.frame.maxY + 3, width: ScreenSize.width - 60, height: 25)
        meetingView.layer.borderWidth = 1
        meetingView.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        meetingView.isUserInteractionEnabled = true
        meetingView.layer.cornerRadius = 2.0
        scrollView.isUserInteractionEnabled = true
        scrollView.addSubview(meetingView)
        
        selectedMeetingDate = UILabel()
        selectedMeetingDate.frame = CGRect(x: 5, y: 0, width: 100, height: 20)
        selectedMeetingDate.text = meetingDatemeetingNotes.text
        selectedMeetingDate.font = SMLGlobal.sharedInstance.fontSize(12)
        selectedMeetingDate.textColor = UIColor.black
        meetingView.addSubview(selectedMeetingDate)
        
        
        var calImageView : (UIImageView) = UIImageView()
        //var image = UIImage(named: "meetindate_icon")
        calImageView.image = image
        calImageView.frame = CGRect(x: meetingView.frame.size.width - 30, y: 0, width: 25, height: 25)
        meetingView.addSubview(calImageView)
        
        
        var DobGesture = UITapGestureRecognizer()
        DobGesture .addTarget(self, action:#selector(meetingNotes.DOBAction(_:)))
        meetingView.addGestureRecognizer(DobGesture)
//        var DobGesture = UITapGestureRecognizer()
//        DobGesture .addTarget(self, action:"DOBAction:")
//        calButton.addGestureRecognizer(DobGesture)
        
        var descriptionLabel : UILabel = UILabel()
        descriptionLabel.frame = CGRect(x: 30, y: meetingView.frame.maxY + 10, width: 100, height: 20)
        descriptionLabel.text = "Description"
        descriptionLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        descriptionLabel.textColor = UIColor.black
        scrollView.addSubview(descriptionLabel)
        
       
        descriptionText.frame = CGRect(x: 30, y: descriptionLabel.frame.maxY + 1, width: ScreenSize.width - 60, height: 120)
        descriptionText.font = SMLGlobal.sharedInstance.fontSize(12)
        descriptionText.textColor = UIColor.black
        descriptionText.text = meetingDescriptionmeetingNotes.text
        //descriptionText.textAlignment =
        descriptionText.layer.borderWidth = 1
        descriptionText.delegate = self
        
        descriptionText.layer.cornerRadius = descriptionText.frame.width * 0.015
        descriptionText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        
        scrollView.addSubview(descriptionText)
        
        if pass == 0 {
            meetingTitleText.isEnabled = false
            descriptionText.isEditable = false
            meetingView.isUserInteractionEnabled = false
        } else if pass == 1 {
            meetingTitleText.isEnabled = true
            descriptionText.isEditable = true
            meetingView.isUserInteractionEnabled = true
            
            var saveButton: UIButton = UIButton()
            saveButton.frame = CGRect(x: ScreenSize.width / 2 - 105, y: descriptionText.frame.maxY + 20, width: 100, height: 35)
            //var saveImg = UIImage(named: "send_button")
            //saveButton.setBackgroundImage(saveImg, forState: .Normal)
            saveButton.backgroundColor = ButtonBlueColor
            saveButton.setTitle("Save", for: UIControlState())
            saveButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
            saveButton.layer.cornerRadius = 2.0
            saveButton.addTarget(self, action: #selector(meetingNotes.saveButtonClick(_:)), for: UIControlEvents.touchUpInside)
            scrollView.addSubview(saveButton)
            
            var cancleButton: UIButton = UIButton()
            cancleButton.frame = CGRect(x: ScreenSize.width / 2 + 5, y: descriptionText.frame.maxY + 20, width: 100, height: 35)
            //var cancleimg = UIImage(named: "cancel")
            //cancleButton.setBackgroundImage(cancleimg, forState: .Normal)
            cancleButton.backgroundColor = ButtonRedColor
            cancleButton.setTitle("Cancel", for: UIControlState())
            cancleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
            cancleButton.layer.cornerRadius = 2.0
            cancleButton.addTarget(self, action: #selector(meetingNotes.cancleButtonClick(_:)), for: UIControlEvents.touchUpInside)
            scrollView.addSubview(cancleButton)
        }
        
        
        
        datePickerView = UIView()
        datePickerView.frame = CGRect(x: 0, y: self.view.frame.size.height - 250, width: ScreenSize.width, height: 250)
        datePickerView.backgroundColor = UIColor.white
        
        var doneBtn : UIButton!
        doneBtn = UIButton.init(type: UIButtonType.custom)
        doneBtn .setTitleColor(UIColor.black, for: UIControlState())
        
        doneBtn.setTitle("Done", for: UIControlState())
        doneBtn.frame = CGRect(x: 10, y: 5 , width: 50, height: 30)
        doneBtn .addTarget(self, action: #selector(meetingNotes.DoneBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(doneBtn)
        
        
        
        var CancelBtn : UIButton!
        CancelBtn = UIButton.init(type: UIButtonType.custom)
        CancelBtn.setTitle("Cancel", for: UIControlState())
        CancelBtn .setTitleColor(UIColor.black, for: UIControlState())
        CancelBtn.frame = CGRect(x: datePickerView.frame.size.width - 80 ,y: 5, width: 70, height: 30)
        CancelBtn .addTarget(self, action: #selector(meetingNotes.CancelBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(CancelBtn)
        
        
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: 50, width: ScreenSize.width, height: 200)
        
        datePicker.datePickerMode = UIDatePickerMode.date
        datePickerView.addSubview(datePicker)
        
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        meetingTitleText.resignFirstResponder()
        datePickerView.removeFromSuperview()
        
         return true
    }
    
    
   
        
   
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
       
        
        meetingTitleText.resignFirstResponder()
        datePickerView.removeFromSuperview()
        if(text  == "\n")
        {
            descriptionText.resignFirstResponder()
        }
        
        return true
}
   
        
        
 
    

        
        
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func DOBAction(_ sender : UIButton)
    {
        meetingTitleText.resignFirstResponder()
        descriptionText.resignFirstResponder()
        //scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, scrollView.contentOffset.y + 30)
        //scrollView.contentOffset = CGPointMake(0, 0)
        self.view.addSubview(datePickerView)
    }
    
    
    
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
            let alertView = UIAlertView (title: "", message: "Please enter Date", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            return false;
        }
            
        else if(descriptionText.text == "" || desVal == 1)
        {
            let alertView = UIAlertView (title: "", message: "Please enter Description", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            descriptionText.text = ""
            return false;
        }
        else
        {
            return true
        }
    }

    
    
    func saveButtonClick(_ sender: UIButton) {
        
        /*self.noteValidation()
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
        }*/
        
        self.noteValidation()
        if checkTextFields() {
        var value = valu
      
        var appDel:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
            var context : NSManagedObjectContext!
            if #available(iOS 10.0, *) {
                context = appDel.managedObjectContext!
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 10.0, OSX 10.12, *) {
                let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MeetingFinder");
                request.returnsObjectsAsFaults = false
                do {
                    let results = try context.fetch(request)
                    for result in results
                    {
                    print(results)
                    let ids = (result as AnyObject).value(forKey: "uniqueID") as! String
                    print(ids)
                    print(valu)
                        if ids == valu {
                            context.delete(result as! NSManagedObject)
                        }
                    }
                    //}
//                    do {
//                        try context.save()
//                    } catch {
//                    }
                    var error : NSError? = nil
                    
                }
                 catch let error {
                    print(error.localizedDescription)
                }
            }
            
//        var request = NSFetchRequest(entityName:"MeetingFinder")
//        request.returnsObjectsAsFaults = false
//        var results = context.executeFetchRequest(request, error: nil)
//        if (results?.count > 0) {
//            for result: AnyObject in results! {
//                if let user = result.valueForKey("uniqueID") as? String {
//                    if user == valu {
//                        context.deleteObject(result as! NSManagedObject)
//                    }
//                }
//                context.save(nil)
//            }
//        }
            let entityDescription = NSEntityDescription.entity(forEntityName: "MeetingFinder",in: context!)
            let task = MeetingFinder(entity: entityDescription!, insertInto: context)
            //task.desc = txtDesc.text
            //
            task.meetingName = meetingTitleText.text!
            task.meetingDate = selectedMeetingDate.text!
    
            task.meetingDescription = descriptionText.text
             task.uniqueID = value
            
//            do {
//                try context.save()
//            } catch {
//            }
            
            //managedObjectContext?.save(nil)
            
            
            var error: NSError?
            //managedObjectContext?.save(&error)
            
            if let err = error {
                
                var alertView = UIAlertView(title: "Error", message: err.localizedFailureReason, delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
                
            } else {
                var alertView = UIAlertView(title: "", message: "Note Saved", delegate: self, cancelButtonTitle: "Ok")
                alertView.show()
                valu = ""
                
                //println(task.meetingName)
            }
        }

        
    }
    func cancleButtonClick(_ sender: UIButton) {
        
          self.navigationController?.popViewController(animated: false)
        //println("Cancle Button")
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
//        if(pickerDate .compare(currentDate) == NSComparisonResult.OrderedAscending)
//        {
//            //println(NSComparisonResult.OrderedDescending)
//            
//        }
//        else
//        {
//            
//            
//            var alertView = UIAlertView(title: "", message: "Past date can't be chosen as a Date of birth.", delegate: nil, cancelButtonTitle: "Ok")
//            alertView.show()
//        }
//        
        
        
        
        
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        
        return true
    }
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
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
                self.firstBlnkValue = 1
                
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
