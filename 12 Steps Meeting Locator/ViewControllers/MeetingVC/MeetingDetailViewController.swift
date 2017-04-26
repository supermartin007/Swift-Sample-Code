//
//  MeetingDetailViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 17/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit





class MeetingDetailViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,UITextViewDelegate,UIAlertViewDelegate,inAppProductsDelegate,SKProductsRequestDelegate,SKPaymentTransactionObserver {
    
    var detailMapView : MKMapView = MKMapView()
    let locationM  = CLLocationManager()
    var detailArray : (NSDictionary) = NSDictionary()
    var descriptionTextView : (UITextView)!
    var upGradebackView: UIView = UIView()
    var productIdentifier :  (NSString) = NSString()

    var backgroundScrollView : (UIScrollView)!
    var metingCheckInInterval:Int = 30
    //var arrayValue : (NSArray) = []
    var productArray : (NSMutableArray) = NSMutableArray()
    var inAppProducts : (inAppClass)!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.navigationController?.navigationBarHidden = true
//        
//        
//        self.navigationController!.navigationBar.barTintColor  = UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0)
//        
//        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor() , NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(15)]
//        
//        self.navigationItem.title = "MeetingDetail"
//        
//        
//        // self.navigationItem.leftBarButtonItem?.image = UIImage(named: "back_errow")
//        // self.navigationItem.rightBarButtonItem?.image = UIImage(named: "fb")
//        
//        var backImage =  UIImage(named: "back_errow")
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, landscapeImagePhone: nil, style: UIBarButtonItemStyle.Plain, target: self, action: "backBtnAction:")
//        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
//        
        self.view.backgroundColor = UIColor.white
        
        
        inAppProducts = inAppClass.sharedInstance()
        inAppProducts.delegate = self
        
        let navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        navigationView.backgroundColor = UIColor(red: 31.0/255.0, green:134/255, blue: 209.0/255.0, alpha: 1.0)
        self.view.addSubview(navigationView)
        
        let backBtn = UIButton.init(type: UIButtonType.custom)
        let image = UIImage(named: "back_errow")
        backBtn.addTarget(self, action: #selector(MeetingDetailViewController.backBtnAction(_:)), for: UIControlEvents.touchUpInside)
        backBtn.frame = CGRect(x: 10,y: 25, width: 30, height: 30)
        backBtn.setImage(image, for: UIControlState())
        navigationView.addSubview(backBtn)
        
        
        let titleLabel = UILabel()
        titleLabel.frame=CGRect(x: 30,y: 32, width: navigationView.frame.size.width-50, height: 20)
        titleLabel.text = "Meeting Detail"
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        navigationView.addSubview(titleLabel)
        
        
        
        self.createUI()


        // Do any additional setup after loading the view.
    }
    
    
    func createUI()
    {
        
        backgroundScrollView = UIScrollView()
        backgroundScrollView.isScrollEnabled = true
        backgroundScrollView.bounces = false
        backgroundScrollView.isUserInteractionEnabled = true
        backgroundScrollView.frame = CGRect(x: 0, y: 64, width: ScreenSize.width, height: ScreenSize.height)
        self.view.addSubview(backgroundScrollView)
        
        detailMapView = MKMapView()
        detailMapView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 200)
        detailMapView.delegate = self
        backgroundScrollView.addSubview(detailMapView)
        
        
        
        let blackView = UIView()
        blackView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 200)
        blackView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        backgroundScrollView.addSubview(blackView)
        
        
        let appUser : (SMLAppUser) = SMLAppUser.getUser()
        let userName : (NSString) = appUser.userName
