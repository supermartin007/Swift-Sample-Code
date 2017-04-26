//
//  checkInViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 23/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class checkInViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate, UITextFieldDelegate,UIAlertViewDelegate {
    
    var meetingNavigationView : UIView = UIView()
    var checkINMap  : MKMapView = MKMapView()
    var navView: UIView = UIView()
    var textView : UITextField = UITextField()
    
    var timer : (Timer)!
    
    var currMin : (Int)!
    
    var checkInDict : (NSDictionary)!
    
    var timerNoLabel : UILabel!
    
    
    var attendanceId = NSString()
    let blurView : UIView = UIView()


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
//         var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        checkInDict = delegate.checkInDictionary
        

        


        meetingNavigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 100)
        meetingNavigationView.backgroundColor = UIColor(red: 0 / 255.0, green:135.0 / 255, blue: 206.0 / 255, alpha: 1.0)
        self.view.addSubview(meetingNavigationView)
        
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        
        
        checkINMap.frame = CGRect(x: 0, y: meetingNavigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - meetingNavigationView.frame.maxY)
        self.view.addSubview(checkINMap)
        checkINMap.delegate = self
        
        
        let meetingNodeTitel: UILabel = UILabel()
        meetingNodeTitel.text = "Check In"
        meetingNodeTitel.font = SMLGlobal.sharedInstance.fontSize(14)
        meetingNodeTitel.textColor = UIColor.white
        
        meetingNavigationView.addSubview(meetingNodeTitel)
        
        let leftHomeButton : UIButton = UIButton()
        let homeImage: UIImage = UIImage(named: "back_errow")!
       leftHomeButton.setBackgroundImage(homeImage, for: UIControlState())
        leftHomeButton.addTarget(self, action: #selector(checkInViewController.homeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        meetingNavigationView.addSubview(leftHomeButton)
        
        /* Create Top Custom Right Button View */
        
        let addButton: UIButton = UIButton()
        
        //addButton.addTarget(self, action: "addButtonClick:", forControlEvents: UIControlEvents.TouchUpInside)
        //rightButton.backgroundColor = UIColor.whiteColor()
        let rightButtonImage: UIImage = UIImage(named: "arrow")!
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addButton.setBackgroundImage(rightButtonImage, for: UIControlState())
       // meetingNavigationView.addSubview(addButton)
        
        
        
        let screenMid = ScreenSize.width / 2
        
        if (self.view.frame.height >= 667.0) {
            
            
            
            meetingNodeTitel.frame = CGRect(x: screenMid - 20, y: meetingNavigationView.frame.height - 73, width: 100, height: 30)
            
            
            
            //addButton.frame = CGRectMake(ScreenSize.width - 44, sgmentViewHeight / 4, 30, 30)
            
            
            
        }
        else
        {
            meetingNodeTitel.frame = CGRect(x: screenMid - 20 , y: meetingNavigationView.frame.height - 73, width: 100, height: 30)
            //leftHomeButton.frame = CGRectMake(16, sgmentViewHeight / 3.8, 25, 25)
            
            
        }
        addButton.frame = CGRect(x: ScreenSize.width - 44, y: meetingNavigationView.frame.height - 73, width: 28, height: 29)
        leftHomeButton.frame = CGRect(x: 16, y: meetingNavigationView.frame.height - 65, width: 20 , height: 20)
        

        
        let value = meetingNavigationView.frame.height - 50
        
        let searchView: UIButton = UIButton()
        searchView.frame = CGRect(x: 20, y: value + 13, width: ScreenSize.width - 40,  height: 20 * 1.35)
        searchView.backgroundColor = UIColor.white
        searchView.layer.cornerRadius = 0.04 * searchView.frame.width
        searchView.layer.borderColor = UIColor.clear.cgColor
        //searchBarView.showsBookmarkButton = true
        searchView.clipsToBounds = true
        meetingNavigationView.addSubview(searchView)
        
        
        textView.frame = CGRect(x: 30, y: 0, width: searchView.frame.width - 50,  height: 20 * 1.35)
        textView.delegate = self
        textView.isEnabled = false
        let placeholder1 = NSAttributedString(string: "Click Here To Search", attributes: [NSForegroundColorAttributeName : UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.6)])
        textView.attributedPlaceholder = placeholder1;
        textView.font = SMLGlobal.sharedInstance.fontSize(10)
        searchView.addSubview(textView)
        
        let UIImg : UIButton = UIButton()
        UIImg.frame = CGRect(x: searchView.frame.width - 27,y: (searchView.frame.size.height - 25)/2, width: 25, height: 25)
        let  butImg = UIImage(named: "search_arrow_icon")
        UIImg.setBackgroundImage(butImg, for: UIControlState())
       // UIImg.addTarget(self, action: #selector(checkInViewController.searchButt(_:)), for: UIControlEvents.touchUpInside)
        searchView.addSubview(UIImg)
        
        let searchIcon : UIImageView = UIImageView()
        searchIcon.frame = CGRect(x: 5, y: 3.5, width: 20, height: 20)
        searchIcon.image = UIImage(named: "search_icon")
        searchView.addSubview(searchIcon)
        
        // edit by tijender
       // let blurView : UIView = UIView()
        blurView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: checkINMap.frame.height)
        blurView.backgroundColor = UIColor(white: 0.05, alpha: 0.5)
        checkINMap.addSubview(blurView)

