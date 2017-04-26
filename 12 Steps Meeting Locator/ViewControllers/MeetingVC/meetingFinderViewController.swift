//
//  meetingFinderViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 23/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import MapKit
import StoreKit

var items1:NSArray!
var finalArray1: NSArray!
var itemsArr1 : (NSArray) =  NSArray()
  var seg1 = 0


class meetingFinderViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate,UITextFieldDelegate,UIAlertViewDelegate,inAppProductsDelegate, SKPaymentTransactionObserver , SKProductsRequestDelegate,UIGestureRecognizerDelegate {
 var dirImg: UIButton = UIButton()
    var imageView : (UIImageView) = UIImageView()
    var classAction : (Int)!
    var meetingNavigationView : UIView = UIView()
    var  meetingMapview  : MKMapView!
    var navView: UIView = UIView()
    var textView : UITextField = UITextField()
    var customSegmentedControl : UISegmentedControl!
    var listTableview : UITableView!
    var dir: UILabel = UILabel()
    var lat : NSString = NSString()
    var long : NSString = NSString()
    var viewC: UIView = UIView()
    var val : (CGFloat) = 0.0
     var countLabelMap : (UILabel) = UILabel()
    var checkInArray : (NSArray)!
     var attendCountViewMap : (UIView) = UIView()
    var isCheckIn : (Bool) = false
      var att: UILabel = UILabel()
     var checkInBtn : (UIButton) = UIButton()
      var attLabel: UIButton = UIButton()
    var mapValue : (Int) = 0
    var View3:UIButton!
    var latdelta = CLLocationDegrees()
    var londelta = CLLocationDegrees()
    var annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    var annotationTap: UITapGestureRecognizer!
    var isShow = false
    
    var checkInDictionary : (NSDictionary)!
    
    
    var annotationViewArray : (NSArray)!
    
    var mapOption : (Int) = 0
    
    var upGradebackView: UIView = UIView()
    
    var productArray : (NSMutableArray) = NSMutableArray()
    var productIdentifier :  (NSString) = NSString()
    
