//
//  sobrietyCalculatorViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 22/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class sobrietyCalculatorViewController: UIViewController {
    var selectedMeetingDate = UITextField()
    
    var backgroundScrollView : UIScrollView!
    var profileImgView : UIImageView!
    
     var datePicker : UIDatePicker!
    var datePickerView = UIView()
     var customView =  UIView()
  var navigationView = UIView()
    
    var valueSober : (UILabel)!
    var  valueAttendedMeeting : (UILabel)!
    var  valueaddedMeeting  : (UILabel)!
    
    var daysCalculate : (Int)!
    var monthsCalculate : (Int)!
    var yearsCalculate : (Int)!
    
    var dayValueLabel : (UILabel)!
    var monthsValueLabel : (UILabel)!
    var yearsValueLabel : (UILabel)!
    
    
    var dateLabel: (UILabel)!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        var  appUser : (SMLAppUser) = SMLAppUser.getUser()
        
        
        self.view.backgroundColor = UIColor.white
        //CustomView
        var profileHeight = ScreenSize.height/4 + 50
        
       
        customView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        customView.backgroundColor = UIColor(red: 0/255.0, green: 136/255.0, blue: 206 / 255.0, alpha:1.0)
        self.view.addSubview(customView)
        
        //navigationView
      
        navigationView.frame = CGRect(x: 0, y: 25, width: ScreenSize.width, height: 44)
        navigationView.backgroundColor = UIColor(red: 59.0/255.0, green: 187.0/255.0, blue: 250.0/255.0, alpha:1.0)
        customView.addSubview(navigationView)
        
        
        //Profile Title
        var titleLabel = UILabel()
        titleLabel.text = "Sobriety Calculator"
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.frame = CGRect(x: 30, y: (navigationView.frame.size.height-30)/2, width: navigationView.frame.size.width - 60, height: 30)
        titleLabel.textColor = UIColor.white
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(13)
        navigationView.addSubview(titleLabel)
        
        
        //backBtn
        
        var backBtn :(UIButton) = UIButton.init(type: UIButtonType.custom)
        backBtn.frame = CGRect(x: 5, y: (navigationView.frame.size.height-40)/2, width: 40, height: 40)
        backBtn.addTarget(self, action: #selector(sobrietyCalculatorViewController.backBtnAction(_:)), for: UIControlEvents.touchUpInside)
        backBtn.setImage(UIImage(named: "home"), for: UIControlState())
        navigationView.addSubview(backBtn)
        
        
        
        backgroundScrollView = UIScrollView()
        backgroundScrollView.frame = CGRect(x: 0, y: navigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height )
        backgroundScrollView.isScrollEnabled = true
        self.view.addSubview(backgroundScrollView)
        
        
        
        var profilebackView = UIView()
        profilebackView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 120)
        profilebackView.backgroundColor =  UIColor(red: 0/255.0, green: 136/255.0, blue: 206 / 255.0, alpha:1.0)
        backgroundScrollView.addSubview(profilebackView)
        
        
        
        
        
        //ProfileImageView
        profileImgView = UIImageView()
        let profileStr : (NSString) = appUser.profilePic
        print(profileStr)
        if(profileStr == "")
        {
            profileImgView.image = UIImage(named: "")
            
        }
        else
        {
            
            var profileUrl : (URL) = URL(string: NSString(format: "%@", profileStr) as String)!
            profileImgView.sd_setImage(with: profileUrl)
        }
        
        
        profileImgView.frame = CGRect(x: 50, y: 25, width: 70, height: 70)
        profileImgView.clipsToBounds = true
        profileImgView.backgroundColor = UIColor.gray
        profileImgView.layer.cornerRadius = profileImgView.frame.size.width/2
        profileImgView.isUserInteractionEnabled = false
        profilebackView.addSubview(profileImgView)
        
        
        var userName  = UILabel()
        var userNameStr : (NSString) =  "\(appUser.firstName)  \(appUser.lastName)" as (NSString)
        //println(userNameStr)
        userName.text = userNameStr as String
        userName.textAlignment = NSTextAlignment.left
        userName.frame = CGRect(x: profileImgView.frame.maxX + 10, y: 35, width: customView.frame.size.width, height: 20)
        userName.font = SMLGlobal.sharedInstance.fontSize(15)
        userName.textColor = UIColor.white
        profilebackView.addSubview(userName)
        
       // println("Hello   \(customView.frame.size.width)")
        
        //Email
        var email  = UILabel()
        email.text = appUser.email as String
        email.textAlignment = NSTextAlignment.left
        email.frame = CGRect(x: profileImgView.frame.maxX + 10, y: userName.frame.maxY+3, width: customView.frame.size.width, height: 15)
        email.font = SMLGlobal.sharedInstance.fontSize(12)
        email.textColor = UIColor.white
        profilebackView.addSubview(email)
        
        
        var soberDayView = UIView()
        soberDayView.frame = CGRect(x: 0, y: profilebackView.frame.maxY, width: ScreenSize.width, height: 60)
        soberDayView.backgroundColor = UIColor.gray
        backgroundScrollView.addSubview(soberDayView)
        
        var btnwdth = ScreenSize.width / 3
        var soberDay = UIButton.init(type: UIButtonType.custom)
        soberDay.frame = CGRect(x: 0, y: 0, width: btnwdth, height: 60)
        soberDay.setTitle("Sober Day", for: UIControlState())
        soberDay.backgroundColor = UIColor(red: 195 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
        soberDay.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(10)
        soberDay.setTitleColor(UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5), for: UIControlState())
        soberDay.titleEdgeInsets = UIEdgeInsetsMake(10, btnwdth / 2 - 40, 35, btnwdth / 2 - 30)
        soberDayView.addSubview(soberDay)
        
        var imageSober : UIImageView = UIImageView()
        imageSober.frame = CGRect(x: (btnwdth - 24) / 2 ,y: soberDay.frame.height - 33, width: 24, height: 24)
        //imageSober.image = UIImage(named: "circle")
        soberDay.addSubview(imageSober)
        
        valueSober = UILabel()
        valueSober.frame = CGRect(x: 0, y: soberDay.frame.height - 33,width: soberDay.frame.size.width - 8 , height: 20)
        valueSober.text = "0"
        valueSober.textAlignment = NSTextAlignment.center
        valueSober.font = SMLGlobal.sharedInstance.fontSize(14)
        valueSober.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        soberDay.addSubview(valueSober)
        
        var attendedMeeting = UIButton.init(type: UIButtonType.custom)
        attendedMeeting.frame = CGRect(x: btnwdth  , y: 0, width: btnwdth, height: 60)
         attendedMeeting.backgroundColor = UIColor(red: 242 / 255, green: 242 / 255, blue: 242 / 255, alpha: 1)
        attendedMeeting.setTitle("Attended Meeting", for: UIControlState())
        attendedMeeting.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(10)
        attendedMeeting.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 35,10)
        attendedMeeting.setTitleColor(UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5), for: UIControlState())
        soberDayView.addSubview(attendedMeeting)
        
        var imageattendedMeeting : UIImageView = UIImageView()
        imageattendedMeeting.frame = CGRect(x: (btnwdth - 24) / 2 ,y: soberDay.frame.height - 33, width: 24, height: 24)
       // imageattendedMeeting.image = UIImage(named: "circle")
        //attendedMeeting.addSubview(imageattendedMeeting)
        
        valueAttendedMeeting = UILabel()
        valueAttendedMeeting.frame = CGRect(x: 0, y: soberDay.frame.height - 33, width: soberDay.frame.size.width, height: 20)
        valueAttendedMeeting.text = "0"
        valueAttendedMeeting.textAlignment  =  .center
        //varvalueAttendedMeeting.center =
        valueAttendedMeeting.font = SMLGlobal.sharedInstance.fontSize(14)
        valueAttendedMeeting.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        attendedMeeting.addSubview(valueAttendedMeeting)
        
        var addedMeeting = UIButton.init(type: UIButtonType.custom)
        addedMeeting.frame = CGRect(x: (btnwdth * 2) + 0.5, y: 0, width: btnwdth, height: 60)
        addedMeeting.setTitle("Added Meeting", for: UIControlState())
        addedMeeting.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(10)
         addedMeeting.backgroundColor = UIColor(red: 242 / 255, green: 242 / 255, blue: 242 / 255, alpha: 1)
        addedMeeting.titleEdgeInsets = UIEdgeInsetsMake(10, 10, 35, 10)
        addedMeeting.setTitleColor(UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5), for: UIControlState())
        soberDayView.addSubview(addedMeeting)
        
        var imageaddedMeeting : UIImageView = UIImageView()
        imageaddedMeeting.frame = CGRect(x: (btnwdth - 24) / 2 ,y: soberDay.frame.height - 33, width: 24, height: 24)
       // imageaddedMeeting.image = UIImage(named: "circle")
       // addedMeeting.addSubview(imageaddedMeeting)
        
        valueaddedMeeting = UILabel()
        valueaddedMeeting.frame = CGRect(x: 0, y: soberDay.frame.height - 33, width: soberDay.frame.size.width, height: 20)
        valueaddedMeeting.text = "0"
        valueaddedMeeting.textAlignment = NSTextAlignment.center
        valueaddedMeeting.font = SMLGlobal.sharedInstance.fontSize(14)
        valueaddedMeeting.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        addedMeeting.addSubview(valueaddedMeeting)
        
        
        
        var dateSelectView  = UIView()
        dateSelectView.frame = CGRect(x: 20, y: soberDayView.frame.maxY + 20, width: ScreenSize.width - 40, height: 40)
        dateSelectView.layer.borderColor = UIColor.lightGray.cgColor
        dateSelectView.layer.borderWidth = 1.0
        dateSelectView.layer.cornerRadius = 5.0
        backgroundScrollView.addSubview(dateSelectView)
        
        
        
        
        dateLabel  = UILabel()
        dateLabel.frame = CGRect(x: 10, y: 0, width: ScreenSize.width - 40, height: 40)
        dateLabel.text  = "Select Date"
        dateLabel.textColor = UIColor.lightGray
        dateLabel.textAlignment = NSTextAlignment.left