//        image.layer.borderWidth = 1
//        image.layer.masksToBounds = false
//        image.layer.borderColor = UIColor.blackColor().CGColor
//        image.layer.cornerRadius = image.frame.height/2
//        image.clipsToBounds = true
        
        let backCircle : UIView = UIView()
        backCircle.frame = CGRect(x: (ScreenSize.width - 150) / 2, y: (checkINMap.frame.height - 200) / 2, width: 150, height: 150)
        backCircle.backgroundColor = UIColor.lightGray
                backCircle.layer.borderWidth = 1
                backCircle.layer.masksToBounds = false
                backCircle.layer.borderColor = UIColor.lightGray.cgColor
                backCircle.layer.cornerRadius = backCircle.frame.height/2
                backCircle.clipsToBounds = true
        blurView.addSubview(backCircle)
        
        let fontCircle : UIView = UIView()
        fontCircle.frame = CGRect(x: 5, y: 5, width: 140, height: 140)
        fontCircle.backgroundColor = UIColor(red: 93 / 255, green: 185 / 255, blue: 236 / 255, alpha: 1)
        fontCircle.layer.borderWidth = 1
        fontCircle.layer.masksToBounds = false
        fontCircle.layer.borderColor = UIColor.clear.cgColor
        fontCircle.layer.cornerRadius = fontCircle.frame.height/2
        fontCircle.clipsToBounds = true
        backCircle.addSubview(fontCircle)
        
        timerNoLabel  = UILabel()
        timerNoLabel.frame = CGRect(x: 0, y: (fontCircle.frame.height - 50) /  2, width: fontCircle.frame.size.width, height: 50)
       // timerNoLabel.text = "6"
        timerNoLabel.textColor = UIColor.white
        timerNoLabel.textAlignment = NSTextAlignment.center
        timerNoLabel.font =  SMLGlobal.sharedInstance.fontSize(24)
        fontCircle.addSubview(timerNoLabel)
        
        
        let mID  : (NSString) = (checkInDict.object(forKey: "meetingId") as? NSString)!
        
        if AppDelegate.sharedInstance().meetingIdAttendMetting == ""
        {
        
        //UIAlertView(title: "", message: "Meeting Attendance has been started, you must remain at this meeting for 55 minutes minimum in order to complete the check in", delegate: nil, cancelButtonTitle: "OK").show()
            self.checkInWebservice()
            
        }
        else
        {
            if mID as String != AppDelegate.sharedInstance().meetingIdAttendMetting
            {
                
                UIAlertView(title: "", message: "You are Alredy CheckIn in another meeting", delegate: self, cancelButtonTitle: "OK").show()
                return
                
            }
            self.start()

        }
        self.displayAnnotations()

        AppDelegate.sharedInstance().meetingIdAttendMetting = mID as String
        
        
        
        // Do any additional setup after loading the view.
    }
    

    
    func start()
    {
        //Change Time Rajni  //Change Time 35 minutes to 1 minute
       currMin = 55
        let mID  : (NSString) = (checkInDict.object(forKey: "meetingId") as? NSString)!
         let currentDate : (Date) = Date()
        if((UserDefaults.standard.object(forKey: "Timer")) != nil)
        {

           //var userDefault: NSMutableArray = NSUserDefaults.standardUserDefaults().objectForKey("Timer") as! NSMutableArray
            
            
            let previousArray : NSMutableArray = UserDefaults.standard.object(forKey: "Timer") as! NSMutableArray
            let dict : (NSMutableDictionary) = ["MeetingID" : mID,
                "CurrentTime" : currentDate
                ,"Attendance Id" : self.attendanceId]
            let predicate : (NSPredicate) = NSPredicate(format: "self.MeetingID == %@", mID)
            let arr : (NSArray) = previousArray.filtered(using: predicate) as (NSArray)
            if(arr.count == 0)
            {
                let a : (NSMutableArray) = previousArray.mutableCopy() as! NSMutableArray
                a.add(dict)
                UserDefaults.standard.set(a, forKey:"Timer")
//                userDefault = NSMutableDictionary(objects: NSArray(objects: userDefault) as! NSArray as [AnyObject], forKeys: "")
            
            }
            else
            {
             let dict : (NSDictionary) = arr.object(at: 0) as! (NSDictionary)
           // arr = arr.objectAtIndex(0) as! (NSArray)
             let previousTime: (Date) = dict.object(forKey: "CurrentTime") as! Date

                _ = NSString()
                var com : (DateComponents) = Constants.myGlobalFunction.dateDifference(previousTime, toDate: currentDate)
                let totalMIn : (Int) = com.minute!
                
                //Rajni Change Time 55 minutes to 1 minute
                currMin = 55 - totalMIn
                
                if(currMin == 0)
                {
                    if (timer != nil)
                    {
                        timer.invalidate()
                        AppDelegate.sharedInstance().timerAttendMetting.invalidate()
                    }
                    UIAlertView(title: "", message: "Meeting approved by user", delegate: nil, cancelButtonTitle: "OK").show()
                    _ = navigationController?.popViewController(animated: false)
                    return
                }
                
  
            }
            
            
           
        }
        else
        {
             let dict : (NSMutableDictionary) = ["MeetingID" : mID,
                "CurrentTime" : currentDate,
                "Attendance Id" : self.attendanceId]
            
            let array : (NSMutableArray) = NSMutableArray(object: dict)
             UserDefaults.standard.set(array, forKey: "Timer")
        }
        
       // var userDefault: NSMutableArray = NSUserDefaults.standardUserDefaults().objectForKey("Timer") as! NSMutableArray
        
        
        timer  = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(checkInViewController.timerFired), userInfo: nil, repeats: true)
        AppDelegate.sharedInstance().timerAttendMetting  = Timer.scheduledTimer(timeInterval: 60.0, target: AppDelegate.sharedInstance(), selector: #selector(AppDelegate.sharedInstance().timerFired), userInfo: nil, repeats: true)

        timerNoLabel.text = NSString(format: "%d min", currMin) as String
        
    }
    func timerFired()
    {
        // edit by tijender
       // blurView.isHidden = true // false
        
        currMin = currMin - 1
        print(currMin)
        if(currMin < 0)
        {
        //    blurView.isHidden = true;
            timer.invalidate()
            AppDelegate.sharedInstance().timerAttendMetting.invalidate()

            let alertView = UIAlertView(title: "", message: "Time Completes now", delegate: self, cancelButtonTitle: "Ok")
            alertView.show()
//            var userDefault = NSUserDefaults.standardUserDefaults()
//            userDefault.setInteger(currMin, forKey: "Timer")
            timerNoLabel.text = NSString(format: "%d min", currMin) as String
         }
        else
        {
// chnageddddddd
         if(currMin == 0)
         {
         //   blurView.isHidden = true;
            timer.invalidate()
            AppDelegate.sharedInstance().timerAttendMetting.invalidate()

            Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkInViewController.attendanceApprove), userInfo: nil, repeats: false)

            //println("Timer Out")
         }
         else
         {
         //   blurView.isHidden = false;

            timerNoLabel.text = NSString(format: "%d min", currMin) as String
            
            //var userDefault = NSUserDefaults.standardUserDefaults()
            
            //userDefault.setInteger(currMin, forKey: "Timer")
            }
            
        }

        }
  
    
    func attendanceApprove()
    {
        self.attendiesApproveWebservice()
    }

    func attendiesApproveWebservice()
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
       
        //SVProgressHUD.showWithStatus("Loading")
         SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
        
            let userInfo : (SMLAppUser) = SMLAppUser.getUser()
            let userId : (NSString) = userInfo.userId
        //http://104.236.197.214/index.php/login/wsmeetingAttendedApproved?attendance_id=27
            
        let parameters : (NSDictionary) = ["attendance_id" : self.attendanceId,"user_id":userId]
        WebserviceManager.sharedInstance.meetingAttendedApproval(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                
                AppDelegate.sharedInstance().timerAttendMetting.invalidate()
                AppDelegate.sharedInstance().timerAttendMetting = nil
                AppDelegate.sharedInstance().meetingIdAttendMetting = ""
                AppDelegate.sharedInstance().attendanceIdAttendMetting = ""
                
                
                

                if success == 0
                {
                    let alertView = UIAlertView(title: "", message:message as NSString as String, delegate: nil, cancelButtonTitle: "Ok")
                    alertView.show()
                    SVProgressHUD .dismiss()
                }
                else if success == 1
                {
                    let alertView = UIAlertView(title: "", message:message as NSString as String, delegate: nil, cancelButtonTitle: "Ok")
                    alertView.show()
                    SVProgressHUD .dismiss()
                    self.backView()
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

    //MARK:- Webservice Methods
    func checkInWebservice()  
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
       // SVProgressHUD.showWithStatus("Loading")
         SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
      //http://104.236.197.214/index.php/login/wsmeetingAttended?user_id=216&meeting_id=260&day=5
        let user : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = user.userId
        let meetId : (NSString) = checkInDict.object(forKey: "meetingId") as! NSString
        let day : (NSString) = checkInDict.object(forKey: "day") as! NSString
        let parameters : (NSDictionary) = ["user_id" : loginId,
                                            "meeting_id" : meetId,
                                            "day" : day]
        print(parameters)
        WebserviceManager .sharedInstance.checkInMeeting(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                if success == 0
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                    
                    self.timerNoLabel.text = "0 min"
                    SVProgressHUD .dismiss()
                }
                else if success == 1
                {
                    UIApplication.shared.isIdleTimerDisabled = true
                    let attend : (Int) = responseObject!.value(forKey: "attendence_id") as! Int
                    self.attendanceId = NSString(format: "%d", attend)
                    AppDelegate.sharedInstance().attendanceIdAttendMetting = self.attendanceId as String

                    SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
//                    var alertView = UIAlertView(title: "", message:message as NSString as String, delegate: nil, cancelButtonTitle: "Ok")
//                    alertView.show()
                    SVProgressHUD .dismiss()
                    self.start()
                }
            }
            else
            {
                let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                SVProgressHUD .dismiss()
            }
        }
        }
        else
        {
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }
    
    
    func displayAnnotations()
    {
        
        
            let latitudeStr : (NSString) = checkInDict.object(forKey: "latitude") as! NSString
            let longitudeStr : (NSString) = checkInDict.object(forKey: "longitude") as! NSString
        
            
            
            let MomentaryLatitude = latitudeStr.doubleValue
            let MomentaryLongitude = longitudeStr.doubleValue

            let latitude: (CLLocationDegrees)  = MomentaryLatitude
            let longitude: (CLLocationDegrees)  = MomentaryLongitude
            
            
            
            latdelta = 0.5
            londelta = 0.5
       
            
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(latdelta, londelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude )
            let resion:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            
            checkINMap.setRegion(resion, animated: true)
            annotation = MKPointAnnotation()
            annotation.coordinate = location
        
        
        
            let leftButton : UIButton = UIButton()
            leftButton.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
            let img = UIImage(named: "place_hold_b")
            leftButton.setImage(img, for: UIControlState())
            checkINMap.addAnnotation(annotation)
            
            
       
        
        
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
       _ = navigationController?.popViewController(animated: false)
    }

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func homeButtonClick(_ sender: UIButton)
    {
        _ = navigationController?.popViewController(animated: false)
    }
    func backView()
    {
        _ = navigationController?.popViewController(animated: false)

    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        return true
    }
    func alertView(alertView: UIAlertView!, clickedButtonAtIndex buttonIndex: Int)
    {
        _ = navigationController?.popViewController(animated: false)
    }
}