    var inAppProducts : (inAppClass)!
    var openListSegment : (Bool)!  = false
    var mettingIdBefore5 : NSString! = ""
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
 
    }

    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
              if (self.openListSegment == true)
        {
            self.setListSegment()
            
        }
        inAppProducts.delegate = self
        
        
  
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inAppProducts = inAppClass.sharedInstance()
       // inAppProducts.delegate = self
        
        viewC.removeFromSuperview()
        self.view.backgroundColor = UIColor.white
        items1 = NSArray()
        finalArray1 = NSArray()
        meetingNavigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 100)
        meetingNavigationView.backgroundColor = UIColor(red: 0 / 255.0, green:135.0 / 255, blue: 206.0 / 255, alpha: 1.0)
        self.view.addSubview(meetingNavigationView)
        
        let sgmentViewHeight = meetingNavigationView.frame.height
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        
          meetingMapview = MKMapView()
         meetingMapview.frame = CGRect(x: 0, y: meetingNavigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - meetingNavigationView.frame.maxY)
       
         meetingMapview.delegate = self
        
        listTableview = UITableView()
        listTableview.frame = CGRect(x: 0, y: meetingNavigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - meetingNavigationView.frame.maxY)
        self.view.addSubview( listTableview)
        listTableview.isHidden = true
        listTableview.separatorStyle = UITableViewCellSeparatorStyle.none
        listTableview.delegate = self
        listTableview.dataSource  = self
        
        let tapGesture : (UITapGestureRecognizer) = UITapGestureRecognizer()
        meetingMapview.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(meetingFinderViewController.MapViewGesture(_:)))
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
       customSegmentedControl = UISegmentedControl (items: ["Map","List"])
        customSegmentedControl.frame = CGRect(x: (ScreenSize.width - 140) / 2, y: 30,width: 140, height: 25)
        customSegmentedControl.selectedSegmentIndex = 0
        customSegmentedControl.tintColor = UIColor.white
        customSegmentedControl.addTarget(self, action: #selector(meetingFinderViewController.segmentedValueChanged(_:)), for: .valueChanged)
        meetingMapview.addSubview(customSegmentedControl)

        
        meetingNavigationView.addSubview(customSegmentedControl)
        
        let leftHomeButton : UIButton = UIButton()
        let homeImage: UIImage = UIImage(named: "home")!
        leftHomeButton.setBackgroundImage(homeImage, for: UIControlState())
        leftHomeButton.addTarget(self, action: #selector(meetingFinderViewController.homeClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        meetingNavigationView.addSubview(leftHomeButton)
        
        /* Create Top Custom Right Button View */
        
        let addButton: UIButton = UIButton()

        let rightButtonImage: UIImage = UIImage(named: "arrow")!
        addButton.setBackgroundImage(rightButtonImage, for: UIControlState())
        //meetingNavigationView.addSubview(addButton)
        
        _ = ScreenSize.width / 2

        addButton.frame = CGRect(x: ScreenSize.width - 44, y: sgmentViewHeight / 3.8, width: 28, height: 29)
        leftHomeButton.frame = CGRect(x: 16, y: 25, width: 30 , height: 30)
        /* Create  Custom Search text Field */
        
        let value = meetingNavigationView.frame.height - 50
        
        let searchView: UIButton = UIButton()
        searchView.frame = CGRect(x: 20, y: value + 13, width: ScreenSize.width - 40,  height: 20 * 1.35)
        searchView.backgroundColor = UIColor.white
        searchView.layer.cornerRadius = 0.04 * searchView.frame.width
        searchView.layer.borderColor = UIColor.clear.cgColor
        searchView.clipsToBounds = true
        meetingNavigationView.addSubview(searchView)
        
        
        textView.frame = CGRect(x: 30, y: 0, width: searchView.frame.width - 50,  height: 20 * 1.35)
        let placeholder1 = NSAttributedString(string: "Click Here To Search", attributes: [NSForegroundColorAttributeName : UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.6)])
        textView.attributedPlaceholder = placeholder1;
        textView.delegate = self
        textView.font = SMLGlobal.sharedInstance.fontSize(10)
        searchView.addSubview(textView)
        
        let UIImg : UIButton = UIButton()
        UIImg.frame = CGRect(x: searchView.frame.width - 27,y: (searchView.frame.size.height - 25)/2, width: 25, height: 25)
        let  butImg = UIImage(named: "search_arrow_icon")
        UIImg.setBackgroundImage(butImg, for: UIControlState())
        UIImg.addTarget(self, action: #selector(meetingFinderViewController.searchButt(_:)), for: UIControlEvents.touchUpInside)
        searchView.addSubview(UIImg)
        
        annotationTap = UITapGestureRecognizer(target: self, action: #selector(meetingFinderViewController.mapDidselect(_:)))
        annotationTap.numberOfTapsRequired = 1
        annotationTap.delegate = self
     
        
        let searchIcon : UIImageView = UIImageView()
        searchIcon.frame = CGRect(x: 5, y: 3.5, width: 20, height: 20)
        searchIcon.image = UIImage(named: "search_icon")
        searchView.addSubview(searchIcon)
        
        self.getNearByMeetings()
    }
    func mapDidselect(_ sender: UIGestureRecognizer)
    {
        if(viewC.isHidden == true)
        {
          viewC.isHidden = false
        }
        else
        {
          viewC.isHidden = true
        }
        
        
        if(checkInBtn.isHidden)
        {
            checkInBtn.isHidden = false
        }
        else
        {
          checkInBtn.isHidden = true
        }
        
       // viewC.removeFromSuperview()
       // checkInBtn.removeFromSuperview()
//        var selectedAnnotations: NSArray = meetingMapview.selectedAnnotations
//    
//        for ann in selectedAnnotations
//        {
//            var annotationView : (MKAnnotation) = ann as! (MKAnnotation)
//            meetingMapview .deselectAnnotation(annotationView, animated: true)
//        }
//        isShow = true
        
//        for (MapAnnotation *annotationView in selectedAnnotations) {
//            [self.viewMap deselectAnnotation:annotationView animated:YES];
//        }
//        isShow = TRUE;
    

  

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func segmentedValueChanged(_ sender:UISegmentedControl!)
    {
        seg1 = sender.selectedSegmentIndex
        if sender.selectedSegmentIndex == 0 {
            meetingMapview.isHidden = false
            listTableview.isHidden = true
            //println("Hello There")
        } else if sender.selectedSegmentIndex == 1 {
            meetingMapview.isHidden = true
            
            listTableview.isHidden = false
            listTableview.reloadData()
            //listTableview.estimatedRowHeight = 200
            //TableViewCell.
            //println("Hello")
        }
    }

    func setListSegment()
    {
        customSegmentedControl.selectedSegmentIndex = 1
        meetingMapview.isHidden = true
        listTableview.isHidden = false
        listTableview.reloadData()

    }
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //println(finalArray1.count)
        return finalArray1.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var findmeeting : (NSArray) = NSArray()
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
        
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell!.textLabel?.textColor = UIColor.black
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        
        let subviews = cell!.contentView.subviews
        // println("Hello\(subviews.count)")
        for view in subviews
        {
            view.removeFromSuperview()
        }
        findmeeting = finalArray1 as NSArray
        //(findmeeting.value(forKey: "program_name") as AnyObject).object(indexPath.row)  as? String
        //PB65W1155 on left side 1st row
        let dictValues : (NSDictionary) = findmeeting.object(at: indexPath.row) as! NSDictionary
        let program_name_Text = dictValues.object(forKey: "program_name") as! (NSString)
        let meetingName       = dictValues.object(forKey: "meeting_name") as! (NSString)
        let meetingdistance   = dictValues.object(forKey: "distance") as! (NSString)
        let disFloat          = meetingdistance.floatValue
        let finalDistance : (NSString) = NSString(format: "%.2f miles", disFloat)
        let meeting_date_time = dictValues.object(forKey: "meeting_date_time") as! (NSString)
        let meetingaddress1   = dictValues.object(forKey: "address1") as! (NSString)
        let days_of_weeks     = dictValues.object(forKey: "days_of_weeks") as! (NSString)
        let totalAttendies    = dictValues.object(forKey: "totalAttendees") as! (NSString)
        
        let rect : (CGRect) = meetingaddress1.boundingRect(with: CGSize(width: ScreenSize.width / 3 + 40, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(10)], context:nil)
        
        
        
        let day1 : (CGRect) = meeting_date_time.boundingRect(with: CGSize(width: ScreenSize.width / 6 , height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(10)], context:nil)
        
        
        
        let day2 : (CGRect) = days_of_weeks.boundingRect(with: CGSize(width: ScreenSize.width / 2  , height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(10)], context:nil)
        //println(day2)
        
        let meetingBackView = UIView()
       // meetingBackView.backgroundColor = UIColor.redColor()
        meetingBackView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: 120)
        cell?.contentView.addSubview(meetingBackView)
        
        let leftImage : UIImageView = UIImageView()
        leftImage.frame = CGRect(x: 5, y: (meetingBackView.frame.size.height - 48) / 2, width: 50, height: 48)
        meetingBackView.addSubview(leftImage)
        
        let programName: UILabel = UILabel()
         programName.frame = CGRect(x: (leftImage.frame.width  / 2) - 8, y: (leftImage.frame.height  / 2) - 12, width: 30, height: 20)
       // programName.frame = CGRectMake((leftImage.frame.width  / 2) - 10, (leftImage.frame.height  / 2) - 12, 30, 20)
        programName.text = program_name_Text as String
        programName.font = SMLGlobal.sharedInstance.fontSize(12)
        programName.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        leftImage.addSubview(programName)
        
        let leftimageWidth = leftImage.frame.maxX + 5
        
        let title: UILabel = UILabel()
        title.frame = CGRect(x: leftimageWidth, y: 5, width: ScreenSize.width - leftimageWidth, height: 20)
        title.font = SMLGlobal.sharedInstance.fontSize(14)
        title.text = meetingName as String
        title.textColor = UIColor(red: 60.0/255.0, green: 92.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        meetingBackView.addSubview(title)
        
        let address1: UILabel = UILabel()
        address1.frame = CGRect(x: leftimageWidth, y: title.frame.maxY , width: rect.width , height: rect.height)
        address1.text = meetingaddress1 as String
        address1.font = SMLGlobal.sharedInstance.fontSize(10)
        address1.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        address1.numberOfLines = 0
        meetingBackView.addSubview(address1)
        
        let timingDay1: UILabel = UILabel()
        timingDay1.frame = CGRect(x: ScreenSize.width - 90,y: title.frame.maxY, width: 60, height: 20)
        timingDay1.text = meeting_date_time as String
        timingDay1.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        timingDay1.font = SMLGlobal.sharedInstance.fontSize(10)
        meetingBackView.addSubview(timingDay1)
        
        
        let distance: UILabel = UILabel()
        distance.frame = CGRect(x: leftimageWidth, y: address1.frame.maxY + 2, width: 100 , height: 20)
        
        distance.text = "Distance - \(finalDistance)"
        distance.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        distance.font = SMLGlobal.sharedInstance.fontSize(10)
        meetingBackView.addSubview(distance)
        
        
        
        let finalDays : (NSMutableString) = NSMutableString()
        
        let  arr : (NSArray)  = days_of_weeks.components(separatedBy: ",") as NSArray
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
        
        let Day: UILabel = UILabel()
        
        if ScreenSize.width == 375.0 {
            //println(ScreenSize.width)
            Day.frame = CGRect(x: ScreenSize.width - 90,y: timingDay1.frame.maxY - 5,  width: day2.width + 30, height: day1.height + 20)
            Day.font = SMLGlobal.sharedInstance.fontSize(10)
        } else
        {
            
            Day.frame = CGRect(x: ScreenSize.width - 90,y: timingDay1.frame.maxY - 5,  width: day2.width + 30, height: day1.height + 10)
            Day.font = SMLGlobal.sharedInstance.fontSize(10)
        }
        Day.text = "(\(finalDays as String))"
        Day.numberOfLines = 0
        
        Day.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        meetingBackView.addSubview(Day)
        
       
        
        let disMaxFrame : (CGFloat) =  distance.frame.maxY
        
        let dayMaxFrame : (CGFloat) = Day.frame.maxY
        
        
        var attendyFrame : (CGFloat) = 0.0
        
        if(disMaxFrame > dayMaxFrame)
        {
          attendyFrame = disMaxFrame + 5
        }
        
        else
        {
          attendyFrame = dayMaxFrame + 5
        }
        
        
        
        let userImg :UIImageView = UIImageView()
        userImg.frame = CGRect(x: leftimageWidth-5, y: attendyFrame, width: 25, height: 15)
        userImg.image = UIImage(named: "user_atttendy")
        meetingBackView.addSubview(userImg)
    
        let attendies: UILabel = UILabel()
        attendies.frame = CGRect(x: userImg.frame.maxX, y: attendyFrame, width: 60, height: 15)
       
        attendies.text = "Attendees"
        attendies.font = SMLGlobal.sharedInstance.fontSize(10)
        attendies.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        meetingBackView.addSubview(attendies)
        
        
        let attendCountView : (UIView) = UIView()
        attendCountView.frame = CGRect(x: attendies.frame.maxX,y: attendyFrame, width: 15, height: 15)
        attendCountView.backgroundColor = UIColor(red: 255.0/255.0, green: 74.0/255.0, blue: 87.0/255.0, alpha: 1.0)
        attendCountView.layer.cornerRadius = attendCountView.frame.size.width/2
        meetingBackView.addSubview(attendCountView)
        
        let countLabel : (UILabel) = UILabel()
        countLabel.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
        countLabel.text = totalAttendies as String
        countLabel.textAlignment = NSTextAlignment.center
        countLabel.textColor = UIColor.white
        countLabel.font = SMLGlobal.sharedInstance.fontSize(10)
        attendCountView.addSubview(countLabel)
        
     
        let directionImage: UIImageView = UIImageView()
        directionImage.frame = CGRect(x: ScreenSize.width - 90, y: attendyFrame + 3 , width: 12, height: 10)
        directionImage.image = UIImage(named: "direction_icon")
        
        let direction: UILabel = UILabel()
        direction.frame = CGRect(x: directionImage.frame.maxX,y: attendyFrame, width: 70, height: 15)
        direction.text = "Direction"
        direction.font = SMLGlobal.sharedInstance.fontSize(10)
        direction.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        meetingBackView.addSubview(direction)
        
        meetingBackView.addSubview(directionImage)
        
        let dirButt: UIButton = UIButton()
        dirButt.frame = CGRect(x: ScreenSize.width - 90, y: attendyFrame, width: 60, height: 20)
        dirButt.backgroundColor = UIColor.clear
        dirButt.addTarget(self, action: #selector(meetingFinderViewController.dirButtonClick(_:)), for: UIControlEvents.touchUpInside)
        dirButt.tag = (indexPath as NSIndexPath).row
        meetingBackView.addSubview(dirButt)
        val = title.frame.height + distance.frame.height + address1.frame.height + title.frame.height + 17
        //println("Whole Size is:---- \(val)")
        
        
       
            itemsArr1  = items1 as NSArray!
            
            if (indexPath as NSIndexPath).row % 2 != 0 {
                meetingBackView.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
                leftImage.image = UIImage(named: "place_hold_b")
//                var labelView: UILabel = UILabel()
//                labelView.frame = CGRectMake(-2, val - 5, ScreenSize.width, 1)
//                labelView.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
//                cell?.addSubview(labelView)
                
                
            } else {
                meetingBackView.backgroundColor = UIColor.white
                leftImage.image = UIImage(named: "place_hold_a")
                
            }
        
        cell!.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        let mettingIdd = dictValues.object(forKey: "meeting_id") as! (NSString)
        print(self.mettingIdBefore5)
        print(mettingIdd)
        
        if(mettingIdd .isEqual(to:self.mettingIdBefore5 as String))
            
        {
            meetingBackView.backgroundColor = UIColor.red
        }
  
        return cell!
    }
    
    func dirButtonClick(_ sender: UIButton)
    {
        print(sender.tag)
        let detailMeeting : (directionViewController) = directionViewController()
        detailMeeting.detailArray   = finalArray1.object(at: sender.tag) as! (NSDictionary)
        self.navigationController?.pushViewController(detailMeeting, animated: false)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let detailMeeting : (MeetingDetailViewController) = MeetingDetailViewController()
        detailMeeting.detailArray   = finalArray1.object(at: (indexPath as NSIndexPath).row) as! (NSDictionary)
        self.navigationController?.pushViewController(detailMeeting, animated: false)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func MapViewGesture(_ gesture : UITapGestureRecognizer)
    {
        viewC.removeFromSuperview()
        
        checkInBtn.removeFromSuperview()
    }
    func searchButt(_ sender : UIButton)
    {
        
        textView.resignFirstResponder()
        
        var strValue :NSString   = textView.text! as String as NSString
        
        let trimmedString = strValue.trimmingCharacters(in: NSCharacterSet.whitespaces)
        if  trimmedString.characters.count == 0
        {
          textView.text = ""
        }
        if(textView.text != "")
        {
            self.getSearchMeetings()
            
        }
        else
        {
            let alertView = UIAlertView(title: "", message:"Please enter some place for Search" as String, delegate: nil, cancelButtonTitle: "Ok")
            alertView.show()

        }

    }
    
    func homeClick(_ sender: UIButton) {
        navigationController!.isNavigationBarHidden = false
       // println("Hello Reja")
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
       

    }
    
    func rightButtonClick(_ sender: UIButton) {
        // println("rightButton Clicked")
    }
    func getSearchMeetings()
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
            SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
       
            // 104.236.197.214/index.php/login/wssearchmeetings?searchmeeting=

            let parameters : (NSDictionary) = ["searchmeeting" :textView.text! as String
                                              ]
            
            WebserviceManager.sharedInstance.getMeetingBySearching(params: parameters) { (responseObject, error) in
                if responseObject != nil
                {
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    if success == 0
                    {
                        let alertView = UIAlertView(title: "", message:"No result Found" as NSString as String, delegate: nil, cancelButtonTitle: "Ok")
                        alertView.show()
                        SVProgressHUD .dismiss()
                        //                finalArray1  = NSMutableArray()
                        self.mapOption = 1
                        self.view.addSubview(self.meetingMapview)
                        self.locationManager.delegate = self
                        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                        self.locationManager.requestWhenInUseAuthorization()
                        self.locationManager.startUpdatingLocation()
                        self.textView.text = ""
                        
                        finalArray1  = nil;
                        finalArray1 =  NSArray(array:[])
                        self.listTableview.reloadData()
                        self.removeAnnotation()

                    }
                    else if success == 1
                    {
                        self.mapOption = 0
                        self.view.addSubview(self.meetingMapview)
                        items1 = responseObject?.value(forKey: "data") as! NSArray;
                        self.annotationViewArray = responseObject?.value(forKey: "data") as! NSArray;
                        
                        let todayDate : (Date) = Date()
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "EEE"
                        
                        let todayDay : (NSString) = dateFormatter.string(from: todayDate) as (NSString)
                        let getDay : (Int) = self.checkTodayDay(todayDay)
                        let day : (NSString) = NSString(format: "%d", getDay)
                        
                        
                        

                        
                      //  let predicate1: NSPredicate = NSPredicate(format: "Self.days_of_weeks contains %@ ", day)
                        finalArray1 = responseObject?.value(forKey: "data") as! NSArray;
                        
                        
                        
                      //  let feetAway : (NSString) = "near 200 ft"
                      //  let predicate : NSPredicate = NSPredicate(format: "near_200ft == %@ ", feetAway)
                      //  finalArray1 = finalArray1.filtered(using: predicate) as NSArray!
                        self.checkInArray = finalArray1 as (NSArray)!
                        //finalArray1 = items1.filteredArrayUsingPredicate(predicate)
                     //   finalArray1 = items1.filtered(using: predicate1) as NSArray!
                        self.listTableview.reloadData()
                        self.displayAnnotations()
                        SVProgressHUD .dismiss()
                    }
                }
                else
                {
                    let alertView = UIAlertView(title: "", message:responseObject!.value(forKey: "message") as! NSString as String, delegate: nil, cancelButtonTitle: "Ok")
                    alertView.show()
                    SVProgressHUD.dismiss()
                }
            }
        }
        else
        {
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }

    
    func getNearByMeetings()
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        //http://112.196.34.179/stepslocator/index.php/login/wsMeetingsNearby?latitude=&longitude=
        
        let userDefaults : UserDefaults = UserDefaults.standard
        var latStr: (NSString) = NSString()
        var longStr : (NSString) = NSString()
        if (userDefaults.object(forKey: "Location") != nil)
        {
            let dict : (NSDictionary) = UserDefaults.standard.object(forKey: "Location") as! NSDictionary
            latStr = dict.value(forKey: "latitude") as! String as (NSString)
            longStr = dict.value(forKey: "longitude") as! String as (NSString)
        }
       // let latitude : () = latStr.doubleValue
       // let longitude : (CLLocationDegrees) = longStr.doubleValue
       // latitude=31.5421225&longitude=-97.1518686, 76.728552
        let parameters : (NSDictionary) = ["latitude" :latStr,
                                           "longitude" :longStr]
        
        WebserviceManager.sharedInstance.getMeetingNearBy(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
            let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
            if success == 0
            {
                let alertView = UIAlertView(title: "", message:"No result Found" as NSString as String, delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
                SVProgressHUD .dismiss()
//                finalArray1  = NSMutableArray()
                self.mapOption = 1
                self.view.addSubview(self.meetingMapview)
                self.locationManager.delegate = self
                self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                self.locationManager.requestWhenInUseAuthorization()
                self.locationManager.startUpdatingLocation()
            }
            else if success == 1
            {
                self.mapOption = 0
                self.view.addSubview(self.meetingMapview)
                items1 = responseObject?.value(forKey: "data") as! NSArray;
                self.annotationViewArray = responseObject?.value(forKey: "data") as! NSArray;
                
                let todayDate : (Date) = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEE"
                
                let todayDay : (NSString) = dateFormatter.string(from: todayDate) as (NSString)
                let getDay : (Int) = self.checkTodayDay(todayDay)
                let day : (NSString) = NSString(format: "%d", getDay)
                
                let predicate1: NSPredicate = NSPredicate(format: "Self.days_of_weeks contains %@ ", day)
                finalArray1 = responseObject?.value(forKey: "data") as! NSArray;
                finalArray1 = finalArray1.filtered(using: predicate1) as NSArray!

                
                
                let feetAway : (NSString) = "near 200 ft"
                let predicate : NSPredicate = NSPredicate(format: "near_200ft == %@ ", feetAway)
                self.checkInArray = finalArray1.filtered(using: predicate) as (NSArray)!
                finalArray1 = self.checkInArray as (NSArray)!
             //   finalArray1 = finalArray1.filtered(using: predicate) as NSArray!
                self.listTableview.reloadData()
                self.displayAnnotations()
                SVProgressHUD .dismiss()
                if (self.openListSegment == true)
                {
                if (finalArray1.count > 0)
                {
                    var indexPath1 : IndexPath = IndexPath(row: (finalArray1.count-1) ,section: 0)
                    self.listTableview.scrollToRow(at: indexPath1, at: UITableViewScrollPosition.bottom, animated: true)
                }
                }
            }
            }
            else
            {
                let alertView = UIAlertView(title: "", message:responseObject!.value(forKey: "message") as! NSString as String, delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
                SVProgressHUD.dismiss()
            }
        }
        }
        else
        {
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }
    
    func displaynearestMeeting()
    {
//       var annotationsubviews: (NSArray)  = meetingMapview.removeAnnotations(meetingMapview.subviews) as! NSArray
//        for v in annotationsubviews
//        {
//          v.removeFromSuperview()
//        }
    
        
        
        
       
        meetingMapview.isHidden = false
//        meetingMapview = MKMapView()
//        meetingMapview.frame = CGRectMake(0, CGRectGetMaxY(meetingNavigationView.frame), ScreenSize.width, ScreenSize.height - CGRectGetMaxY(meetingNavigationView.frame))
//        self.view.addSubview( meetingMapview)
//        meetingMapview.delegate = self
        
        
        
      
        
        
        
        
        
        
        
        
        var count : Int = 0
        
        
        for i in 0 ..< self.checkInArray.count
        {
        
            //
            //println(items)
            
            var array : (NSArray) = NSArray()
            array  = self.checkInArray as NSArray
            
            
            let dictValues : (NSDictionary) = array.object(at: i) as! (NSDictionary)
            let latitudeStr : (NSString)    = dictValues.object(forKey: "latitude") as! (NSString)
            let longitudeStr : (NSString)   =  dictValues.object(forKey: "longitude") as! (NSString)
            
            
            
            let MomentaryLatitude = latitudeStr.doubleValue
            let MomentaryLongitude = longitudeStr.doubleValue
            
            if(lat.length<=0&&long.length<=0)
            {
                lat = latitudeStr
                long = longitudeStr
            }
            
            
            if (lat == latitudeStr && long == longitudeStr)
            {
                //println(count)
                
               // NSLog("number of elements same %d", count)
                count += 1
            }
            let latitude: (CLLocationDegrees)  = MomentaryLatitude
            let longitude: (CLLocationDegrees)  = MomentaryLongitude
            
            
            
            latdelta = 0.5
            londelta = 0.5
            //var locValue:CLLocationCoordinate2D = manager.location.coordinate
            //println("locations = \(locValue.latitude) \(locValue.longitude)")
            
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latdelta, londelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude )
            let resion:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            meetingMapview.setRegion(resion, animated: true)
            annotation = MKPointAnnotation()
            annotation.coordinate = location
            meetingMapview.showsUserLocation = true
        
            
            // meetingMapview.showAnnotations(annotation, animated: true)
            
            //        latdelta = location.latitude
            //        londelta = location.longitude
            
            
            let leftButton : UIButton = UIButton()
            leftButton.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
            let img = UIImage(named: "location_Check")
            leftButton.setImage(img, for: UIControlState())
             meetingMapview.addAnnotation(annotation)
           
            
            
        }
        
        
        
        
//        var checkInBtn : (UIButton) = UIButton.buttonWithType(UIButtonType.Custom) as! (UIButton)
//        checkInBtn.frame = CGRectMake(10, 10, 100, 30)
//        checkInBtn.setImage(UIImage(named: "check_in"), forState: .Normal)
//        meetingMapview.addSubview(checkInBtn)
        

        
        
        
        
        
        
    }
    
    func getlocationRegion()
    {
         }
    
    /*func displayAnnotations()
    {
        
        
        
        var count : Int = 0
        
        
        for var i = 0; i < finalArray1.count; i++
        {
            
            //
            //println(items)
            
            var array : (NSArray) = NSArray()
            array  = finalArray1 as NSArray
            
            
            
            var latitudeStr : (NSString) = (array .valueForKey("latitude")?.objectAtIndex(i) as? String)!
            var longitudeStr : (NSString) = (array.valueForKey("longitude")?.objectAtIndex(i) as? String)!
            
            
            
            let MomentaryLatitude = latitudeStr.doubleValue
            let MomentaryLongitude = longitudeStr.doubleValue
            
            if(lat.length<=0&&long.length<=0)
            {
                lat = latitudeStr
                long = longitudeStr
            }
            
            
            if (lat == latitudeStr && long == longitudeStr)
            {
                //println(count)
                
                NSLog("number of elements same %d", count)
                count++
            }
            var latitude: (CLLocationDegrees)  = MomentaryLatitude
            var longitude: (CLLocationDegrees)  = MomentaryLongitude
            
            
            
            latdelta = 0.5
            londelta = 0.5
            //var locValue:CLLocationCoordinate2D = manager.location.coordinate
            //println("locations = \(locValue.latitude) \(locValue.longitude)")
            
            
            var span:MKCoordinateSpan = MKCoordinateSpanMake(latdelta, londelta)
            var location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude )
            var resion:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            meetingMapview.setRegion(resion, animated: true)
            meetingMapview.showsUserLocation = true
            
            
            
            annotation = MKPointAnnotation()
            annotation.coordinate = location
            
           
            
            
            // meetingMapview.showAnnotations(annotation, animated: true)
            
            //        latdelta = location.latitude
            //        londelta = location.longitude
            
            
            var leftButton : UIButton = UIButton()
            leftButton.frame = CGRectMake(5, 5, 35, 35)
            var img = UIImage(named: "place_hold_b")
            leftButton.setImage(img, forState: .Normal)
            meetingMapview.addAnnotation(annotation)
            
            
        }
        
        
    }*/
    
    
    
    
    
    
    //@nonobjc by Fasihul
    @nonobjc func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            if self.mapOption == 1 {
                 self.latdelta = 1
                  self.londelta = 1
                let locValue:CLLocationCoordinate2D = manager.location!.coordinate
                // println("locations = \(locValue.latitude) \(locValue.longitude)")
                
                
                let span:MKCoordinateSpan = MKCoordinateSpanMake(self.latdelta, self.londelta)
                let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude )
                let resion:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                
                
                
                
                self.meetingMapview.setRegion(resion, animated: true)
                
               self.annotation.coordinate = location
                
                self.latdelta = location.latitude
                self.londelta = location.longitude

                self.meetingMapview.addAnnotation(self.annotation)
            }
            
        })
    }
    
    func removeAnnotation()
    {
        let subviews = meetingMapview.annotations
        for v in subviews
        {
            if(v .isKind(of: MKPointAnnotation.self))
            {
                let vs : (MKPointAnnotation) = v as! (MKPointAnnotation)
                meetingMapview.removeAnnotation(vs)
            }
        }

    }
    
    
    func displayAnnotations()
    {
         if(self.mapOption == 0)
         {
        let subviews = meetingMapview.annotations
        for v in subviews
        {
           if(v .isKind(of: MKPointAnnotation.self))
           {
            let vs : (MKPointAnnotation) = v as! (MKPointAnnotation)
             meetingMapview.removeAnnotation(vs)
           }
        }
       
        var count : Int = 0
        
        
        for i in 0 ..< finalArray1.count
        {
            
            //
            //println(annotationViewArray.count)
            
            var array : (NSArray) = NSArray()
            array  = finalArray1 as NSArray
            
            //println(annotationViewArray)
            let dictValues : (NSDictionary) = array.object(at: i) as! NSDictionary
            let latitudeStr : (NSString) = dictValues .object(forKey: "latitude") as! (NSString)
            let longitudeStr : (NSString) = dictValues.object(forKey: "longitude") as! (NSString)
            
            let near : (NSString) = dictValues.object(forKey: "near_200ft") as! (NSString)
            if near == "" {
              //  println("Hello\(i)")
            } else if near == "near 200 ft" {
               // println("near 200 ft\(i)")
            }
            
            let MomentaryLatitude = latitudeStr.doubleValue
            let MomentaryLongitude = longitudeStr.doubleValue
            
            if(lat.length<=0&&long.length<=0)
            {
                lat = latitudeStr
                long = longitudeStr
            }
            
            
            if (lat == latitudeStr && long == longitudeStr)
            {
                //println(count)
                
                //NSLog("number of elements same %d", count)
                count += 1
            }
            let latitude: (CLLocationDegrees)  = MomentaryLatitude
            let longitude: (CLLocationDegrees)  = MomentaryLongitude
            
            
            
            latdelta = 0.5
            londelta = 0.5
            //var locValue:CLLocationCoordinate2D = manager.location.coordinate
            //println("locations = \(locValue.latitude) \(locValue.longitude)")
            
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latdelta, londelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude )
            let resion:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            meetingMapview.setRegion(resion, animated: true)
            meetingMapview.showsUserLocation = true
            
            
            
            let mapAnnnotation : (MKPointAnnotation) = MKPointAnnotation()
            
            mapAnnnotation.coordinate = location
            // meetingMapview.showAnnotations(annotation, animated: true)
            
            //        latdelta = location.latitude
            //        londelta = location.longitude
            
            
            
            meetingMapview.addAnnotation(mapAnnnotation)
            
            mapValue = i
            
            
        }
        }
        else
         {
            
        }

        
        
    }
    
    /*func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView!
    {
        //println("Function Called")
        
        
        
        
            if !(annotation is MKPointAnnotation)
            {
                return nil
            }
            
            let reuseId = "test"
            
            var imgAnnotation = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
            if imgAnnotation == nil {
                imgAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
                if(isCheckIn)
                {
                 imgAnnotation.image = UIImage(named:"location_Check")
                }
                else
                {
                 imgAnnotation.image = UIImage(named:"location")
                }
               
                //println(imgAnnotation)
                imgAnnotation.canShowCallout = false
                viewC.hidden = false
            }
            else
            {
                imgAnnotation.annotation = annotation
                //println("Else")
            }
            
            return imgAnnotation   
       
        
    }*/
    
    
    func mapView(_ mapView: MKMapView!, viewFor annotation: MKAnnotation!) -> MKAnnotationView!
    {
       
        
        let reuseId = "test"
        
        var imgAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        
        var img = imgAnnotation
        if !(annotation is MKPointAnnotation)
        {
            return img
        }
        
        
        if imgAnnotation == nil
        {
            imgAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            if(self.mapOption == 0)
            {
            let array  = finalArray1 as NSArray
            let dictVaues : (NSDictionary) = array.object(at: mapValue) as! (NSDictionary)
            let progName : (NSString) = dictVaues.object(forKey: "program_name") as! (NSString)
            let near : (NSString) = dictVaues.object(forKey: "near_200ft") as! (NSString)
            //println(near)
            if near == ""
            {
                let lal = UILabel()
                lal.frame = CGRect(x: 15, y: 5, width: 20, height: 20)
                lal.text = progName as String
                lal.textColor = UIColor(red: 90 / 255, green: 150 / 255, blue: 192 / 255, alpha: 1)
                lal.font = SMLGlobal.sharedInstance.fontSize(10)
                lal.backgroundColor = UIColor.clear
                imgAnnotation?.addSubview(lal)
                
                imgAnnotation?.image = UIImage(named:"location")
                img = imgAnnotation
                //return img
            }
            else
                
            {
                let lal = UILabel()
                lal.frame = CGRect(x: 15, y: 2, width: 18, height: 20)
                lal.text = progName as String
                lal.textColor = UIColor(red: 90 / 255, green: 150 / 255, blue: 192 / 255, alpha: 1)
                lal.font = SMLGlobal.sharedInstance.fontSize(10)
                lal.backgroundColor = UIColor.clear
                imgAnnotation?.addSubview(lal)
                //imgAnnotation.backgroundColor = UIColor.brownColor()
                
                let tempImg:UIImage = UIImage(named: "location_Check")!
                imgAnnotation?.centerOffset = CGPoint(x: 0, y: -tempImg.size.height / 2);
                imgAnnotation?.image = tempImg
                //println()
                img = imgAnnotation
            }
       
            imgAnnotation?.canShowCallout = false
            viewC.isHidden = false
      
            return img
        }
            else
            {
                imgAnnotation?.image = UIImage(named:"location")
                img = imgAnnotation
                return img
            }
        }
        else
        {
            //imgAnnotation.annotation = annotation
            
            // img = imgAnnotation
            //println("Else")
            //return img
            return img
        }
       // MKUserLocation
        }
    
    func val(_ sender: UIButton) {
    }
    
    func differenceinFeet(place1 :CLLocationCoordinate2D ,place2:CLLocationCoordinate2D) -> Double
    {
        
        let thisLocation = CLLocation(latitude: place1.latitude, longitude: place1.longitude)
        let otherLocation = CLLocation(latitude: place2.latitude, longitude: place2.longitude)
        
        
        var differenceInMeters = thisLocation.distance(from: otherLocation) as CLLocationDistance
            differenceInMeters = differenceInMeters * 3.28084
        return differenceInMeters
    }
    func mapView(_ mapView: MKMapView!, didSelect view: MKAnnotationView!)
    {
        
       
        viewC.isHidden = true
        checkInBtn.isHidden = true
      view.addGestureRecognizer(annotationTap)
        
        if (isShow) {
           // var selectedAnnotations  : (NSArray) = meetingMapview.selectedAnnotations
            //var annotationView : (MKAnnotationView)!
            let selectedAnnotations : (NSArray) = meetingMapview.selectedAnnotations as (NSArray)
            
            for ann in selectedAnnotations
            {
                    let annotationView : (MKAnnotation) = ann as! (MKAnnotation)
                    meetingMapview .deselectAnnotation(annotationView, animated: true)
            }

            isShow = false
        }
  
       // viewC.removeFromSuperview()
      // checkInBtn.removeFromSuperview()
//        if (checkInBtn ! =  nil)
//        {
//            checkInBtn.removeFromSuperview()
//        }
        
        
        //var array  = annotationViewArray as NSArray
        var selected : MKAnnotation = MKPointAnnotation()
        selected = view.annotation!
        let LA = NSString(format: "%.10f", selected.coordinate.latitude)
        let LO = NSString(format: "%.10f", selected.coordinate.longitude)
        var array : (NSArray)
        let predicate = NSPredicate(format: "self.latitude contains %@ AND self.longitude contains %@", LA,LO)
        
        
        
        array =  [finalArray1.filtered(using: predicate)]
        // println(self.checkInArray)
        var arr : (NSArray) = NSArray()
        arr  = array.object(at: 0) as! (NSArray)
       // println(arr)
        if arr.count > 0 {
           // println("Fhdegnsc")
            let dict  : (NSDictionary) = arr.object(at: 0) as! (NSDictionary)
            let near : (NSString) = dict.object(forKey: "near_200ft") as! (NSString)
            if near != ""
            {
                if(arr.count > 0)
                {
                    // view.addGestureRecognizer(annotationTap)
                    
                    let todayDate : (Date) = Date()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "EEE"
                    
                    let todayDay : (NSString) = dateFormatter.string(from: todayDate) as (NSString)
                    let getDay : (Int) = self.checkTodayDay(todayDay)
                    let day : (NSString) = NSString(format: "%d", getDay)
                    
                    let dictValues  : (NSDictionary) = arr.object(at: 0) as! (NSDictionary)
                    
                    let ids : (NSString) = dictValues.object(forKey: "meeting_id") as! (NSString)
                    let lat: (NSString) =  dictValues.object(forKey: "latitude") as! (NSString)
                    let long : (NSString) = dictValues.object(forKey: "longitude") as! (NSString)
                    let status : (NSString) = dictValues.object(forKey: "approval_status") as! (NSString)
                    let dayOfMetting : (NSString) = dictValues.object(forKey: "days_of_weeks") as! (NSString)

                    //var status : (NSString) = (arr.valueForKey("approval_status")?.objectAtIndex(0) as? String)!
                   // view.backgroundColor = UIColor.brownColor()
                
                    
                    if !(self.checkNearFeetforCheckIn(dictLoaction2: dictValues))  // 200 Ft
                    {
                        
                        
                            let xAxis = view.frame.origin.x
                            let yAxis = view.frame.origin.y
                            
                            if(arr.count > 0)
                            {
                                let dictValues : (NSDictionary) = arr.object(at: 0) as! (NSDictionary)
                                let days_of_weeks :  (NSString) = dictValues.object(forKey: "days_of_weeks") as! (NSString)
                                let program_name :  (NSString) = dictValues.object(forKey: "program_name") as! (NSString)
                                
                                
                                let finalDays : (NSMutableString) = NSMutableString()
                                
                                let  arr1 : (NSArray)  = days_of_weeks.components(separatedBy: ",") as NSArray
                                for i in 0 ..< arr1.count
                                {
                                    var dayStr : (NSString) = arr1.object(at: i) as! (NSString)
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
                                    if(i == arr1.count - 1)
                                    {
                                        
                                    }
                                    else
                                    {
                                        finalDays.append(",")
                                    }
                                    
                                }
                                let day1 : (CGRect) = finalDays.boundingRect(with: CGSize(width: 100 , height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(10)], context:nil)
                                viewC.frame = CGRect(x: 0, y: 0, width: 234, height: 112 + day1.height)
                                
                                //                    if !viewC.isDescendantOfView(view) {
                                //                        view.addSubview(viewC)
                                //                    } else {
                                //                        viewC.removeFromSuperview()
                                //  }
                                
                                view.addSubview(viewC)
                                
                                
                                if xAxis <= 120 {
                                    viewC.center = CGPoint(x: 80, y: -50 - (day1.height))
                                    let mapImage = UIImage(named: "map-back_bottom_left")
                                    
                                    //  imageView.frame = CGRectMake(0, 0, 234, 120 + day1.height)
                                    imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                                    imageView.image = mapImage
                                    //viewC.addSubview(imageView)
                                } else if yAxis <= 90 {
                                    viewC.center = CGPoint(x: -60, y: 100 + (day1.height))
                                    imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                                    let mapImage = UIImage(named: "map-back_new")
                                    imageView.image = mapImage
                                    //viewC.addSubview(imageView)
                                }
                                else {
                                    let mapImage = UIImage(named: "map-back")
                                    viewC.center = CGPoint(x: -60, y: -50 - (day1.height))
                                    imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                                    imageView.image = mapImage
                                    // viewC.addSubview(imageView)
                                }
                                
                                if xAxis <= 120 && yAxis <= 90 {
                                    viewC.center = CGPoint(x: 80, y: 100 + (day1.height))
                                    imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                                    let mapImage = UIImage(named: "map-back_top_left")
                                    imageView.image = mapImage
                                    //viewC.addSubview(imageView)
                                }
                                //imageView.image = UIImage(named: "background")
                                // imageView.backgroundColor = UIColor.redColor()
                                viewC.isHidden = false
                                viewC.addSubview(imageView)
                                
                                
                                
                                let meetingName : (NSString) = dictValues.object(forKey: "meeting_name") as! (NSString)
                                let meetingaddress1 : (NSString) = dictValues.object(forKey: "address1") as! (NSString)
                                let meetingdistance : (NSString) = dictValues.object(forKey: "distance") as! (NSString)
                                
                                let disFloat = meetingdistance.floatValue
                                let finalDistance : (NSString) = NSString(format: "%.2f miles", disFloat)
                                let meeting_date_time : (NSString) = dictValues.object(forKey: "meeting_date_time") as! (NSString)
                                let totalAttendies : (NSString) = dictValues.object(forKey: "totalAttendees") as! (NSString)
                                
                                
                                // println(day1.width)
                                // println(day1.height)
                                let leftButton : UIButton = UIButton()
                                leftButton.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
                                let img = UIImage(named: "place_hold_b")
                                leftButton.setImage(img, for: UIControlState())
                                viewC.addSubview(leftButton)
                                
                                let namelbl: UILabel = UILabel()
                                namelbl.frame = CGRect(x: (leftButton.frame.width - 18) / 2, y: (leftButton.frame.height - 20) / 2 , width: 20, height: 20)
                                namelbl.text = program_name as String
                                namelbl.font = SMLGlobal.sharedInstance.fontSize(10)
                                leftButton.addSubview(namelbl)
                                
                                let title: UILabel = UILabel()
                                title.frame = CGRect(x: leftButton.frame.maxX + 5, y: 10, width: 170, height: 20)
                                title.text = meetingName as String
                                title.font = SMLGlobal.sharedInstance.fontSize(12)
                                title.textColor = UIColor.white
                                viewC.addSubview(title)
                                
                                let address: UILabel = UILabel()
                                address.numberOfLines = 0
                                address.frame = CGRect(x: title.frame.origin.x , y: title.frame.maxY + 5, width: 150, height: 20)
                                address.text = meetingaddress1 as String
                                address.font =  SMLGlobal.sharedInstance.fontSize(10)
                                address.textColor = UIColor.white
                                viewC.addSubview(address)
                                
                                let distanceLabel: UILabel = UILabel()
                                distanceLabel.frame = CGRect(x: title.frame.origin.x , y: address.frame.maxY + 5, width: 170, height: 10)
                                distanceLabel.text = NSString(format: "Distance- %@", finalDistance) as String
                                distanceLabel.font = SMLGlobal.sharedInstance.fontSize(10)
                                distanceLabel.textColor = UIColor.white
                                viewC.addSubview(distanceLabel)
                                let timingsLabel: UILabel = UILabel()
                                timingsLabel.frame = CGRect(x: title.frame.origin.x , y: distanceLabel.frame.maxY + 5, width: 120, height: 13)
                                let timeStr = NSString(format: "Timings - %@", meeting_date_time)
                                timingsLabel.text = timeStr as String
                                timingsLabel.font = SMLGlobal.sharedInstance.fontSize(10)
                                timingsLabel.textColor = UIColor.white
                                viewC.addSubview(timingsLabel)
                                
                                
                                let dayLabel: UILabel = UILabel()
                                dayLabel.frame = CGRect(x: title.frame.origin.x, y: timingsLabel.frame.maxY,width: 170, height: day1.height)
                                dayLabel.numberOfLines = 0
                                dayLabel.text = "(\(finalDays as String))"
                                dayLabel.textColor = UIColor.white
                                dayLabel.font =  SMLGlobal.sharedInstance.fontSize(10)
                                viewC.addSubview(dayLabel)
                                
                                attLabel.frame = CGRect(x: 20,y: dayLabel.frame.maxY + 2 , width: 15, height: 13)
                                attLabel.backgroundColor = UIColor.clear
                                //attLabel.tag = arr[i]
                                let imga = UIImage(named: "white_attendies_icon")
                                attLabel.setBackgroundImage(imga, for: UIControlState())
                                viewC.addSubview(attLabel)
                                
                                
                                att.frame = CGRect(x: attLabel.frame.maxX + 2 , y: dayLabel.frame.maxY + 2, width: 50, height: 15)
                                att.text = "Attendees"
                                //att.tag = arr[i]
                                att.font = SMLGlobal.sharedInstance.fontSize(10)
                                att.textColor = UIColor.white
                                viewC.addSubview(att)
                                
                                attendCountViewMap.frame = CGRect(x: att.frame.maxX,y: att.frame.origin.y, width: 13, height: 13)
                                attendCountViewMap.backgroundColor = UIColor(red: 255.0/255.0, green: 74.0/255.0, blue: 87.0/255.0, alpha: 1.0)
                                attendCountViewMap.layer.cornerRadius = attendCountViewMap.frame.size.width/2
                                viewC.addSubview(attendCountViewMap)
                                
                                
                                countLabelMap.frame = CGRect(x: 0, y: 0, width: 13, height: 13)
                                countLabelMap.text = totalAttendies as String
                                countLabelMap.textAlignment = NSTextAlignment.center
                                countLabelMap.textColor = UIColor.white
                                countLabelMap.font = SMLGlobal.sharedInstance.fontSize(10)
                                attendCountViewMap.addSubview(countLabelMap)
                                
                                
                                dir.frame = CGRect(x: viewC.frame.width - 80, y: dayLabel.frame.maxY + 2 , width: 50, height: 15)
                                dir.text = "Directions"
                                //dir.tag = arr[i]
                                dir.font = SMLGlobal.sharedInstance.fontSize(10)
                                dir.textColor = UIColor.white
                                viewC.addSubview(dir)
                                
                                
                                dirImg.frame = CGRect(x: dir.frame.maxX,y: dayLabel.frame.maxY + 2, width: 15, height: 13)
                                dirImg.backgroundColor = UIColor.clear
                                //dirImg.tag = arr[i]
                                let imgd = UIImage(named: "direction")
                                dirImg.setBackgroundImage(imgd, for: UIControlState())
                                viewC.addSubview(dirImg)
                                
                                
                            }
                            
                       return
                    }
                    else
                    
                    {
                        // Same day
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
                                    checkInDictionary = ["latitude" : lat,
                                                         "longitude" : long,
                                                         "meetingId" : ids
                                        ,"day" : day,
                                         "approval_status" : status]
                                    
                                    checkInDictionary = arr.object(at: 0) as! (NSDictionary)
                                    
                                    let tempImg:UIImage = UIImage(named: "location_Check_selected")!
                                    view.centerOffset = CGPoint(x: 50, y: -tempImg.size.height / 2);
                                    view.image = tempImg
                                    
                                    checkInBtn  = UIButton.init(type: UIButtonType.custom)
                                    checkInBtn.frame = CGRect(x: 35,y: 0, width: 103, height: 30)
                                    checkInBtn.addTarget(self, action: #selector(meetingFinderViewController.checkInBtnAction(_:)), for: .touchUpInside)
                                    checkInBtn.setImage(UIImage(named: "check_in"), for: UIControlState())
                                    checkInBtn.isUserInteractionEnabled = true
                                    checkInBtn.isHidden = false
                                    view.addSubview(checkInBtn)
                                    
                                }
                            
                            
                            else
                            {
                                
                                    let xAxis = view.frame.origin.x
                                    let yAxis = view.frame.origin.y
                                    
                                    if(arr.count > 0)
                                    {
                                        let dictValues : (NSDictionary) = arr.object(at: 0) as! (NSDictionary)
                                        let days_of_weeks :  (NSString) = dictValues.object(forKey: "days_of_weeks") as! (NSString)
                                        let program_name :  (NSString) = dictValues.object(forKey: "program_name") as! (NSString)
                                        
                                        
                                        let finalDays : (NSMutableString) = NSMutableString()
                                        
                                        let  arr1 : (NSArray)  = days_of_weeks.components(separatedBy: ",") as NSArray
                                        for i in 0 ..< arr1.count
                                        {
                                            var dayStr : (NSString) = arr1.object(at: i) as! (NSString)
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
                                            if(i == arr1.count - 1)
                                            {
                                                
                                            }
                                            else
                                            {
                                                finalDays.append(",")
                                            }
                                            
                                        }
                                        let day1 : (CGRect) = finalDays.boundingRect(with: CGSize(width: 100 , height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(10)], context:nil)
                                        viewC.frame = CGRect(x: 0, y: 0, width: 234, height: 112 + day1.height)
                                        
                                        //                    if !viewC.isDescendantOfView(view) {
                                        //                        view.addSubview(viewC)
                                        //                    } else {
                                        //                        viewC.removeFromSuperview()
                                        //  }
                                        
                                        view.addSubview(viewC)
                                        
                                        
                                        if xAxis <= 120 {
                                            viewC.center = CGPoint(x: 80, y: -50 - (day1.height))
                                            let mapImage = UIImage(named: "map-back_bottom_left")
                                            
                                            //  imageView.frame = CGRectMake(0, 0, 234, 120 + day1.height)
                                            imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                                            imageView.image = mapImage
                                            //viewC.addSubview(imageView)
                                        } else if yAxis <= 90 {
                                            viewC.center = CGPoint(x: -60, y: 100 + (day1.height))
                                            imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                                            let mapImage = UIImage(named: "map-back_new")
                                            imageView.image = mapImage
                                            //viewC.addSubview(imageView)
                                        }
                                        else {
                                            let mapImage = UIImage(named: "map-back")
                                            viewC.center = CGPoint(x: -60, y: -50 - (day1.height))
                                            imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                                            imageView.image = mapImage
                                            // viewC.addSubview(imageView)
                                        }
                                        
                                        if xAxis <= 120 && yAxis <= 90 {
                                            viewC.center = CGPoint(x: 80, y: 100 + (day1.height))
                                            imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                                            let mapImage = UIImage(named: "map-back_top_left")
                                            imageView.image = mapImage
                                            //viewC.addSubview(imageView)
                                        }
                                        //imageView.image = UIImage(named: "background")
                                        // imageView.backgroundColor = UIColor.redColor()
                                        viewC.isHidden = false
                                        viewC.addSubview(imageView)
                                        
                                        
                                        
                                        let meetingName : (NSString) = dictValues.object(forKey: "meeting_name") as! (NSString)
                                        let meetingaddress1 : (NSString) = dictValues.object(forKey: "address1") as! (NSString)
                                        let meetingdistance : (NSString) = dictValues.object(forKey: "distance") as! (NSString)
                                        
                                        let disFloat = meetingdistance.floatValue
                                        let finalDistance : (NSString) = NSString(format: "%.2f miles", disFloat)
                                        let meeting_date_time : (NSString) = dictValues.object(forKey: "meeting_date_time") as! (NSString)
                                        let totalAttendies : (NSString) = dictValues.object(forKey: "totalAttendees") as! (NSString)
                                        
                                        
                                        // println(day1.width)
                                        // println(day1.height)
                                        let leftButton : UIButton = UIButton()
                                        leftButton.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
                                        let img = UIImage(named: "place_hold_b")
                                        leftButton.setImage(img, for: UIControlState())
                                        viewC.addSubview(leftButton)
                                        
                                        let namelbl: UILabel = UILabel()
                                        namelbl.frame = CGRect(x: (leftButton.frame.width - 18) / 2, y: (leftButton.frame.height - 20) / 2 , width: 20, height: 20)
                                        namelbl.text = program_name as String
                                        namelbl.font = SMLGlobal.sharedInstance.fontSize(10)
                                        leftButton.addSubview(namelbl)
                                        
                                        let title: UILabel = UILabel()
                                        title.frame = CGRect(x: leftButton.frame.maxX + 5, y: 10, width: 170, height: 20)
                                        title.text = meetingName as String
                                        title.font = SMLGlobal.sharedInstance.fontSize(12)
                                        title.textColor = UIColor.white
                                        viewC.addSubview(title)
                                        
                                        let address: UILabel = UILabel()
                                        address.numberOfLines = 0
                                        address.frame = CGRect(x: title.frame.origin.x , y: title.frame.maxY + 5, width: 150, height: 20)
                                        address.text = meetingaddress1 as String
                                        address.font =  SMLGlobal.sharedInstance.fontSize(10)
                                        address.textColor = UIColor.white
                                        viewC.addSubview(address)
                                        
                                        let distanceLabel: UILabel = UILabel()
                                        distanceLabel.frame = CGRect(x: title.frame.origin.x , y: address.frame.maxY + 5, width: 170, height: 10)
                                        distanceLabel.text = NSString(format: "Distance- %@", finalDistance) as String
                                        distanceLabel.font = SMLGlobal.sharedInstance.fontSize(10)
                                        distanceLabel.textColor = UIColor.white
                                        viewC.addSubview(distanceLabel)
                                        let timingsLabel: UILabel = UILabel()
                                        timingsLabel.frame = CGRect(x: title.frame.origin.x , y: distanceLabel.frame.maxY + 5, width: 120, height: 13)
                                        let timeStr = NSString(format: "Timings - %@", meeting_date_time)
                                        timingsLabel.text = timeStr as String
                                        timingsLabel.font = SMLGlobal.sharedInstance.fontSize(10)
                                        timingsLabel.textColor = UIColor.white
                                        viewC.addSubview(timingsLabel)
                                        
                                        
                                        let dayLabel: UILabel = UILabel()
                                        dayLabel.frame = CGRect(x: title.frame.origin.x, y: timingsLabel.frame.maxY,width: 170, height: day1.height)
                                        dayLabel.numberOfLines = 0
                                        dayLabel.text = "(\(finalDays as String))"
                                        dayLabel.textColor = UIColor.white
                                        dayLabel.font =  SMLGlobal.sharedInstance.fontSize(10)
                                        viewC.addSubview(dayLabel)
                                        
                                        attLabel.frame = CGRect(x: 20,y: dayLabel.frame.maxY + 2 , width: 15, height: 13)
                                        attLabel.backgroundColor = UIColor.clear
                                        //attLabel.tag = arr[i]
                                        let imga = UIImage(named: "white_attendies_icon")
                                        attLabel.setBackgroundImage(imga, for: UIControlState())
                                        viewC.addSubview(attLabel)
                                        
                                        
                                        att.frame = CGRect(x: attLabel.frame.maxX + 2 , y: dayLabel.frame.maxY + 2, width: 50, height: 15)
                                        att.text = "Attendees"
                                        //att.tag = arr[i]
                                        att.font = SMLGlobal.sharedInstance.fontSize(10)
                                        att.textColor = UIColor.white
                                        viewC.addSubview(att)
                                        
                                        attendCountViewMap.frame = CGRect(x: att.frame.maxX,y: att.frame.origin.y, width: 13, height: 13)
                                        attendCountViewMap.backgroundColor = UIColor(red: 255.0/255.0, green: 74.0/255.0, blue: 87.0/255.0, alpha: 1.0)
                                        attendCountViewMap.layer.cornerRadius = attendCountViewMap.frame.size.width/2
                                        viewC.addSubview(attendCountViewMap)
                                        
                                        
                                        countLabelMap.frame = CGRect(x: 0, y: 0, width: 13, height: 13)
                                        countLabelMap.text = totalAttendies as String
                                        countLabelMap.textAlignment = NSTextAlignment.center
                                        countLabelMap.textColor = UIColor.white
                                        countLabelMap.font = SMLGlobal.sharedInstance.fontSize(10)
                                        attendCountViewMap.addSubview(countLabelMap)
                                        
                                        
                                        dir.frame = CGRect(x: viewC.frame.width - 80, y: dayLabel.frame.maxY + 2 , width: 50, height: 15)
                                        dir.text = "Directions"
                                        //dir.tag = arr[i]
                                        dir.font = SMLGlobal.sharedInstance.fontSize(10)
                                        dir.textColor = UIColor.white
                                        viewC.addSubview(dir)
                                        
                                        
                                        dirImg.frame = CGRect(x: dir.frame.maxX,y: dayLabel.frame.maxY + 2, width: 15, height: 13)
                                        dirImg.backgroundColor = UIColor.clear
                                        //dirImg.tag = arr[i]
                                        let imgd = UIImage(named: "direction")
                                        dirImg.setBackgroundImage(imgd, for: UIControlState())
                                        viewC.addSubview(dirImg)
                                        
                                        
                                    
                                }
                            }

                        print(dictValues)

                    }
                }
            }
            else if near == ""
            {
                
                    let xAxis = view.frame.origin.x
                    let yAxis = view.frame.origin.y
                    
                    if(arr.count > 0)
                    {
                        let dictValues : (NSDictionary) = arr.object(at: 0) as! (NSDictionary)
                        let days_of_weeks :  (NSString) = dictValues.object(forKey: "days_of_weeks") as! (NSString)
                        let program_name :  (NSString) = dictValues.object(forKey: "program_name") as! (NSString)
                        
                        
                        let finalDays : (NSMutableString) = NSMutableString()
                        
                        let  arr1 : (NSArray)  = days_of_weeks.components(separatedBy: ",") as NSArray
                        for i in 0 ..< arr1.count
                        {
                            var dayStr : (NSString) = arr1.object(at: i) as! (NSString)
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
                            if(i == arr1.count - 1)
                            {
                                
                            }
                            else
                            {
                                finalDays.append(",")
                            }
                            
                        }
                        let day1 : (CGRect) = finalDays.boundingRect(with: CGSize(width: 100 , height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(10)], context:nil)
                        viewC.frame = CGRect(x: 0, y: 0, width: 234, height: 112 + day1.height)
                        
                        //                    if !viewC.isDescendantOfView(view) {
                        //                        view.addSubview(viewC)
                        //                    } else {
                        //                        viewC.removeFromSuperview()
                        //  }
                        
                        view.addSubview(viewC)
                        
                        
                        if xAxis <= 120 {
                            viewC.center = CGPoint(x: 80, y: -50 - (day1.height))
                            let mapImage = UIImage(named: "map-back_bottom_left")
                            
                            //  imageView.frame = CGRectMake(0, 0, 234, 120 + day1.height)
                            imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                            imageView.image = mapImage
                            //viewC.addSubview(imageView)
                        } else if yAxis <= 90 {
                            viewC.center = CGPoint(x: -60, y: 100 + (day1.height))
                            imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                            let mapImage = UIImage(named: "map-back_new")
                            imageView.image = mapImage
                            //viewC.addSubview(imageView)
                        }
                        else {
                            let mapImage = UIImage(named: "map-back")
                            viewC.center = CGPoint(x: -60, y: -50 - (day1.height))
                            imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                            imageView.image = mapImage
                            // viewC.addSubview(imageView)
                        }
                        
                        if xAxis <= 120 && yAxis <= 90 {
                            viewC.center = CGPoint(x: 80, y: 100 + (day1.height))
                            imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                            let mapImage = UIImage(named: "map-back_top_left")
                            imageView.image = mapImage
                            //viewC.addSubview(imageView)
                        }
                        //imageView.image = UIImage(named: "background")
                        // imageView.backgroundColor = UIColor.redColor()
                        viewC.isHidden = false
                        viewC.addSubview(imageView)
                        
                        
                        
                        let meetingName : (NSString) = dictValues.object(forKey: "meeting_name") as! (NSString)
                        let meetingaddress1 : (NSString) = dictValues.object(forKey: "address1") as! (NSString)
                        let meetingdistance : (NSString) = dictValues.object(forKey: "distance") as! (NSString)
                        
                        let disFloat = meetingdistance.floatValue
                        let finalDistance : (NSString) = NSString(format: "%.2f miles", disFloat)
                        let meeting_date_time : (NSString) = dictValues.object(forKey: "meeting_date_time") as! (NSString)
                        let totalAttendies : (NSString) = dictValues.object(forKey: "totalAttendees") as! (NSString)
                        
                        
                        // println(day1.width)
                        // println(day1.height)
                        let leftButton : UIButton = UIButton()
                        leftButton.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
                        let img = UIImage(named: "place_hold_b")
                        leftButton.setImage(img, for: UIControlState())
                        viewC.addSubview(leftButton)
                        
                        let namelbl: UILabel = UILabel()
                        namelbl.frame = CGRect(x: (leftButton.frame.width - 18) / 2, y: (leftButton.frame.height - 20) / 2 , width: 20, height: 20)
                        namelbl.text = program_name as String
                        namelbl.font = SMLGlobal.sharedInstance.fontSize(10)
                        leftButton.addSubview(namelbl)
                        
                        let title: UILabel = UILabel()
                        title.frame = CGRect(x: leftButton.frame.maxX + 5, y: 10, width: 170, height: 20)
                        title.text = meetingName as String
                        title.font = SMLGlobal.sharedInstance.fontSize(12)
                        title.textColor = UIColor.white
                        viewC.addSubview(title)
                        
                        let address: UILabel = UILabel()
                        address.numberOfLines = 0
                        address.frame = CGRect(x: title.frame.origin.x , y: title.frame.maxY + 5, width: 150, height: 20)
                        address.text = meetingaddress1 as String
                        address.font =  SMLGlobal.sharedInstance.fontSize(10)
                        address.textColor = UIColor.white
                        viewC.addSubview(address)
                        
                        let distanceLabel: UILabel = UILabel()
                        distanceLabel.frame = CGRect(x: title.frame.origin.x , y: address.frame.maxY + 5, width: 170, height: 10)
                        distanceLabel.text = NSString(format: "Distance- %@", finalDistance) as String
                        distanceLabel.font = SMLGlobal.sharedInstance.fontSize(10)
                        distanceLabel.textColor = UIColor.white
                        viewC.addSubview(distanceLabel)
                        let timingsLabel: UILabel = UILabel()
                        timingsLabel.frame = CGRect(x: title.frame.origin.x , y: distanceLabel.frame.maxY + 5, width: 120, height: 13)
                        let timeStr = NSString(format: "Timings - %@", meeting_date_time)
                        timingsLabel.text = timeStr as String
                        timingsLabel.font = SMLGlobal.sharedInstance.fontSize(10)
                        timingsLabel.textColor = UIColor.white
                        viewC.addSubview(timingsLabel)
                        
                        
                        let dayLabel: UILabel = UILabel()
                        dayLabel.frame = CGRect(x: title.frame.origin.x, y: timingsLabel.frame.maxY,width: 170, height: day1.height)
                        dayLabel.numberOfLines = 0
                        dayLabel.text = "(\(finalDays as String))"
                        dayLabel.textColor = UIColor.white
                        dayLabel.font =  SMLGlobal.sharedInstance.fontSize(10)
                        viewC.addSubview(dayLabel)
                        
                        attLabel.frame = CGRect(x: 20,y: dayLabel.frame.maxY + 2 , width: 15, height: 13)
                        attLabel.backgroundColor = UIColor.clear
                        //attLabel.tag = arr[i]
                        let imga = UIImage(named: "white_attendies_icon")
                        attLabel.setBackgroundImage(imga, for: UIControlState())
                        viewC.addSubview(attLabel)
                        
                        
                        att.frame = CGRect(x: attLabel.frame.maxX + 2 , y: dayLabel.frame.maxY + 2, width: 50, height: 15)
                        att.text = "Attendees"
                        //att.tag = arr[i]
                        att.font = SMLGlobal.sharedInstance.fontSize(10)
                        att.textColor = UIColor.white
                        viewC.addSubview(att)
                        
                        attendCountViewMap.frame = CGRect(x: att.frame.maxX,y: att.frame.origin.y, width: 13, height: 13)
                        attendCountViewMap.backgroundColor = UIColor(red: 255.0/255.0, green: 74.0/255.0, blue: 87.0/255.0, alpha: 1.0)
                        attendCountViewMap.layer.cornerRadius = attendCountViewMap.frame.size.width/2
                        viewC.addSubview(attendCountViewMap)
                        
                        
                        countLabelMap.frame = CGRect(x: 0, y: 0, width: 13, height: 13)
                        countLabelMap.text = totalAttendies as String
                        countLabelMap.textAlignment = NSTextAlignment.center
                        countLabelMap.textColor = UIColor.white
                        countLabelMap.font = SMLGlobal.sharedInstance.fontSize(10)
                        attendCountViewMap.addSubview(countLabelMap)
                        
                        
                        dir.frame = CGRect(x: viewC.frame.width - 80, y: dayLabel.frame.maxY + 2 , width: 50, height: 15)
                        dir.text = "Directions"
                        //dir.tag = arr[i]
                        dir.font = SMLGlobal.sharedInstance.fontSize(10)
                        dir.textColor = UIColor.white
                        viewC.addSubview(dir)
                        
                        
                        dirImg.frame = CGRect(x: dir.frame.maxX,y: dayLabel.frame.maxY + 2, width: 15, height: 13)
                        dirImg.backgroundColor = UIColor.clear
                        //dirImg.tag = arr[i]
                        let imgd = UIImage(named: "direction")
                        dirImg.setBackgroundImage(imgd, for: UIControlState())
                        viewC.addSubview(dirImg)
                        
                        
                    }
                    
                

            }
            
    
        }
            
    }
    
    func viewCustomDeatilOnMap(arr:NSArray)
    {
        
            let xAxis = view.frame.origin.x
            let yAxis = view.frame.origin.y
            
            if(arr.count > 0)
            {
                let dictValues : (NSDictionary) = arr.object(at: 0) as! (NSDictionary)
                let days_of_weeks :  (NSString) = dictValues.object(forKey: "days_of_weeks") as! (NSString)
                let program_name :  (NSString) = dictValues.object(forKey: "program_name") as! (NSString)
                
                
                let finalDays : (NSMutableString) = NSMutableString()
                
                let  arr1 : (NSArray)  = days_of_weeks.components(separatedBy: ",") as NSArray
                for i in 0 ..< arr1.count
                {
                    var dayStr : (NSString) = arr1.object(at: i) as! (NSString)
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
                    if(i == arr1.count - 1)
                    {
                        
                    }
                    else
                    {
                        finalDays.append(",")
                    }
                    
                }
                let day1 : (CGRect) = finalDays.boundingRect(with: CGSize(width: 100 , height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(10)], context:nil)
                viewC.frame = CGRect(x: 0, y: 0, width: 234, height: 112 + day1.height)
                
                //                    if !viewC.isDescendantOfView(view) {
                //                        view.addSubview(viewC)
                //                    } else {
                //                        viewC.removeFromSuperview()
                //  }
                
                view.addSubview(viewC)
                
                
                if xAxis <= 120 {
                    viewC.center = CGPoint(x: 80, y: -50 - (day1.height))
                    let mapImage = UIImage(named: "map-back_bottom_left")
                    
                    //  imageView.frame = CGRectMake(0, 0, 234, 120 + day1.height)
                    imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                    imageView.image = mapImage
                    //viewC.addSubview(imageView)
                } else if yAxis <= 90 {
                    viewC.center = CGPoint(x: -60, y: 100 + (day1.height))
                    imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                    let mapImage = UIImage(named: "map-back_new")
                    imageView.image = mapImage
                    //viewC.addSubview(imageView)
                }
                else {
                    let mapImage = UIImage(named: "map-back")
                    viewC.center = CGPoint(x: -60, y: -50 - (day1.height))
                    imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                    imageView.image = mapImage
                    // viewC.addSubview(imageView)
                }
                
                if xAxis <= 120 && yAxis <= 90 {
                    viewC.center = CGPoint(x: 80, y: 100 + (day1.height))
                    imageView.frame = CGRect(x: 0, y: 0, width: 234, height: 120 + day1.height)
                    let mapImage = UIImage(named: "map-back_top_left")
                    imageView.image = mapImage
                    //viewC.addSubview(imageView)
                }
                //imageView.image = UIImage(named: "background")
                // imageView.backgroundColor = UIColor.redColor()
                viewC.isHidden = false
                viewC.addSubview(imageView)
                
                
                
                let meetingName : (NSString) = dictValues.object(forKey: "meeting_name") as! (NSString)
                let meetingaddress1 : (NSString) = dictValues.object(forKey: "address1") as! (NSString)
                let meetingdistance : (NSString) = dictValues.object(forKey: "distance") as! (NSString)
                
                let disFloat = meetingdistance.floatValue
                let finalDistance : (NSString) = NSString(format: "%.2f miles", disFloat)
                let meeting_date_time : (NSString) = dictValues.object(forKey: "meeting_date_time") as! (NSString)
                let totalAttendies : (NSString) = dictValues.object(forKey: "totalAttendees") as! (NSString)
                
                
                // println(day1.width)
                // println(day1.height)
                let leftButton : UIButton = UIButton()
                leftButton.frame = CGRect(x: 10, y: 10, width: 35, height: 35)
                let img = UIImage(named: "place_hold_b")
                leftButton.setImage(img, for: UIControlState())
                viewC.addSubview(leftButton)
                
                let namelbl: UILabel = UILabel()
                namelbl.frame = CGRect(x: (leftButton.frame.width - 18) / 2, y: (leftButton.frame.height - 20) / 2 , width: 20, height: 20)
                namelbl.text = program_name as String
                namelbl.font = SMLGlobal.sharedInstance.fontSize(10)
                leftButton.addSubview(namelbl)
                
                let title: UILabel = UILabel()
                title.frame = CGRect(x: leftButton.frame.maxX + 5, y: 10, width: 170, height: 20)
                title.text = meetingName as String
                title.font = SMLGlobal.sharedInstance.fontSize(12)
                title.textColor = UIColor.white
                viewC.addSubview(title)
                
                let address: UILabel = UILabel()
                address.numberOfLines = 0
                address.frame = CGRect(x: title.frame.origin.x , y: title.frame.maxY + 5, width: 150, height: 20)
                address.text = meetingaddress1 as String
                address.font =  SMLGlobal.sharedInstance.fontSize(10)
                address.textColor = UIColor.white
                viewC.addSubview(address)
                
                let distanceLabel: UILabel = UILabel()
                distanceLabel.frame = CGRect(x: title.frame.origin.x , y: address.frame.maxY + 5, width: 170, height: 10)
                distanceLabel.text = NSString(format: "Distance- %@", finalDistance) as String
                distanceLabel.font = SMLGlobal.sharedInstance.fontSize(10)
                distanceLabel.textColor = UIColor.white
                viewC.addSubview(distanceLabel)
                let timingsLabel: UILabel = UILabel()
                timingsLabel.frame = CGRect(x: title.frame.origin.x , y: distanceLabel.frame.maxY + 5, width: 120, height: 13)
                let timeStr = NSString(format: "Timings - %@", meeting_date_time)
                timingsLabel.text = timeStr as String
                timingsLabel.font = SMLGlobal.sharedInstance.fontSize(10)
                timingsLabel.textColor = UIColor.white
                viewC.addSubview(timingsLabel)
                
                
                let dayLabel: UILabel = UILabel()
                dayLabel.frame = CGRect(x: title.frame.origin.x, y: timingsLabel.frame.maxY,width: 170, height: day1.height)
                dayLabel.numberOfLines = 0
                dayLabel.text = "(\(finalDays as String))"
                dayLabel.textColor = UIColor.white
                dayLabel.font =  SMLGlobal.sharedInstance.fontSize(10)
                viewC.addSubview(dayLabel)
                
                attLabel.frame = CGRect(x: 20,y: dayLabel.frame.maxY + 2 , width: 15, height: 13)
                attLabel.backgroundColor = UIColor.clear
                //attLabel.tag = arr[i]
                let imga = UIImage(named: "white_attendies_icon")
                attLabel.setBackgroundImage(imga, for: UIControlState())
                viewC.addSubview(attLabel)
                
                
                att.frame = CGRect(x: attLabel.frame.maxX + 2 , y: dayLabel.frame.maxY + 2, width: 50, height: 15)
                att.text = "Attendees"
                //att.tag = arr[i]
                att.font = SMLGlobal.sharedInstance.fontSize(10)
                att.textColor = UIColor.white
                viewC.addSubview(att)
                
                attendCountViewMap.frame = CGRect(x: att.frame.maxX,y: att.frame.origin.y, width: 13, height: 13)
                attendCountViewMap.backgroundColor = UIColor(red: 255.0/255.0, green: 74.0/255.0, blue: 87.0/255.0, alpha: 1.0)
                attendCountViewMap.layer.cornerRadius = attendCountViewMap.frame.size.width/2
                viewC.addSubview(attendCountViewMap)
                
                
                countLabelMap.frame = CGRect(x: 0, y: 0, width: 13, height: 13)
                countLabelMap.text = totalAttendies as String
                countLabelMap.textAlignment = NSTextAlignment.center
                countLabelMap.textColor = UIColor.white
                countLabelMap.font = SMLGlobal.sharedInstance.fontSize(10)
                attendCountViewMap.addSubview(countLabelMap)
                
                
                dir.frame = CGRect(x: viewC.frame.width - 80, y: dayLabel.frame.maxY + 2 , width: 50, height: 15)
                dir.text = "Directions"
                //dir.tag = arr[i]
                dir.font = SMLGlobal.sharedInstance.fontSize(10)
                dir.textColor = UIColor.white
                viewC.addSubview(dir)
                
                
                dirImg.frame = CGRect(x: dir.frame.maxX,y: dayLabel.frame.maxY + 2, width: 15, height: 13)
                dirImg.backgroundColor = UIColor.clear
                //dirImg.tag = arr[i]
                let imgd = UIImage(named: "direction")
                dirImg.setBackgroundImage(imgd, for: UIControlState())
                viewC.addSubview(dirImg)
                
                
            }
        
    }
    func mapView(_ mapView: MKMapView!, didDeselect view: MKAnnotationView!) {
        //selectedannotationView = 0
        
        view.removeGestureRecognizer(annotationTap)
        viewC.isHidden = false
        checkInBtn.isHidden = false
        //viewC.removeFromSuperview()
       // checkInBtn.removeFromSuperview()
        
        if(view.image == UIImage(named: "location_Check_selected"))
        {
            let tempImg:UIImage = UIImage(named: "location_Check")!
            view.centerOffset = CGPoint(x: 0, y: -tempImg.size.height / 2);
            view.image = tempImg
        }
        
    }
    
  /* func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!)
    {
        checkInBtn.removeFromSuperview()
//        if (checkInBtn != nil)
//        {
//           
//        }
        
        
        //var array  = annotationViewArray as NSArray
        var selected : MKAnnotation = MKPointAnnotation()
        selected = view.annotation
        let LA = NSString(format: "%.10f", selected.coordinate.latitude)
        let LO = NSString(format: "%.10f", selected.coordinate.longitude)
        var array : (NSArray)
        var predicate = NSPredicate(format: "self.latitude contains %@ AND self.longitude contains %@", LA,LO)
        
        
        
        array =  [finalArray1.filteredArrayUsingPredicate(predicate)]
        // println(self.checkInArray)
        var arr : (NSArray) = NSArray()
        arr  = array.objectAtIndex(0) as! (NSArray)
        
        var days_of_weeks :  (NSString) = (arr.valueForKey("days_of_weeks")?.objectAtIndex(0) as? String)!
        var program_name :  (NSString) = (arr.valueForKey("program_name")?.objectAtIndex(0) as? String)!
        
        
        var finalDays : (NSMutableString) = NSMutableString()
        
        var  arr1 : (NSArray)  = days_of_weeks.componentsSeparatedByString(",")
        for var i = 0; i < arr1.count; i++
        {
            var dayStr : (NSString) = arr1.objectAtIndex(i) as! (NSString)
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
            
            
            finalDays .appendString(dayStr as String)
            if(i == arr.count - 1)
            {
                
            }
            else
            {
                finalDays.appendString(",")
            }
            
        }
        var day1 : (CGRect) = finalDays.boundingRectWithSize(CGSizeMake(50 , CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(8)], context:nil)
        // println(arr)
        if arr.count > 0 {
            // println("Fhdegnsc")
            
            var near : (NSString) = (arr.valueForKey("near_200ft")?.objectAtIndex(0) as? String)!
            if near != ""
            {
                
                
                if(arr.count > 0)
                {
                    
                    
                    var todayDate : (NSDate) = NSDate()
                    var dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "EEE"
                    
                    var todayDay : (NSString) = dateFormatter.stringFromDate(todayDate)
                    var getDay : (Int) = self.checkTodayDay(todayDay)
                    var day : (NSString) = NSString(format: "%d", getDay)
                    
                    var ids : (NSString) = (arr.valueForKey("meeting_id")?.objectAtIndex(0) as? String)!
                    var lat: (NSString) = (arr.valueForKey("latitude")?.objectAtIndex(0) as? String)!
                    var long : (NSString) = (arr.valueForKey("longitude")?.objectAtIndex(0) as? String)!
                    var status : (NSString) = (arr.valueForKey("approval_status")?.objectAtIndex(0) as? String)!
                    //var status : (NSString) = (arr.valueForKey("approval_status")?.objectAtIndex(0) as? String)!
                    
                    checkInDictionary = ["latitude" : lat,
                        "longitude" : long,
                        "meetingId" : ids
                        ,"day" : day,
                        "approval_status" : status]
                    
                    checkInDictionary = arr.objectAtIndex(0) as! (NSDictionary)
                    
                    checkInBtn  = UIButton.buttonWithType(UIButtonType.Custom) as! (UIButton)
                    checkInBtn.frame = CGRectMake(30,0, 100, 30)
                    checkInBtn.addTarget(self, action: "checkInBtnAction:", forControlEvents: .TouchUpInside)
                    checkInBtn.setImage(UIImage(named: "check_in"), forState: .Normal)
                    checkInBtn.userInteractionEnabled = true
                    view.addSubview(checkInBtn)
                    
                    checkInBtn.clipsToBounds=false;
                    meetingMapview.addAnnotation(annotation)
                }
                
                
            }
        }
    }*/
            /*func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!)
            {
//               if(view.subviews containd)
//               {
//               
//                }
//                else
//               {
//                 checkInBtn.removeFromSuperview()
//                }
                
//                if (checkInBtn != nil)
//                {
//                   
//                }
                
                
                //var array  = annotationViewArray as NSArray
                var selected : MKAnnotation = MKPointAnnotation()
                selected = view.annotation
                let LA = NSString(format: "%.10f", selected.coordinate.latitude)
                let LO = NSString(format: "%.10f", selected.coordinate.longitude)
                var array : (NSArray)
                var predicate = NSPredicate(format: "self.latitude contains %@ AND self.longitude contains %@", LA,LO)
                
                
                
                if(finalArray1.count > 0)
                {
                
                
                
                array =  [finalArray1.filteredArrayUsingPredicate(predicate)]
                // println(self.checkInArray)
                var arr : (NSArray) = NSArray()
                arr  = array.objectAtIndex(0) as! (NSArray)
                
                var days_of_weeks :  (NSString) = (arr.valueForKey("days_of_weeks")?.objectAtIndex(0) as? String)!
                var program_name :  (NSString) = (arr.valueForKey("program_name")?.objectAtIndex(0) as? String)!
                
                
                var finalDays : (NSMutableString) = NSMutableString()
                
                var  arr1 : (NSArray)  = days_of_weeks.componentsSeparatedByString(",")
                for var i = 0; i < arr1.count; i++
                {
                    var dayStr : (NSString) = arr1.objectAtIndex(i) as! (NSString)
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
                    
                    
                    finalDays .appendString(dayStr as String)
                    if(i == arr.count - 1)
                    {
                        
                    }
                    else
                    {
                        finalDays.appendString(",")
                    }
                    
                }
                var day1 : (CGRect) = finalDays.boundingRectWithSize(CGSizeMake(50 , CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName  : SMLGlobal.sharedInstance.fontSize(8)], context:nil)
                // println(arr)
                if arr.count > 0 {
                    // println("Fhdegnsc")
                    
                    var imageView : (UIImageView) = UIImageView()
                    
                    var near : (NSString) = (arr.valueForKey("near_200ft")?.objectAtIndex(0) as? String)!
                    if near != ""
                    {
                        
                        
                        if(arr.count > 0)
                        {
                            
                            
                            var todayDate : (NSDate) = NSDate()
                            var dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "EEE"
                            
                            var todayDay : (NSString) = dateFormatter.stringFromDate(todayDate)
                            var getDay : (Int) = self.checkTodayDay(todayDay)
                            var day : (NSString) = NSString(format: "%d", getDay)
                            
                            var ids : (NSString) = (arr.valueForKey("meeting_id")?.objectAtIndex(0) as? String)!
                            var lat: (NSString) = (arr.valueForKey("latitude")?.objectAtIndex(0) as? String)!
                            var long : (NSString) = (arr.valueForKey("longitude")?.objectAtIndex(0) as? String)!
                            var status : (NSString) = (arr.valueForKey("approval_status")?.objectAtIndex(0) as? String)!
                            //var status : (NSString) = (arr.valueForKey("approval_status")?.objectAtIndex(0) as? String)!
                            
                            checkInDictionary = ["latitude" : lat,
                                "longitude" : long,
                                "meetingId" : ids
                                ,"day" : day,
                                "approval_status" : status]
                            
                            checkInDictionary = arr.objectAtIndex(0) as! (NSDictionary)
                            
                            checkInBtn  = UIButton.buttonWithType(UIButtonType.Custom) as! (UIButton)
                            checkInBtn.frame = CGRectMake(30,0, 100, 30)
                            checkInBtn.addTarget(self, action: "checkInBtnAction:", forControlEvents: .TouchUpInside)
                            checkInBtn.setImage(UIImage(named: "check_in"), forState: .Normal)
                            checkInBtn.userInteractionEnabled = true
                            view.addSubview(checkInBtn)
                            
                            checkInBtn.clipsToBounds=false;
                            meetingMapview.addAnnotation(annotation)
                        }
                        
                        
                    }
                    else if near == ""
                    {
                        var xAxis = view.frame.origin.x
                        var yAxis = view.frame.origin.y
                        
                        if(arr.count > 0)
                        {
                            viewC.frame = CGRectMake(0, 0, 234, 112 + day1.height)
                            
                            
                            
                            view.addSubview(viewC)
                            
                            
                            if xAxis <= 120 {
                                viewC.center = CGPointMake(60, -50 - (day1.height))
                                var mapImage = UIImage(named: "map-back_bottom_left")
                                
                                imageView.frame = CGRectMake(0, 0, 234, 100 + day1.height)
                                
                                imageView.image = mapImage
                                viewC.addSubview(imageView)
                            } else if yAxis <= 90 {
                                viewC.center = CGPointMake(-60, 100 + (day1.height))
                                imageView.frame = CGRectMake(0, 0, 234, 100 + day1.height)
                                var mapImage = UIImage(named: "map-back_new")
                                imageView.image = mapImage
                                viewC.addSubview(imageView)
                            }
                            else {
                                var mapImage = UIImage(named: "map-back")
                                viewC.center = CGPointMake(-60, -50 - (day1.height))
                                imageView.frame = CGRectMake(0, 0, 234, 100 + day1.height)
                                imageView.image = mapImage
                                viewC.addSubview(imageView)
                            }
                            
                            if xAxis <= 120 && yAxis <= 90 {
                                viewC.center = CGPointMake(60, 100 + (day1.height))
                                imageView.frame = CGRectMake(0, 0, 234, 100 + day1.height)
                                var mapImage = UIImage(named: "map-back_top_left")
                                imageView.image = mapImage
                                viewC.addSubview(imageView)
                            }
                            
                            
                            
                            
                            var meetingName : (NSString) = (arr.valueForKey("meeting_name")?.objectAtIndex(0) as? String)!
                            var meetingaddress1 : (NSString) = (arr.valueForKey("address1")?.objectAtIndex(0) as? String)!
                            var meetingdistance : (NSString) = (arr.valueForKey("distance")?.objectAtIndex(0) as? String)!
                            var disFloat = meetingdistance.floatValue
                            var finalDistance : (NSString) = NSString(format: "%.2f miles", disFloat)
                            var meeting_date_time : (NSString) = (arr.valueForKey("meeting_date_time")?.objectAtIndex(0) as? String)!
                            
                            
                            println(day1.width)
                            println(day1.height)
                            var leftButton : UIButton = UIButton()
                            leftButton.frame = CGRectMake(10, 10, 35, 35)
                            var img = UIImage(named: "place_hold_b")
                            leftButton.setImage(img, forState: .Normal)
                            viewC.addSubview(leftButton)
                            
                            var namelbl: UILabel = UILabel()
                            namelbl.frame = CGRectMake((leftButton.frame.width - 18) / 2, (leftButton.frame.height - 20) / 2 , 20, 20)
                            namelbl.text = program_name as String
                            namelbl.font = UIFont.systemFontOfSize(12)
                            leftButton.addSubview(namelbl)
                            
                            var title: UILabel = UILabel()
                            title.frame = CGRectMake(CGRectGetMaxX(leftButton.frame) + 10, 10, 170, 15)
                            title.text = meetingName as String
                            title.font = UIFont.systemFontOfSize(12)
                            title.textColor = UIColor.whiteColor()
                            viewC.addSubview(title)
                            
                            var address: UILabel = UILabel()
                            address.numberOfLines = 0
                            address.frame = CGRectMake(CGRectGetMaxX(leftButton.frame) , CGRectGetMaxY(title.frame) + 5, 150, 20)
                            address.text = meetingaddress1 as String
                            address.font = UIFont.systemFontOfSize(8)
                            address.textColor = UIColor.whiteColor()
                            viewC.addSubview(address)
                            
                            var distanceLabel: UILabel = UILabel()
                            distanceLabel.frame = CGRectMake(CGRectGetMaxX(leftButton.frame) , CGRectGetMaxY(address.frame) + 5, 170, 10)
                            distanceLabel.text = NSString(format: "Distance- %@", finalDistance) as String
                            distanceLabel.font = UIFont.systemFontOfSize(10)
                            distanceLabel.textColor = UIColor.whiteColor()
                            viewC.addSubview(distanceLabel)
                            var timingsLabel: UILabel = UILabel()
                            timingsLabel.frame = CGRectMake(CGRectGetMaxX(leftButton.frame) , CGRectGetMaxY(distanceLabel.frame) + 5, 120, 10)
                            var timeStr = NSString(format: "Timings - %@", meeting_date_time)
                            timingsLabel.text = timeStr as String
                            timingsLabel.font = UIFont.systemFontOfSize(10)
                            timingsLabel.textColor = UIColor.whiteColor()
                            viewC.addSubview(timingsLabel)
                            var dayLabel: UILabel = UILabel()
                            dayLabel.frame = CGRectMake(CGRectGetMaxX(timingsLabel.frame) - 5, CGRectGetMaxY(distanceLabel.frame) + 5, day1.width + 5, day1.height )
                            dayLabel.numberOfLines = 0
                            dayLabel.text = "(\(finalDays as String))"
                            dayLabel.textColor = UIColor.whiteColor()
                            dayLabel.font = UIFont.systemFontOfSize(6)
                            viewC.addSubview(dayLabel)
                            var attLabel: UIButton = UIButton()
                            attLabel.frame = CGRectMake(10,CGRectGetMaxY(dayLabel.frame) + 2 , 15, 13)
                            attLabel.backgroundColor = UIColor.clearColor()
                            //attLabel.tag = arr[i]
                            var imga = UIImage(named: "white_attendies_icon")
                            attLabel.setBackgroundImage(imga, forState: .Normal)
                            viewC.addSubview(attLabel)
                            
                            var att: UILabel = UILabel()
                            att.frame = CGRectMake(CGRectGetMaxX(attLabel.frame) + 2 , CGRectGetMaxY(dayLabel.frame) + 2, 50, 15)
                            att.text = "Attendees"
                            //att.tag = arr[i]
                            att.font = UIFont.systemFontOfSize(8)
                            att.textColor = UIColor.whiteColor()
                            viewC.addSubview(att)
                            var v = viewC.frame.width
                            //println(v)
                            
                            
                            
                            
                            var dir: UILabel = UILabel()
                            dir.frame = CGRectMake( viewC.frame.width - 75, CGRectGetMaxY(dayLabel.frame) + 2 , 40, 15)
                            dir.text = "Direction"
                            //dir.tag = arr[i]
                            dir.font = UIFont.systemFontOfSize(8)
                            dir.textColor = UIColor.whiteColor()
                            viewC.addSubview(dir)
                            
                            var dirImg: UIButton = UIButton()
                            dirImg.frame = CGRectMake(CGRectGetMaxX(dir.frame),CGRectGetMaxY(dayLabel.frame) + 2, 15, 13)
                            dirImg.backgroundColor = UIColor.clearColor()
                            //dirImg.tag = arr[i]
                            var imgd = UIImage(named: "direction")
                            dirImg.setBackgroundImage(imgd, forState: .Normal)
                            viewC.addSubview(dirImg)
                            
                            
                            
                            meetingMapview.addAnnotation(annotation)
                        }
                    }
                    
                    
                }
            }
    }*/
    
    func CheckInBtnAction()
    {
        
        
        let userInfo : (SMLAppUser) = SMLAppUser.getUser()
        let userCheck : (NSString) = userInfo.upgrade
      //  if(userCheck == "1")
        if(true)  // Temprory for remove In App Purchase Remove
   
        {
            
            let todayDate : (Date) = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEE"
            
            let todayDay : (NSString) = dateFormatter.string(from: todayDate) as (NSString)
            let getDay : (Int) = self.checkTodayDay(todayDay)
            let day : (NSString) = NSString(format: "%d", getDay)
            
            let ids : (NSString) = checkInDictionary.object(forKey: "meeting_id") as! NSString
            let lat: (NSString) = checkInDictionary.object(forKey: "latitude") as! NSString
            let long : (NSString) = checkInDictionary.object(forKey: "longitude") as! String as (NSString)
            
            
            
            
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
            let checkTime : (NSString) = checkInDictionary.object(forKey: "meeting_date_time") as! NSString
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
     
    }
    
    func checkInBtnAction(_ sender:UIButton)
    {
        
        let userDefaults : UserDefaults = UserDefaults.standard
  
        
        
 
            
            let userInfo : (SMLAppUser) = SMLAppUser.getUser()
            let userCheck : (NSString) = userInfo.upgrade
            // if(userCheck == "1")  // Temprory for remove In App Purchase Remove
            if(true)
                
            {
                
                self.CheckInBtnAction()
            }
            else
            {
                self.displayUpgrade()
                
            }
        
        
    }
    
    func checkNearFeetforCheckIn(dictLoaction2 : NSDictionary) -> Bool
    {
        let dict : (NSDictionary) = UserDefaults.standard.object(forKey: "Location") as! NSDictionary
        var latStr1: (NSString) = NSString()
        var longStr1 : (NSString) = NSString()
        var latStr2: (NSString) = NSString()
        var longStr2 : (NSString) = NSString()
        
        
        latStr1 = dict.value(forKey: "latitude") as! String as (NSString)
        longStr1 = dict.value(forKey: "longitude") as! String as (NSString)
        
        let latitude1 : (CLLocationDegrees) = latStr1.doubleValue
        let longitude1 : (CLLocationDegrees) = longStr1.doubleValue
        
        
        latStr2  = dictLoaction2.object(forKey: "latitude") as! NSString
        longStr2 = dictLoaction2.object(forKey: "longitude") as! String as (NSString)
        
        let latitude2 : (CLLocationDegrees) = latStr2.doubleValue
        let longitude2 : (CLLocationDegrees) = longStr2.doubleValue
        
        let location1 = CLLocationCoordinate2D(latitude: latitude1, longitude: longitude1)
        let location2 = CLLocationCoordinate2D(latitude: latitude2, longitude: longitude2)
        
        let differenceinFeet :Double  = self.differenceinFeet(place1: location1, place2: location2)
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
            return false;
        }
        else
        {
            return true
        }

    }
    //MARK:- Upgrade View
    func displayUpgrade()
    {
        
        self.upGradebackView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        self.upGradebackView.backgroundColor = UIColor(white: 0.05, alpha: 0.5)
        self.view.addSubview(self.upGradebackView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(meetingFinderViewController.removeUpgradeView(_:)))
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
        upgradeButton.addTarget(self, action: #selector(meetingFinderViewController.upgradeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        backGroundView.addSubview(upgradeButton)
        
        let cancleButton: UIButton = UIButton()
        cancleButton.frame = CGRect(x: upgradeButton.frame.maxX+5, y: label4.frame.maxY + 20, width: 111, height: 37)
        //cancleButton.backgroundColor = UIColor.blackColor()
        let cnImg = UIImage(named: "popupcancel")
        cancleButton.setBackgroundImage(cnImg, for: UIControlState())
        cancleButton.addTarget(self, action: #selector(meetingFinderViewController.cancleButtonClick1(_:)), for: UIControlEvents.touchUpInside)
        backGroundView.addSubview(cancleButton)
        
    }
    
    func removeUpgradeView(_ gesture : UITapGestureRecognizer)
    {
        upGradebackView.removeFromSuperview()
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
        Timer .scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(meetingFinderViewController.startRestore), userInfo: nil, repeats: false)
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
        self.upGradebackView.removeFromSuperview()
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
            
            
            let detailMeeting : (MeetingDetailViewController) = MeetingDetailViewController()
            detailMeeting.detailArray = checkInDictionary
            //detailMeeting.detailArray   = finalArray1.objectAtIndex(indexPath.row) as! (NSDictionary)
            self.navigationController?.pushViewController(detailMeeting, animated: false)
            
        }
    }
    
    //MARK :- Request For products
    func productsRequest(_ request: SKProductsRequest!, didReceive response: SKProductsResponse!) {
        
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
    }
    