//        dateLabel.layer.borderColor = UIColor.blackColor().CGColor
//        dateLabel.layer.borderWidth = 1.0
//        dateLabel.layer.cornerRadius = 5.0
        dateSelectView.addSubview(dateLabel)
        
        
        var  image = UIImage(named: "clander")
        var imageViewCalender = UIImageView(frame: CGRect(x: dateSelectView.frame.size.width - 40 , y: 7 , width: 25, height: 25))
        imageViewCalender.image = image
        dateSelectView.addSubview(imageViewCalender)
        
        
        
        var tapGesture : (UITapGestureRecognizer) = UITapGestureRecognizer(target: self, action: #selector(sobrietyCalculatorViewController.DateGesture(_:)))
        dateSelectView.addGestureRecognizer(tapGesture)
        
        
        
        
        
        
        
        datePickerView = UIView()
        if ScreenSize.height == 480 {
            datePickerView.frame = CGRect(x: 0, y: dateSelectView.frame.maxY , width: ScreenSize.width, height: 250)
        }
        else
        {
         datePickerView.frame = CGRect(x: 0, y: dateSelectView.frame.maxY + 20, width: ScreenSize.width, height: 250)
        }
        
        datePickerView.backgroundColor = UIColor.white
        
        
        var doneBtn : UIButton!
        doneBtn = UIButton.init(type: UIButtonType.custom)
        doneBtn .setTitleColor(UIColor.black, for: UIControlState())
        
        doneBtn.setTitle("Done", for: UIControlState())
        doneBtn.frame = CGRect(x: 10, y: 5 , width: 50, height: 30)
        doneBtn .addTarget(self, action: #selector(sobrietyCalculatorViewController.PickerDoneBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(doneBtn)
        
        
        
       
        
        
        
        var CancelBtn : UIButton!
        CancelBtn = UIButton.init(type: UIButtonType.custom)
        CancelBtn.setTitle("Cancel", for: UIControlState())
        CancelBtn .setTitleColor(UIColor.black, for: UIControlState())
        CancelBtn.frame = CGRect(x: datePickerView.frame.size.width - 80 ,y: 5, width: 70, height: 30)
        CancelBtn .addTarget(self, action: #selector(sobrietyCalculatorViewController.PickerCancelBtnAction(_:)), for: UIControlEvents.touchUpInside)
        datePickerView.addSubview(CancelBtn)
        
        
        datePicker = UIDatePicker()
        datePicker.frame = CGRect(x: 0, y: 50, width: ScreenSize.width, height: 200)
        datePicker.datePickerMode = UIDatePickerMode.date
        
       
        [datePickerView.addSubview(datePicker)]
        
        
        
//        var doneBtn : UIButton!
//        doneBtn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
//        doneBtn .setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
//        
//        doneBtn.setTitle("Done", forState: UIControlState.Normal)
//        doneBtn.frame = CGRectMake(ScreenSize.width - 50, datePickerView.frame.height - 30 , 50, 20)
//        doneBtn.titleLabel!.font = SMLGlobal.sharedInstance.fontSize(12)
//       
//        //doneBtn.backgroundColor = UIColor.grayColor()
//        doneBtn .addTarget(self, action: "DoneBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
//         doneBtn.titleLabel?.textAlignment = NSTextAlignment.Left
       // datePickerView.addSubview(doneBtn)
        
        var textLabel : UILabel = UILabel()
        textLabel.frame = CGRect(x: 20, y: dateSelectView.frame.maxY + 20, width: 150, height: 20)
        textLabel.text = "I've been Sober for"
        textLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        backgroundScrollView.addSubview(textLabel)
        
       
        
        var calender = UIView()
        calender.frame = CGRect(x: 10, y: textLabel.frame.maxY + 20, width: ScreenSize.width-20 , height: 150)
        calender.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 1)
         backgroundScrollView.addSubview(calender)
        
        var calenderWidth = (calender.frame.size.width - 60)/3
      
        
        
        //Years
        var yearView : (UIView) = UIView()
        yearView.backgroundColor = UIColor.white
        yearView.frame = CGRect(x: 20, y: 20, width: calenderWidth, height: 100)
        calender.addSubview(yearView)
        
        var yearImageView : (UIImageView) = UIImageView()
        yearImageView.image = UIImage(named:"circle1")
        yearImageView.frame =  CGRect(x: (yearView.frame.size.width - 30)/2, y: 10, width: 30, height: 30)
        //yearView.addSubview(yearImageView)
        
        yearsValueLabel = UILabel()
        yearsValueLabel.text = "0"
        yearsValueLabel.textAlignment = NSTextAlignment.center
        yearsValueLabel.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        yearsValueLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        yearsValueLabel.frame = CGRect(x: 0, y: 10, width: yearView.frame.size.width, height: 30)
        yearView.addSubview(yearsValueLabel)
        
        var yearsLabel = UILabel()
        yearsLabel.text = "Year"
        yearsLabel.textAlignment = NSTextAlignment.center
        yearsLabel.textColor = UIColor.black
        yearsLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        yearsLabel.frame = CGRect(x: 0, y: yearsValueLabel.frame.maxY+5,width: yearView.frame.size.width , height: 30)
        yearView.addSubview(yearsLabel)
        
        
        
        var monthView : (UIView) = UIView()
        monthView.backgroundColor = UIColor.white
        monthView.frame = CGRect(x: yearView.frame.maxX+10, y: 20, width: calenderWidth, height: 100)
        calender.addSubview(monthView)
        
        var monthImageView : (UIImageView) = UIImageView()
        monthImageView.image = UIImage(named:"circle1")
        monthImageView.frame =  CGRect(x: (yearView.frame.size.width - 30)/2, y: 10, width: 30, height: 30)
        //monthView.addSubview(monthImageView)
        
        
       
       
        
        monthsValueLabel = UILabel()
        monthsValueLabel.frame = CGRect(x: 0, y: 10, width: monthView.frame.size.width, height: 30)
        monthsValueLabel.text = "0"
        monthsValueLabel.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        monthsValueLabel.textAlignment = NSTextAlignment.center
        monthsValueLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        monthView.addSubview(monthsValueLabel)
        
        var monthLabel = UILabel()
        monthLabel.text = "Months"
        monthLabel.textColor = UIColor.black
        monthLabel.textAlignment = NSTextAlignment.center
        monthLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        monthLabel.frame = CGRect(x: 0, y: monthsValueLabel.frame.maxY+5,width: yearView.frame.size.width , height: 30)
        monthView.addSubview(monthLabel)
        
        var dayView : (UIView) = UIView()
        dayView.backgroundColor = UIColor.white
        dayView.frame = CGRect(x: monthView.frame.maxX+10, y: 20, width: calenderWidth, height: 100)
        calender.addSubview(dayView)
        
        var dayImageView : (UIImageView) = UIImageView()
        dayImageView.image = UIImage(named:"circle1")
        dayImageView.frame =  CGRect(x: (yearView.frame.size.width - 30)/2, y: 10, width: 30, height: 30)
       // dayView.addSubview(dayImageView)
        
        dayValueLabel = UILabel()
        dayValueLabel.frame = CGRect(x: 0, y: 10, width: dayView.frame.size.width, height: 30)
        dayValueLabel.text = "0"
        dayValueLabel.textColor = UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.5)
        dayValueLabel.textAlignment = NSTextAlignment.center
        dayValueLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        dayView.addSubview(dayValueLabel)
        
        
       
        
        var dayLabel = UILabel()
        dayLabel.text = "Days"
        dayLabel.textColor = UIColor.black
        dayLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        dayLabel.textAlignment = NSTextAlignment.center
        dayLabel.frame = CGRect(x: 0, y: dayValueLabel.frame.maxY+5,width: yearView.frame.size.width , height: 30)
        dayView.addSubview(dayLabel)
        
        
        if ScreenSize.height == 480
        {
            backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width, height: calender.frame.maxY + 70)
        }
        