//
        //194,193,190
        let userNameText = UILabel()
        userNameText.frame = CGRect(x: 10, y: 10, width: ScreenSize.width, height: 15)
        userNameText.text = userName as String
        userNameText.font = SMLGlobal.sharedInstance.fontSizeBold(15)
        userNameText.textColor = UIColor(red: 242 / 255, green: 242  / 255, blue: 242  / 255, alpha: 1.0)
        blackView.addSubview(userNameText)
        
        
        
        let selectedAddress1 = UILabel()
        selectedAddress1.frame = CGRect(x: 10, y: userNameText.frame.maxY, width: ScreenSize.width/2, height: 40)
        selectedAddress1.numberOfLines = 0
        selectedAddress1.text = detailArray.object(forKey: "address1") as? String
        selectedAddress1.font = SMLGlobal.sharedInstance.fontSize(12)
        selectedAddress1.textColor = UIColor(red: 242 / 255, green: 242  / 255, blue: 242  / 255, alpha: 1.0)
        blackView.addSubview(selectedAddress1)
        
        
        
        
        
        let attendImageMap = UIImageView()
        attendImageMap.frame = CGRect(x: detailMapView.frame.maxX - 120,y: 10, width: 15, height: 15)
        attendImageMap.image = UIImage(named: "white_attendies_icon")
        blackView.addSubview(attendImageMap)
        
        
        let attendiesMap = UILabel()
        attendiesMap.frame = CGRect(x: attendImageMap.frame.maxX + 5, y: 10, width: 70, height: 15)
        //        var str7 : (NSString) = NSString(format: "# of members checked in         %@", (detailArray.objectForKey("program_name")  as? String)!)
        attendiesMap.text = "Attendees"
        attendiesMap.font = SMLGlobal.sharedInstance.fontSize(12)
        attendiesMap.textColor = UIColor(red: 242 / 255, green: 242  / 255, blue: 242  / 255, alpha: 1.0)
        blackView.addSubview(attendiesMap)
        
      
        let attendCountViewMap : (UIView) = UIView()
        attendCountViewMap.frame = CGRect(x: attendiesMap.frame.maxX+2,y: 10, width: 15, height: 15)
        attendCountViewMap.backgroundColor = UIColor(red: 255.0/255.0, green: 74.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        attendCountViewMap.layer.cornerRadius = attendCountViewMap.frame.size.width/2
        blackView.addSubview(attendCountViewMap)
        
        let countLabelMap : (UILabel) = UILabel()
        countLabelMap.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        countLabelMap.text = detailArray.object(forKey: "totalAttendees") as? String
        countLabelMap.textAlignment = NSTextAlignment.center
        countLabelMap.textColor = UIColor.white
        countLabelMap.font = SMLGlobal.sharedInstance.fontSize(10)
        attendCountViewMap.addSubview(countLabelMap)
        
        
        
        //var attendies = UILabel()
        
        
        
        
        
        locationM.delegate = self
        locationM.desiredAccuracy = kCLLocationAccuracyBest
        
        self.displayAnnotations()
        
        
        let meetingDetailLabel : (UILabel) = UILabel()
        meetingDetailLabel.text = "Meeting Detail"
        meetingDetailLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        meetingDetailLabel.textColor = UIColor.black
        meetingDetailLabel.frame = CGRect(x: 20, y: detailMapView.frame.maxY+10, width: ScreenSize.height - 20, height: 20)
        backgroundScrollView.addSubview(meetingDetailLabel)
        
        
        //248,246,247
        let detailView : (UIView) = UIView()
        detailView.backgroundColor = UIColor(red: 248.0/255.0, green: 246.0/255.0, blue: 247.0/255.0, alpha: 1.0)
        detailView.layer.borderWidth = 1.0
        detailView.layer.cornerRadius = 4.0
        
        detailView.layer.borderColor = UIColor.lightGray.cgColor
        detailView.frame = CGRect(x: 10, y: meetingDetailLabel.frame.maxY+20, width: ScreenSize.width - 20, height: 310)
        backgroundScrollView.addSubview(detailView)
        
        
        
        let programView = UIView()
        programView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
        detailView.addSubview(programView)
        
        let programImageView = UIImageView()
        programImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        //programImageView.image = UIImage(named: "place_hold_a")
        programView.addSubview(programImageView)
        
        let programLabel = UILabel()
        let programName = detailArray.object(forKey: "program_name")  as? String
        programImageView.image = UIImage(named: "place_hold_b")

        programLabel.text = programName
        programLabel.textAlignment = NSTextAlignment.center
        programLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        programLabel.textColor = UIColor.black
        programLabel.frame = CGRect(x: 10, y: 0, width: 30, height: 50)
        programView.addSubview(programLabel)
        
        
        
       
        
        
        
        //Name
        
        let userNameLabel = UILabel()
        userNameLabel.frame = CGRect(x: programView.frame.maxX + 10, y: programView.frame.origin.y, width: ScreenSize.width - programView.frame.maxX + 10, height: 20)
        userNameLabel.text = userName as String
        userNameLabel.font = SMLGlobal.sharedInstance.fontSize(15)
        userNameLabel.textColor = UIColor(red: 60.0/255.0, green: 92.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        detailView.addSubview(userNameLabel)
        
        
        
        //Name
        
        let programNameLabel = UILabel()
        programNameLabel.frame = CGRect(x: userNameLabel.frame.origin.x, y: userNameLabel.frame.maxY+5, width: ScreenSize.width/2 - (programView.frame.maxX), height: 15)
        
       // var str : (NSString) = NSString(format: "Program-          %@", (detailArray.objectForKey("program_name")  as? String)!)
        programNameLabel.text = "Program-"
        programNameLabel.font = SMLGlobal.sharedInstance.fontSize(11)
        programNameLabel.textColor = UIColor.black
        detailView.addSubview(programNameLabel)
        
        
        
        
        let selectedProgram = UILabel()
        
        
        selectedProgram.text = detailArray.object(forKey: "program_name") as? String
        selectedProgram.font = SMLGlobal.sharedInstance.fontSize(11)
        selectedProgram.textColor = UIColor.black
        selectedProgram.numberOfLines = 0
        
        let pSize : (CGRect) = selectedProgram.text!.boundingRect(with: CGSize(width: ScreenSize.width/2 - (programView.frame.maxX + 5), height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : selectedProgram.font], context: nil)
        
        selectedProgram.frame = CGRect(x: programNameLabel.frame.maxX+5, y: userNameLabel.frame.maxY+5, width: ScreenSize.width/2 - (programView.frame.maxX + 5), height: pSize.height)
        detailView.addSubview(selectedProgram)
        
        
        let categoryLabel = UILabel()
        categoryLabel.frame = CGRect(x: userNameLabel.frame.origin.x, y: selectedProgram.frame.maxY+5, width: ScreenSize.width/2 - programView.frame.maxX, height: 15)
       // var str1 : (NSString) = NSString(format: "Category-          %@",   as? String)!)
        categoryLabel.text = "Category-"
        categoryLabel.font = SMLGlobal.sharedInstance.fontSize(11)
        categoryLabel.textColor = UIColor.black
        detailView.addSubview(categoryLabel)
        
        
        let categoriesArray  : (NSArray) = detailArray.object(forKey: "categories") as! NSArray
        var catStr : (NSString) = NSString()
        var CatSTR : (NSString) = NSString()
        let finalCatSTR : (NSMutableString) = NSMutableString()
        for i in 0  ..< categoriesArray.count 
        {
            catStr = categoriesArray.object(at: i) as! (NSString)
            let arr : (NSArray) = catStr.components(separatedBy: ",") as NSArray
            CatSTR = arr.object(at: 1) as! (NSString)
            finalCatSTR.append(CatSTR as String)
            
          
            
            if(i == categoriesArray.count-1)
            {
                
            }
            else
            {
              finalCatSTR.append(",")
            }
              finalCatSTR.append(" ")
            
        }
        
        let selectedCategory = UILabel()
        
        selectedCategory.text = finalCatSTR as String
        selectedCategory.font = SMLGlobal.sharedInstance.fontSize(11)
        selectedCategory.textColor = UIColor.black
       selectedCategory.numberOfLines = 0
        
        
//        var catSize : (CGRect) = finalCatSTR.boundingRectWithSize(ScreenSize.width/2 - CGRectGetMaxX(programView.frame),200) options:NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: {NSFontAttributeName : selectedCategory.font}, context: nil)
        
        
        let catSize : (CGRect) = finalCatSTR.boundingRect(with: CGSize(width: ScreenSize.width/2 - programView.frame.maxX, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : selectedCategory.font], context: nil)
            
        selectedCategory.frame = CGRect(x: categoryLabel.frame.maxX+5, y: selectedProgram.frame.maxY+5, width: ScreenSize.width/2 - (programView.frame.maxX + 5), height: catSize.height)
       
         detailView.addSubview(selectedCategory)
        
        
        let meetingName = UILabel()
        meetingName.frame = CGRect(x: userNameLabel.frame.origin.x, y: selectedCategory.frame.maxY+5, width: ScreenSize.width/2 - programView.frame.maxX, height: 15)
//        var str2 : (NSString) = NSString(format: "MeetingName-          %@", (detailArray.objectForKey("meeting_name")  as? String)!)
        meetingName.text = "Meeting Name -"
     
        meetingName.font = SMLGlobal.sharedInstance.fontSize(11)
        meetingName.textColor = UIColor.black
        
        

        detailView.addSubview(meetingName)
        
        
        
        let selectedMeeting = UILabel()
        
        selectedMeeting.text = detailArray.object(forKey: "meeting_name") as? String
        selectedMeeting.font = SMLGlobal.sharedInstance.fontSize(11)
        selectedMeeting.textColor = UIColor.black
        
        selectedMeeting.numberOfLines = 0
        
        let mSize : (CGRect) = selectedMeeting.text!.boundingRect(with: CGSize(width: ScreenSize.width/2 - (programView.frame.maxX+5), height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(11)], context: nil)
        
        selectedMeeting.frame = CGRect(x: meetingName.frame.maxX+5, y: selectedCategory.frame.maxY+5, width: ScreenSize.width/2 - (programView.frame.maxX + 5), height: mSize.height + 5)
        detailView.addSubview(selectedMeeting)
        
        
        
        let address = UILabel()
        address.frame = CGRect(x: userNameLabel.frame.origin.x, y: selectedMeeting.frame.maxY+5, width: ScreenSize.width/2 - programView.frame.maxX, height: 15)
//        var str3 : (NSString) = (detailArray.object(forKey: "address1") as? String)! as (NSString)
        address.text = "Address-"
        
        let selectedAddress = UILabel()
       
        selectedAddress.numberOfLines = 0
        selectedAddress.text = detailArray.object(forKey: "address1") as? String
        selectedAddress.font = SMLGlobal.sharedInstance.fontSize(11)
        selectedAddress.textColor = UIColor.black
        detailView.addSubview(selectedAddress)
        

        
        
        
//        var text : (CGRect) = str3.boundingRectWithSize(CGSizeMake(selectedAddress.bounds.size.width, CGFloat.max), options: NSStringDrawingOptions.UsesFontLeading, attributes:[NSFontAttributeName : selectedAddress.font], context: nil)
        
        
        
//        var height : (CGFloat) = self.heightForView(str3 as String, font: selectedAddress.font, width: selectedAddress.frame.size.width)
        
        let size : (CGRect) =  selectedAddress.text!.boundingRect(with: CGSize(width: ScreenSize.width/2 - (programView.frame.maxX + 5) , height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName  : selectedAddress.font], context:nil)
        
        
       
        
        selectedAddress.frame = CGRect(x: address.frame.maxX+5, y: selectedMeeting.frame.maxY+5, width: ScreenSize.width/2 - (programView.frame.maxX + 5), height: size.height+5)
        
        
        
        //var size  : (CGSize) = [UIFont fo
        
        
        
//        var addressFrame : (CGRect) = address.frame
//        addressFrame.size.height = selectedAddress.frame.size.height
//        address.frame = addressFrame
     
        address.font = SMLGlobal.sharedInstance.fontSize(11)
        address.textColor = UIColor.black
        detailView.addSubview(address)
        
        
       
        
        
        
        let timeLabel = UILabel()
        timeLabel.frame = CGRect(x: userNameLabel.frame.origin.x, y: selectedAddress.frame.maxY+5, width: ScreenSize.width/2 - programView.frame.maxX, height: 15)
//        var str5 : (NSString) = NSString(format: "Time-          %@", (detailArray.objectForKey("meeting_date_time")  as? String)!)
        timeLabel.text = "Time -"
      
        timeLabel.font = SMLGlobal.sharedInstance.fontSize(11)
        timeLabel.textColor = UIColor.black
        detailView.addSubview(timeLabel)
        
        
        let selectedTime = UILabel()
        selectedTime.frame = CGRect(x: timeLabel.frame.maxX+5, y: selectedAddress.frame.maxY+5, width: ScreenSize.width/2 - (programView.frame.maxX + 5), height: 15)
        selectedTime.text = detailArray.object(forKey: "meeting_date_time") as? String
        selectedTime.font = SMLGlobal.sharedInstance.fontSize(11)
        selectedTime.textColor = UIColor.black
        detailView.addSubview(selectedTime)
        
        
        
        
        let days = detailArray.object(forKey: "days_of_weeks") as? String
        
        let finalDays : (NSMutableString) = NSMutableString()
        
        let  arr : (NSArray)  = days!.components(separatedBy: ",") as NSArray
        for i in 0 ..< arr.count
        {
            var dayStr : (NSString) = arr.object(at: i) as! (NSString)
            if(dayStr == "1")
            {
             dayStr = "Mon"
            }
            else if(dayStr == "2")
            {
              dayStr = "Tue"
            }
            else if(dayStr == "3")
            {
             dayStr = "Wed"
            }
            else if(dayStr == "4")
            {
              dayStr = "Thu"
            }
            else if(dayStr == "5")
            {
              dayStr = "Fri"
            }
            else if(dayStr == "6")
            {
               dayStr = "Sat"
            }
            else if(dayStr == "7")
            {
              dayStr = "Sun"
            }
           
            
            finalDays .append(dayStr as String)
            if(i == arr.count - 1)
            {
                
            }
            else
            {
              finalDays.append(",")
            }
          
        }
        
         let day1 : (CGRect) = finalDays.boundingRect(with: CGSize(width: 50 , height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(11)], context:nil)
        
        
        
        
        let selectedDay = UILabel()
        
//        selectedDay.frame = CGRectMake(CGRectGetMaxX(timeLabel.frame)+5, CGRectGetMaxY(selectedTime.frame)+5, ScreenSize.width/2 - CGRectGetMaxX(programView.frame), 15)
        
        selectedDay.frame = CGRect(x: timeLabel.frame.maxX+5, y: selectedTime.frame.maxY, width: 70, height: day1.height)
        selectedDay.numberOfLines = 0
        selectedDay.text = NSString(format: "(%@)", finalDays) as String
        selectedDay.font = SMLGlobal.sharedInstance.fontSize(11)
        selectedDay.textColor = UIColor.black
        detailView.addSubview(selectedDay)
        
        
        
        
        
        
        
        
        
        
        
        
        let membersLabel = UILabel()
        membersLabel.frame = CGRect(x: userNameLabel.frame.origin.x, y: selectedDay.frame.maxY+5, width: ScreenSize.width - programView.frame.maxX + 10, height: 15)
//        var str6 : (NSString) = NSString(format: "# of members checked in    %@", (detailArray.objectForKey("program_name")  as? String)!)
        let totalAttend : (NSString) = (detailArray.object(forKey: "totalAttendees") as? String)! as (NSString)
        membersLabel.text = NSString(format: "# of members checked in - %@", totalAttend) as String
       // membersLabel.text = "# of members checked in-"
        membersLabel.font = SMLGlobal.sharedInstance.fontSize(11)
        membersLabel.textColor = UIColor.black
        detailView.addSubview(membersLabel)
        
        
        let attendImage = UIImageView()
        attendImage.frame = CGRect(x: userNameLabel.frame.origin.x, y: membersLabel.frame.maxY+5, width: 15, height: 15)
        attendImage.image = UIImage(named: "grey_attendies_icon")
        detailView.addSubview(attendImage)
        
        
        let attendies = UILabel()
        attendies.frame = CGRect(x: attendImage.frame.maxX+5, y: membersLabel.frame.maxY+5, width: 70, height: 15)
//        var str7 : (NSString) = NSString(format: "# of members checked in         %@", (detailArray.objectForKey("program_name")  as? String)!)
        attendies.text = "Attendees"
        attendies.font = SMLGlobal.sharedInstance.fontSize(11)
        attendies.textColor = UIColor.black
        detailView.addSubview(attendies)
        
        
        let attendCountView : (UIView) = UIView()
        attendCountView.frame = CGRect(x: attendies.frame.maxX,y: membersLabel.frame.maxY+5, width: 13, height: 13)
        attendCountView.backgroundColor = UIColor(red: 255.0/255.0, green: 74.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        attendCountView.layer.cornerRadius = attendCountView.frame.size.width/2
        detailView.addSubview(attendCountView)
        
        let countLabel : (UILabel) = UILabel()
        countLabel.frame = CGRect(x: 0, y: 0, width: 13, height: 13)
        countLabel.text = detailArray.object(forKey: "approvedAttendees") as? String
        countLabel.textAlignment = NSTextAlignment.center
        countLabel.textColor = UIColor.white
        countLabel.font = SMLGlobal.sharedInstance.fontSize(10)
        attendCountView.addSubview(countLabel)
        
       
        let directionImage: UIImageView = UIImageView()
        directionImage.frame = CGRect(x: userNameLabel.frame.origin.x , y: attendies.frame.maxY + 8 , width: 12, height: 10)
        directionImage.image = UIImage(named: "direction_icon")
        detailView.addSubview(directionImage)
        let direction: UILabel = UILabel()
        direction.frame = CGRect(x: directionImage.frame.maxX + 8, y: attendies.frame.maxY + 5 , width: 70, height: 15)
        direction.text = "Direction"
        direction.font = SMLGlobal.sharedInstance.fontSize(11)
        direction.textColor = UIColor.black
        //direction.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        detailView.addSubview(direction)
        
        let directButt: UIButton = UIButton()
        directButt.frame = CGRect(x: userNameLabel.frame.origin.x , y: attendies.frame.maxY + 5 , width: 70, height: 20)
        directButt.backgroundColor = UIColor.clear
        directButt.addTarget(self, action: #selector(MeetingDetailViewController.dirButtClick(_:)), for: UIControlEvents.touchUpInside)
        detailView.addSubview(directButt)
        
        let descriptionLabel = UITextView()
        descriptionLabel.frame = CGRect(x: 20, y: direction.frame.maxY + 10, width: ScreenSize.width - 80, height: 50)
       // descriptionLabel.frame = CGRectMake(20, CGRectGetMaxY(direction.frame)+10, detailView.frame.size.width - 40, 50)
        descriptionLabel.layer.borderColor = UIColor.lightGray.cgColor;
        descriptionLabel.layer.borderWidth = 1
        descriptionLabel.layer.cornerRadius = 4.0
        descriptionLabel.isScrollEnabled = true
        descriptionLabel.isUserInteractionEnabled = true
        descriptionLabel.isEditable = false
        descriptionLabel.font = SMLGlobal.sharedInstance.fontSize(11)
        descriptionLabel.textColor = UIColor.gray
        descriptionLabel.text = NSString(format: " %@",detailArray.object(forKey: "description") as! String) as String
        //descriptionLabel.text = detailArray.objectForKey("description") as? String
        detailView.addSubview(descriptionLabel)
        
        let todayDate : (Date) = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let todayDay : (NSString) = dateFormatter.string(from: todayDate) as (NSString)
        let getDay : (Int) = self.checkTodayDay(todayDay)
        let day : (NSString) = NSString(format: "%d", getDay)
        

        detailView.frame = CGRect(x: 20, y: meetingDetailLabel.frame.maxY+20, width: ScreenSize.width - 40, height: descriptionLabel.frame.maxY + 10)

        
        
        let checkInBtn : (UIButton) = UIButton.init(type: UIButtonType.custom)
        checkInBtn.frame = CGRect(x: 20, y: detailView.frame.maxY + 10, width: ScreenSize.width - 40, height: 34)
        checkInBtn.setImage(UIImage(named: "checkin_btn"), for:  UIControlState())
        checkInBtn.addTarget(self, action: #selector(MeetingDetailViewController.CheckInBtnAction), for:  UIControlEvents.touchUpInside)
        print(detailArray)
        let dayOfMetting : (NSString) = detailArray.object(forKey: "days_of_weeks") as! (NSString)
        var fullNameArr = dayOfMetting.components(separatedBy: ",")
        if (fullNameArr.count > 0)
        {
        }
        
        else
        {
            fullNameArr = [dayOfMetting as String,""]
        }
        if (fullNameArr.contains(day as String))
        {
            if(self.withIn200Mete())
            {
            backgroundScrollView.addSubview(checkInBtn)
            }
            
        }

        
//        let enableCheck : (NSString) = detailArray.object(forKey: "near_200ft") as! NSString
//        if(enableCheck == "")
//        {
//            
 //       }
//        else
//        {
//          //backgroundScrollView.addSubview(checkInBtn)
//        }
       
        
        //checkin_btn
        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width, height: checkInBtn.frame.maxY + 74)
        

        
        
    }

    func dirButtClick(_ sender: UIButton) {
        print(sender.tag)
        let detailMeeting : (directionViewController) = directionViewController()
        detailMeeting.detailArray   = detailArray
        self.navigationController?.pushViewController(detailMeeting, animated: false)
    }
    
    func backBtnAction(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    func checkTodayDay(_ dayStr : NSString) -> Int
    {
        if(dayStr == "Mon")
        {
            return 1
        }
        else if(dayStr == "Tue")
        {
            return 2
        }
        else if(dayStr == "Wed")
        {
            return 3
        }
        else if(dayStr == "Thu")
        {
            return 4
        }
        else if(dayStr == "Fri")
        {
            return 5
        }
        else if(dayStr == "Sat")
        {
            return 6
        }
        else if(dayStr == "Sun")
        {
            return 7
        }
        else
        {
            return 0
        }
        
        
    }
    
    func withIn200Mete() -> Bool
    {
        
        let userDefaults : UserDefaults = UserDefaults.standard
        
        
        
        if (userDefaults.object(forKey: "Location") == nil)
        {
            return false
            
        }
        let dict : (NSDictionary) = UserDefaults.standard.object(forKey: "Location") as! NSDictionary
        var latStr1: (NSString) = NSString()
        var longStr1 : (NSString) = NSString()
        var latStr2: (NSString) = NSString()
        var longStr2 : (NSString) = NSString()
        
        
        latStr1 = dict.value(forKey: "latitude") as! String as (NSString)
        longStr1 = dict.value(forKey: "longitude") as! String as (NSString)
        
        var latitude1 : (CLLocationDegrees) = latStr1.doubleValue
        var longitude1 : (CLLocationDegrees) = longStr1.doubleValue
        
        
        latStr2  = detailArray.object(forKey: "latitude") as! NSString
        longStr2 = detailArray.object(forKey: "longitude") as! String as (NSString)
        
        var latitude2 : (CLLocationDegrees) = latStr2.doubleValue
        var longitude2 : (CLLocationDegrees) = longStr2.doubleValue
        
        var location1 = CLLocationCoordinate2D(latitude: latitude1, longitude: longitude1)
        var location2 = CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2)
        
        var differenceinFeet :Double  = self.differenceinFeet(place1: location1, place2: location2)
        print(differenceinFeet)
        if (differenceinFeet > 200)
        {
//            let alertController = UIAlertController(title: "", message: "You are far from Metting Location, Please go near 200 Ft", preferredStyle: UIAlertControllerStyle.alert)
//            
//            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
//            {
//                (result : UIAlertAction) -> Void in
//            }
//            alertController.addAction(okAction)
//            self.present(alertController, animated: true, completion: nil)
            return false
        }
        return true

    }
    func CheckInBtnAction()
    {
        
       
        let userInfo : (SMLAppUser) = SMLAppUser.getUser()
        let userCheck : (NSString) = userInfo.upgrade
       // if(userCheck == "1")
        if(true)
        {
            // println(self.detailArray)
            
            let todayDate : (Date) = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            
            let todayDay : (NSString) = dateFormatter.string(from: todayDate) as (NSString)
            let getDay : (Int) = self.checkTodayDay(todayDay)
            let day : (NSString) = NSString(format: "%d", getDay)
            
            let ids : (NSString) = detailArray.object(forKey: "meeting_id") as! NSString
            let lat: (NSString) = detailArray.object(forKey: "latitude") as! NSString
            let long : (NSString) = detailArray.object(forKey: "longitude") as! String as (NSString)
            
            
            
            
            let checkDic  : (NSDictionary) = ["latitude" : lat,
                                              "longitude" : long,
                                              "meetingId" : ids
                ,"day" : day] as NSDictionary
            let checkIn: (checkInViewController) = checkInViewController()
            checkIn.checkInDict = checkDic
            
            
            let currentDate = Date()
            let DF = DateFormatter()
            DF.dateFormat = "hh:mm:ss a"
            //DF.timeStyle = NSDateFormatterStyle.ShortStyle
            let current  : (NSString) = DF.string(from: currentDate) as (NSString)
            let timeZone : (TimeZone) = TimeZone(identifier: "GMT")!
            DF.timeZone = timeZone
            DF.dateFormat = "hh:mm:ss a"
            let currentD : (Date) = DF.date(from: current as String)!
            
            
            
            DF.dateFormat = "hh:mm:ss a"
            let checkTime : (NSString) = detailArray.object(forKey: "meeting_date_time") as! NSString
            var meetingTimeDate : (Date) = DF .date(from: checkTime as String)!
            
            //He Can check into meeting before 5 min
            //meeting time subtract from 5 minutes
            
            //Get Check in meeting time is 5 minutes
            //if time is less than 30 min then meeting time is complete
            //IF time is less than 35 min then u have enter into meetng
            meetingTimeDate = meetingTimeDate.addingTimeInterval(-60*5)
            
            if currentD.compare(meetingTimeDate) == ComparisonResult.orderedDescending
            {
                //Add 35 minutes meetingstime period for attending meeting
                meetingTimeDate = meetingTimeDate.addingTimeInterval(35*60)
                if(currentD.compare(meetingTimeDate) == ComparisonResult.orderedDescending)
                {
                    var com : (DateComponents) = Constants.myGlobalFunction.dateDifference(currentD, toDate: meetingTimeDate)
                    
                    
                    if(com.minute! < 50)
                    {
                        UIAlertView(title: "", message: "Meeting time up", delegate: nil, cancelButtonTitle: "OK").show()
                    }
                    else
                    {
                        self.navigationController?.pushViewController(checkIn, animated: false)
                    }
                }
                else if currentD.compare(meetingTimeDate) == ComparisonResult.orderedAscending
                {
                    var com : (DateComponents) = Constants.myGlobalFunction.dateDifference(currentD, toDate: meetingTimeDate)
                    
                    
                    if(com.minute! < 55)
                    {
                        self.navigationController?.pushViewController(checkIn, animated: false)
                        //
                        // df.dateFormat = "dd-MM-yyyy hh:mm a"
                        // timeStr = df.stringFromDate(serverDate)
                        //                if(com.year == 1)
                        //                {
                        //                    timeStr = NSString(format: "%ld year", com.year)
                        //                }
                        //                else
                        //                {
                        //                    timeStr = NSString(format: "%ld years", com.year)
                        //                }
                        
                        // return timeStr
                    }
                    else
                    {
                        UIAlertView(title: "", message: "Meeting time up", delegate: nil, cancelButtonTitle: "OK").show()
                        /// self.navigationController?.pushViewController(checkIn, animated: false)
                    }
                    //UIAlertView(title: "", message: "Meeting not start now", delegate: nil, cancelButtonTitle: "OK").show()
                }
                else
                {
                    
                }
                //UIAlertView(title: "", message: "Meeting not start now", delegate: nil, cancelButtonTitle: "OK").show()
                //  NSLog("date1 after date2");
            }
            else if currentD.compare(meetingTimeDate) == ComparisonResult.orderedAscending
            {
                
                UIAlertView(title: "", message: "Meeting has not started yet.", delegate: nil, cancelButtonTitle: "OK").show()
            }
            else
            {
                self.navigationController?.pushViewController(checkIn, animated: false)
                // NSLog("dates are equal");
            }  
        }
        else
        {
            self.displayUpgrade()

        }

        

    }
    func differenceinFeet(place1 :CLLocationCoordinate2D ,place2:CLLocationCoordinate2D) -> Double
    {
        
        let thisLocation = CLLocation(latitude: place1.latitude, longitude: place1.longitude)
        let otherLocation = CLLocation(latitude: place2.latitude, longitude: place2.longitude)
        
        
        var differenceInMeters = thisLocation.distance(from: otherLocation) as CLLocationDistance
        differenceInMeters = differenceInMeters * 3.28084
        return differenceInMeters
    }
    func displayAnnotations()
    {
           // array  = finalArray as NSArray
            // var arrayValue : (NSArray) = items .objectAtIndex(i) as! (NSArray)
            
            let latitudeStr : (NSString) = (detailArray .object(forKey: "latitude") as? String)! as (NSString)
            let longitudeStr : (NSString) = (detailArray.object(forKey: "longitude") as? String)! as (NSString)
            
            
            //        var latitudeStr : (NSString) = (array .valueForKey("latitude")?.objectAtIndex(i) as? String)!
            //        var longitudeStr : (NSString) = (array.valueForKey("longitude")?.objectAtIndex(i) as? String)!
            
            let MomentaryLatitude = latitudeStr.doubleValue
            let MomentaryLongitude = longitudeStr.doubleValue
            let latitude: (CLLocationDegrees)  = MomentaryLatitude
            let longitude: (CLLocationDegrees)  = MomentaryLongitude
            
            
            
            latdelta = 1
            londelta = 1
            //var locValue:CLLocationCoordinate2D = manager.location.coordinate
            //println("locations = \(locValue.latitude) \(locValue.longitude)")
            
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latdelta, londelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude )
            let resion:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            
            
            detailMapView.setRegion(resion, animated: true)
            annotation = MKPointAnnotation()
            annotation.coordinate = location
            
            latdelta = location.latitude
            londelta = location.longitude
            detailMapView.addAnnotation(annotation)
      
        
        
        
        
        
        
        
    }
    
    func removeUpgradeView(_ gesture : UITapGestureRecognizer)
    {
        upGradebackView.removeFromSuperview()
    }
    
    
    
    
    
    
    
//    
//    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//        //println("Function Called")
//        
//        
//        if !(annotation is MKPointAnnotation) {
//            return nil
//        }
//        
//        let reuseId = "test"
//        
//        var imgAnnotation = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
//        if imgAnnotation == nil {
//            imgAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//            
//            imgAnnotation.image = UIImage(named:"location")
//            //println(imgAnnotation)
//            imgAnnotation.canShowCallout = true
//        }
//        else {
//            imgAnnotation.annotation = annotation
//            //println("Else")
//        }
//        
//        return imgAnnotation
//    }
    
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //println("Function Called")
        
        let programName = detailArray.object(forKey: "program_name")  as? String
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        
        let reuseId = "test"
        
        var imgAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if imgAnnotation == nil {
            imgAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            let lal = UILabel()
            lal.frame = CGRect(x: 15, y: 5, width: 20, height: 20)
            lal.text = programName
            lal.textColor = UIColor(red: 90 / 255, green: 150 / 255, blue: 192 / 255, alpha: 1)
            lal.font = SMLGlobal.sharedInstance.fontSize(10)
            lal.backgroundColor = UIColor.clear
            imgAnnotation?.addSubview(lal)
            
            imgAnnotation?.image = UIImage(named:"location")
            //println(imgAnnotation)
            imgAnnotation?.canShowCallout = true
        }
        else {
            imgAnnotation?.annotation = annotation
            //println("Else")
        }
        
        return imgAnnotation
    }

    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
     if(text  == "\n")
     {
        descriptionTextView.resignFirstResponder()
        
      
        }
        
        
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width, height: backgroundScrollView.contentSize.height + 200)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width, height: backgroundScrollView.contentSize.height - 200)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayUpgrade()
    {
        
        self.upGradebackView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        self.upGradebackView.backgroundColor = UIColor(white: 0.05, alpha: 0.5)
        self.view.addSubview(self.upGradebackView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MeetingDetailViewController.removeUpgradeView(_:)))
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
        
        _ = backGroundView.frame.width / 2
        let upgradeButton: UIButton = UIButton()
        upgradeButton.frame = CGRect(x: (backGroundView.frame.width / 2) - 116, y: label4.frame.maxY + 20, width: 111, height: 37)
        //25,85,171
        let upImg = UIImage(named: "upgrad_button")
        //upgradeButton.backgroundColor = UIColor.blackColor()
        upgradeButton.setBackgroundImage(upImg, for: UIControlState())
        upgradeButton.addTarget(self, action: #selector(MeetingDetailViewController.upgradeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        backGroundView.addSubview(upgradeButton)
        
        let cancleButton: UIButton = UIButton()
        cancleButton.frame = CGRect(x: upgradeButton.frame.maxX+5, y: label4.frame.maxY + 20, width: 111, height: 37)
        //cancleButton.backgroundColor = UIColor.blackColor()
        let cnImg = UIImage(named: "popupcancel")
        cancleButton.setBackgroundImage(cnImg, for: UIControlState())
        cancleButton.addTarget(self, action: #selector(MeetingDetailViewController.cancleButtonClick1(_:)), for: UIControlEvents.touchUpInside)
        backGroundView.addSubview(cancleButton)
        
    }
    func upgradeButtonClick(_ sender: UIButton)
    {
        //  println("Upgrade Acc")
        
        let upgradeAlertView :(UIAlertView) = UIAlertView(title: "", message: "Do you want to upgrade this for $5.99", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
        upgradeAlertView.tag = 100
        upgradeAlertView.show()
        
        
        //        var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //        var view = FirstViewController(nibName: nil, bundle: nil)
        //        delegate.callMethod(view)
        
    }
    
    func cancleButtonClick1(_ sender: UIButton)
    {
        upGradebackView.removeFromSuperview()
        //        var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        //        var view = FirstViewController(nibName: nil, bundle: nil)
        //        delegate.callMethod(view)
        //        var secviewControler: ViewController   = ViewController()
        //        navigationController?.pushViewController(secviewControler, animated: false)
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            purchaseWithId(PRODUCTID as NSString)
        }
    }
    // MARK:- In App Purchase Maethods
    func purchaseWithId(_ productId:NSString)
    {
        // SVProgressHUD.showWithStatus("Loading...")
        SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        self.productArray = NSMutableArray()
        
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        self.productArray = delegate.productArray
        self.productIdentifier = productId
        

        [self.perform("working", with: nil, afterDelay: 0.1)];
    }
    func restoreWithProductId(_ productId:NSString)
    {
        self.productArray = NSMutableArray()
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        self.productArray = delegate.productArray
        //self.restoreTre
        
    }
    
    func restoreTransaction(_ sender : AnyObject)
    {
        //       if([self .checkNetworkStatus()])
        //       {
        // SVProgressHUD.showWithStatus("Loading")
        SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        Timer .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(MeetingDetailViewController.startRestore), userInfo: nil, repeats: false)
        //}
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
                UIAlertView(title: "Alert", message: "Please wait while load Products", delegate: nil, cancelButtonTitle: "OK").show()
                SVProgressHUD.dismiss()
            }
    }
    
    func checkNetworkStatus()->Bool
    {
        let reachability : Reachability = Reachability()!
        let netStatus = reachability.currentReachabilityStatus
        var isConnectedToInternet : (Bool) = true
        switch netStatus {
        case .notReachable:
            isConnectedToInternet =  false
            break
            
        case .reachableViaWWAN:
            isConnectedToInternet = true
            break
            
        case .reachableViaWiFi:
            isConnectedToInternet = true
            break
        }
        return isConnectedToInternet
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
       // self.CheckInBtnAction()
        

    }
    
    
    func didFailWithError(_ error: NSError!, transaction: SKPaymentTransaction)
    {
        
    }
    
    //MARK :- Restore methods
    
    
    
    func startRestore()
    {
        
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
    
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: NSError!)
    {
        
    }
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue)
    {
        if(queue.transactions.count == 0)
        {
            UIAlertView(title: "Restore", message: "There is no products purchased by you", delegate: nil, cancelButtonTitle: "OK").show()
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
            self.CheckInBtnAction()

            
        }
    }
    
    //MARK :- Request For products
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        
    }
    
    func request(_ request: SKRequest!, didFailWithError error: Error) {
        
    }
    
    //    func paymentQueue(_ queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
    //
    //    }
    
    func paymentQueue(_ queue: SKPaymentQueue,
                      updatedTransactions transactions: [SKPaymentTransaction])
    {
        
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