//        
//        var yearImg : UIImageView  = UIImageView()
//        yearImg.frame = CGRectMake(20, 20, calenderWidth, 80)
//        yearImg.image = UIImage(named: "year")
//        calender.addSubview(yearImg)
//        
//        var monthImg : UIImageView  = UIImageView()
//        monthImg.frame = CGRectMake(CGRectGetMaxX(yearImg.frame) + 10, 20, calenderWidth, 80)
//        monthImg.image = UIImage(named: "month")
//        calender.addSubview(monthImg)
//        
//        var dayImg : UIImageView  = UIImageView()
//        dayImg.frame = CGRectMake(CGRectGetMaxX(monthImg.frame) + 10 , 20, calenderWidth, 80)
//        dayImg.image = UIImage(named: "days")
//        calender.addSubview(dayImg)
        

//        
//        backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.frame.size.width, CGRectGetMaxY(calender.frame) + 200)

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.getOldStatusOfAttendedMeetingOldStatus()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    func DateGesture(_ recognizer : UITapGestureRecognizer)
    {
       backgroundScrollView.addSubview(datePickerView)
    }
    
  
    
    func PickerDoneBtnAction(_ sender : UIButton)
    {
        
        let pickerDate : (Date) = datePicker.date
        let currentDate = Date()
        if(pickerDate .compare(currentDate) == ComparisonResult.orderedAscending)
        {
            let DF = DateFormatter()
            DF.dateFormat = "yyyy-MM-dd hh:mm:ss"
            let dateStr = DF.string(from: pickerDate)
            
            
            let selectedDate : (Date) = DF.date(from: dateStr)!
            DF.dateFormat = "MM-dd-yyyy"
            let selectedDateStr : (NSString) = DF.string(from: selectedDate) as (NSString)
            dateLabel.text = selectedDateStr as String
            dateLabel.textColor = UIColor.black
            //selectedMeetingDate.text = selectedDateStr as String
            //selectedMeetingDate.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
            //println(selectedMeetingDate.text)
            
            datePickerView .removeFromSuperview()
            self .getAttendedMeeting()
        }
        else
        {
            let alertView = UIAlertView(title: "", message: "Future date can't be chosen as a date.", delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()
        }
    }
    
    
    func PickerCancelBtnAction(_ sender:UIButton)
    {
        datePickerView .removeFromSuperview()
    }
    
    func backBtnAction(_ sender: UIButton) {
    navigationController!.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    func  getAttendedMeeting()
    {
     //http://112.196.34.179/stepslocator/index.php/login/wsfindSobrietyCount?user_id=12&sob_Date=2015-06-18
        
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
       
       // SVProgressHUD.showWithStatus("Please Wait...")
          SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
      
        
        var user : (SMLAppUser) = SMLAppUser.getUser()
        var loginId : (NSString) = user.userId;
        var pickerDate : (Date) = datePicker.date
        var df : (DateFormatter) = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        var dateStr : (NSString) = df.string(from: pickerDate) as (NSString)
        
      
        
        //latitude=30.6799&longitude=76.722130.680339, 76.728552
        var parameters : (NSDictionary) = ["user_id" : loginId,
            "sob_Date" : dateStr]
        
        WebserviceManager.sharedInstance.findSobrietyCalculatorSave(params: parameters) { (responseObject, error) in
            print(responseObject)
            if responseObject != nil
            {
                var success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if success == 0
                {
                    self.calculateDays()
                    SVProgressHUD .dismiss()
                }
                else if success == 1
                {
                    
                    var meetingsAdded : (NSString) =  (responseObject as! NSDictionary).value(forKey: "meetings_added") as! String as (NSString)
                    var meetingsAttended : (NSString) =  (responseObject as! NSDictionary).value(forKey: "meetings_attended") as! String as (NSString)

                    
                    if meetingsAdded.length == 0
                    {
                      meetingsAdded = "0"
                    }
                    if meetingsAttended.length == 0
                    {
                        meetingsAttended = "0"
                    }
             
                    
                    self.valueaddedMeeting.text = meetingsAdded as String
                    self.valueAttendedMeeting.text = meetingsAttended as String
                    self.calculateDays()
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
    
    func setCalenderValues(strDate:NSString)
    {
    
        dateLabel.text = strDate as String
        dateLabel.textColor = UIColor.black
        

        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy"
       
        
        let startDate : (Date) = formatter.date(from:strDate as String)!
        let endDate : (Date) = Date()
        
        
        print("\nDays----")
        print(startDate)
        print("\nDays----")
        print(endDate)
        
        var gregorianCalendar : (Calendar) = Calendar(identifier: Calendar.Identifier.gregorian)
        let components = Calendar.current.dateComponents(Set<Calendar.Component>([.day]), from: startDate, to: endDate)
        let components1 = Calendar.current.dateComponents(Set<Calendar.Component>([.month]), from: startDate, to: endDate)
        let components2 = Calendar.current.dateComponents(Set<Calendar.Component>([.year]), from: startDate, to: endDate)
        
        daysCalculate = components.day
        monthsCalculate = components1.month
        yearsCalculate = components2.year
        
        print("\nDays----")
        print(daysCalculate)
        print("\nMonths----")
        print(monthsCalculate)
        print("\nYears----")
        print(yearsCalculate)


        
        dayValueLabel.text = NSString(format: "%d", daysCalculate) as String
        monthsValueLabel.text = NSString(format: "%d", monthsCalculate) as String
        yearsValueLabel.text = NSString(format: "%d", yearsCalculate) as String
        valueSober.text = NSString(format: "%d", daysCalculate) as String
        
    }
    
    func calculateDays()
    {
//        var startDay : (NSString) = "2015-09-01"
//        var endDay : (NSString) = "2015-12-01"
//        
//        var f : (NSDateFormatter) = NSDateFormatter()
//       f.dateFormat = "yyyy-MM-dd"
        
        var startDate : (Date) = datePicker.date
        var endDate : (Date) = Date()
        
        
        var gregorianCalendar : (Calendar) = Calendar(identifier: Calendar.Identifier.gregorian)
        let components = Calendar.current.dateComponents(Set<Calendar.Component>([.day]), from: startDate, to: endDate)
        let components1 = Calendar.current.dateComponents(Set<Calendar.Component>([.month]), from: startDate, to: endDate)
        let components2 = Calendar.current.dateComponents(Set<Calendar.Component>([.year]), from: startDate, to: endDate)
        
        daysCalculate = components.day
        monthsCalculate = components1.month
        yearsCalculate = components2.year
        
        dayValueLabel.text = NSString(format: "%d", daysCalculate) as String
        monthsValueLabel.text = NSString(format: "%d", monthsCalculate) as String
        yearsValueLabel.text = NSString(format: "%d", yearsCalculate) as String
        valueSober.text = NSString(format: "%d", daysCalculate) as String
       // println(components.day)
       // println(components1.month)
       // println(components2.year)
     
      
    }
   
    func  getOldStatusOfAttendedMeetingOldStatus()
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsfindSobrietyCount?user_id=12&sob_Date=2015-06-18
        
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
            
            // SVProgressHUD.showWithStatus("Please Wait...")
            SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
            
            
            var user : (SMLAppUser) = SMLAppUser.getUser()
            var loginId : (NSString) = user.userId;
   
            
            
            
            //latitude=30.6799&longitude=76.722130.680339, 76.728552
            var parameters : (NSDictionary) = ["user_id" : loginId,
                                               ]
            
            WebserviceManager.sharedInstance.findSobrietyCalculateOldStatus(params: parameters) { (responseObject, error) in
                print(responseObject)
                if responseObject != nil
                {
                    var success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    if success == 0
                    {
                        self.calculateDays()
                        SVProgressHUD .dismiss()
                        
                    }
                    else if success == 1
                    {
                        
                        var meetingsAdded : (NSString) =  (responseObject as! NSDictionary).value(forKey: "meetings_added") as! String as (NSString)
                        var meetingsAttended : (NSString) =  (responseObject as! NSDictionary).value(forKey: "meetings_attended") as! String as (NSString)
                        var strCalenderdate : (NSString) =  (responseObject as! NSDictionary).value(forKey: "Sobriety Date") as! String as (NSString)
                        
                        if meetingsAdded.length == 0
                        {
                            meetingsAdded = "0"
                        }
                        if meetingsAttended.length == 0
                        {
                            meetingsAttended = "0"
                        }
                        if strCalenderdate.length == 0
                        {
                            strCalenderdate = "0-0-0"
                        }

                        
                        self.valueaddedMeeting.text = meetingsAdded as String
                        self.valueAttendedMeeting.text = meetingsAttended as String
                        self.setCalenderValues(strDate: strCalenderdate)
                        SVProgressHUD .dismiss()
                    }
                }
                else
                {
                    SVProgressHUD .dismiss()
                    let alertView = UIAlertView(title: "", message: "Record not found.", delegate: nil, cancelButtonTitle: "Ok")
                    alertView.show()
                }
            }
        }
        else
        {
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }

    

}
