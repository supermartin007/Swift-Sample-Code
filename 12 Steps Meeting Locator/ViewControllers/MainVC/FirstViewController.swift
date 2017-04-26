//
//  ViewController.swift
//  mainView
//
//  Created by iapp on 01/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import GoogleMobileAds

var attendedMeeting : (UIButton)!
var attendMeetingCount : (UILabel)!
//let ScreenSize = UIScreen.mainScreen().bounds.size
var i = 1
class FirstViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate,GADBannerViewDelegate
{
    var adMobView = GADBannerView()
    let meetingAttend = UIImageView()
    let notesImage = UIImageView()
    let notes1: UIButton = UIButton()
    let motivationalWallImage = UIImageView()
    let motivationalWall: UIButton = UIButton()
    let callSponsorImage = UIImageView()
    let callSponsor: UIButton = UIButton()
    let sobrietyImage = UIImageView()
    let sobriety: UIButton = UIButton()
    let checkInImage = UIImageView()
    let checkIn: UIButton = UIButton()
    let addMettingImage = UIImageView()
    let addMetting: UIButton = UIButton()
    let mettingFinder: UIButton = UIButton()
    let titleLabel = UILabel()
    let editBtn = UIButton.init(type: UIButtonType.custom)
    let backBtn = UIButton.init(type: UIButtonType.custom)
    let navigationView = UIView()

    
//    convenience init(frame: CGRect)
//    {
//        self.init(nibName: nil,bundle: nil)
//
//        view.backgroundColor = UIColor.gray
//        
//        //println(ScreenSize)
//        
//        let screenHeight = ScreenSize.height / 1.4  //Screen Height
//        let locationManager : CLLocationManager = CLLocationManager()
//        let buttonwidthScreen = ScreenSize.width / 2 //Button Width
//        //println(buttonwidthScreen)
//       
//        mapview.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height - screenHeight)
//        view.addSubview(mapview)
//        mapview.delegate = self
//        
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        
//        let mapheight = mapview.frame.height
//        let screen = ScreenSize.height - mapheight - 50
//        //scr
//        
//        let buttonHeight = screen / 4
//       // println(screen)
//        //println(mapheight)
//        //println(buttonHeight)
//        
//        let mettingFinder: UIButton = UIButton()
//        mettingFinder.frame = CGRect(x: 0, y: mapheight, width: buttonwidthScreen - 2, height: buttonHeight - 2)
//        mettingFinder.backgroundColor = UIColor.white
//        mettingFinder.titleEdgeInsets = UIEdgeInsetsMake(60, 10, 0, 10)
//        mettingFinder.addTarget(self, action: #selector(FirstViewController.mettingFinderClick(_:)), for: UIControlEvents.touchUpInside)
//        mettingFinder.setTitle("Metting Finder", for: UIControlState())
//        mettingFinder.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
//        view.addSubview(mettingFinder)
//        
//        mettingFinder.setTitleColor(UIColor.black, for: UIControlState())
//        
//        let meetingImage = UIImageView()
//        meetingImage.image = UIImage(named: "meeting_finder")
//        meetingImage.frame = CGRect(x: (mettingFinder.frame.size.width - 65)/2, y: 5,width: 61, height: 61)
//        mettingFinder.addSubview(meetingImage)
//
//        
//        addMetting.frame = CGRect(x: buttonwidthScreen, y: mapheight, width: buttonwidthScreen , height: buttonHeight - 2)
//        addMetting.backgroundColor = UIColor.white
//        addMetting.titleEdgeInsets = UIEdgeInsetsMake(60, 10, 0, 10)
//        
//         addMetting.addTarget(self, action: #selector(FirstViewController.addMettingClick(_:)), for: UIControlEvents.touchUpInside)
//        addMetting.setTitle("Add Metting", for: UIControlState())
//        addMetting.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
//        view.addSubview(addMetting)
//        
//        addMetting.setTitleColor(UIColor.black, for: UIControlState())
//        
//        let addMettingImage = UIImageView()
//        addMettingImage.image = UIImage(named: "add_meeting")
//        addMettingImage.frame = CGRect(x: (addMetting.frame.size.width - 65)/2, y: 5,width: 61, height: 61)
//        addMetting.addSubview(addMettingImage)
//        
//        let checkIn: UIButton = UIButton()
//        checkIn.frame = CGRect(x: 0, y: mapheight + mettingFinder.frame.height + 2, width: buttonwidthScreen - 2, height: buttonHeight - 2)
//        checkIn.titleEdgeInsets = UIEdgeInsetsMake(60, 10, 0, 10)
//        checkIn.backgroundColor = UIColor.white
//        checkIn.setTitle("Check In", for: UIControlState())
//        checkIn.addTarget(self, action: #selector(FirstViewController.checkInClick(_:)), for: UIControlEvents.touchUpInside)
//        checkIn.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
//        checkIn.setTitleColor(UIColor.black, for: UIControlState())
//        view.addSubview(checkIn)
//        
//        let checkInImage = UIImageView()
//        checkInImage.image = UIImage(named: "checkin")
//        checkInImage.frame = CGRect(x: (checkIn.frame.size.width - 65)/2, y: 5,width: 61, height: 61)
//        checkIn.addSubview(checkInImage)
//        
//        let sobriety: UIButton = UIButton()
//        sobriety.frame = CGRect(x: buttonwidthScreen, y: mapheight + mettingFinder.frame.height + 2, width: buttonwidthScreen , height: buttonHeight - 2)
//        sobriety.titleEdgeInsets = UIEdgeInsetsMake(60, 10, 0, 10)
//        sobriety.backgroundColor = UIColor.white
//        sobriety.setTitle("Soberty Calculator", for: UIControlState())
//        sobriety.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
//         sobriety.addTarget(self, action: #selector(FirstViewController.sobrietyClick(_:)), for: UIControlEvents.touchUpInside)
//        sobriety.setTitleColor(UIColor.black, for: UIControlState())
//        view.addSubview(sobriety)
//        
//        let sobrietyImage = UIImageView()
//        sobrietyImage.image = UIImage(named: "soberty_calculator")
//        sobrietyImage.frame = CGRect(x: (sobriety.frame.size.width - 65)/2, y: 5,width: 61, height: 61)
//        sobriety.addSubview(sobrietyImage)
//        
//        let callSponsorHeight = mapheight + (mettingFinder.frame.height * 2) + 4
//        let callSponsor: UIButton = UIButton()
//        callSponsor.frame = CGRect(x: 0, y: callSponsorHeight , width: buttonwidthScreen - 2, height: buttonHeight - 2)
//        callSponsor.backgroundColor = UIColor.white
//        callSponsor.titleEdgeInsets = UIEdgeInsetsMake(60, 10, 0, 10)
//       // callSponsor.setImage(callSponsorImage, forState: .Normal)
//        callSponsor.setTitle("Call Sponsor", for: UIControlState())
//        callSponsor.addTarget(self, action: #selector(FirstViewController.callSponsorClick(_:)), for: UIControlEvents.touchUpInside)
//        callSponsor.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
//        callSponsor.setTitleColor(UIColor.black, for: UIControlState())
//        view.addSubview(callSponsor)
//        
//        let callSponsorImage = UIImageView()
//        callSponsorImage.image = UIImage(named: "call_sponser")
//        callSponsorImage.frame = CGRect(x: (callSponsor.frame.size.width - 65)/2, y: 5,width: 61, height: 61)
//        callSponsor.addSubview(callSponsorImage)
//        
//        let contacts: UIButton = UIButton()
//        contacts.frame = CGRect(x: buttonwidthScreen, y: callSponsorHeight, width: buttonwidthScreen , height: buttonHeight - 2)
//        contacts.backgroundColor = UIColor.white
//        contacts.titleEdgeInsets = UIEdgeInsetsMake(60, 10, 0, 10)
//        //contacts.setImage(contactsImage, forState: .Normal)
//        contacts.setTitle("Contacts", for: UIControlState())
//        contacts.addTarget(self, action: #selector(FirstViewController.contactsClick(_:)), for: UIControlEvents.touchUpInside)
//        contacts.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
//        contacts.setTitleColor(UIColor.black, for: UIControlState())
//        view.addSubview(contacts)
//        
//        let contactsImage = UIImageView()
//        contactsImage.image = UIImage(named: "contact")
//        contactsImage.frame = CGRect(x: (contacts.frame.size.width - 65)/2, y: 5,width: 61, height: 61)
//        contacts.addSubview(contactsImage)
//
//        let motivationalWallHeight = mapheight + (mettingFinder.frame.height * 3) + 6
//        let motivationalWall: UIButton = UIButton()
//        motivationalWall.frame = CGRect(x: 0, y: motivationalWallHeight, width: buttonwidthScreen - 2, height: buttonHeight - 2)
//        motivationalWall.backgroundColor = UIColor.white
//        motivationalWall.titleEdgeInsets = UIEdgeInsetsMake(60, 10, 0, 10)
////        motivationalWall.setImage(motivationalImage, forState: .Normal)
//        motivationalWall.setTitle("Motivational Wall", for: UIControlState())
//        motivationalWall.addTarget(self, action: #selector(FirstViewController.motivationalWallClick(_:)), for: UIControlEvents.touchUpInside)
//        motivationalWall.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
//        motivationalWall.setTitleColor(UIColor.black, for: UIControlState())
//        view.addSubview(motivationalWall)
//        
//        let motivationalWallImage = UIImageView()
//        motivationalWallImage.image = UIImage(named: "motivationalwall")
//        motivationalWallImage.frame = CGRect(x: (motivationalWall.frame.size.width - 65)/2, y: 5,width: 61, height: 61)
//        motivationalWall.addSubview(motivationalWallImage)
//        
//        let notes: UIButton = UIButton()
//        notes.frame = CGRect(x: buttonwidthScreen, y: motivationalWallHeight, width: buttonwidthScreen , height: buttonHeight - 2)
//        notes.backgroundColor = UIColor.white
//        notes.titleEdgeInsets = UIEdgeInsetsMake(60, 10, 0, 10)
//       // notes.setImage(notesImage, forState: .Normal)
//        notes.setTitle("Notes", for: UIControlState())
//        notes.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
//        notes.addTarget(self, action: #selector(FirstViewController.notesClick(_:)), for: UIControlEvents.touchUpInside)
//        notes.setTitleColor(UIColor.black, for: UIControlState())
//        view.addSubview(notes)
//        
//        let notesImage = UIImageView()
//        notesImage.image = UIImage(named: "notes")
//        notesImage.contentMode = UIViewContentMode.scaleAspectFit
//        notesImage.frame = CGRect(x: (notes.frame.size.width - 65)/2, y: 5,width: 61, height: 61)
//        notes.addSubview(notesImage)
//    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
         var imgheight = CGFloat(0)
        var textTop = CGFloat(0)
        var textLeft = CGFloat(0)
        var textButtom = CGFloat(0)
        var textRight = CGFloat(0)
        var mapheight = CGFloat(0)
        var screen = CGFloat(0)
        
        if  ScreenSize.height == 480
        {
            mapview.frame = CGRect(x: 0,y: 64, width: ScreenSize.width, height: 80)
            mapheight = mapview.frame.height + 64
            screen = ScreenSize.height - (mapheight + 50)
            imgheight = 50
            textTop = 50
            textLeft = 10
            textButtom = 0
            textRight = 10
            
        } else {
            
            mapview.frame = CGRect(x: 0,y: 64, width: ScreenSize.width, height: 120)
            mapheight = mapview.frame.height + 64
            screen = ScreenSize.height - (mapheight + 50)
            imgheight = 61
            textTop = 60
            textLeft = 10
            textButtom = 0
            textRight = 10
        }
        
        let user = SMLAppUser.getUser()
        let upgradeInfo : (NSString) = user.upgrade
        if(upgradeInfo == "1")
        {
            mapheight = mapheight + 50
            var mapFrame : (CGRect) =  mapview.frame
            mapFrame.size.height = mapFrame.size.height  + 50
            mapview.frame = mapFrame
        }
        else
        {
        }
        let buttonHeight = screen / 4
        navigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 44)
        navigationView.backgroundColor = UIColor(red: 0/255.0, green:135/255, blue: 206/255, alpha: 1.0)
        //UIColor(red: 0/255.0, green:135/255, blue: 206/255, alpha: 1.0)
       // self.view.addSubview(navigationView)
        
        let image = UIImage(named: "back_errow")
        backBtn.frame = CGRect(x: 10,y: 20, width: 20, height: 20)
        backBtn.setImage(image, for: UIControlState())
        backBtn.addTarget(self, action: #selector(FirstViewController.SideMenu(_:)), for: UIControlEvents.touchUpInside)
        navigationView.addSubview(backBtn)
        
        editBtn.frame = CGRect(x: navigationView.frame.size.width - 30, y: 20, width: 20, height: 20)
        let image1 = UIImage(named: "edit")
        editBtn.setImage(image1, for: UIControlState())
        navigationView.addSubview(editBtn)
        
        titleLabel.frame=CGRect(x: 30, y: 20, width: navigationView.frame.size.width-50, height: 20)
        titleLabel.text = "What's Here"
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(13)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        navigationView.addSubview(titleLabel)
        self.view.backgroundColor = UIColor.gray
        self.navigationController!.navigationBar.barTintColor  = UIColor(red: 0.0/255.0, green:135/255, blue: 206/255, alpha: 1.0)
        self.navigationController?.navigationBar.backgroundColor = UIColor.clear
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white , NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(15)]
        self.navigationItem.title = "What's Here"
        self.navigationItem.leftBarButtonItem?.image = UIImage(named: "menu")
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        
        let buttonwidthScreen = ScreenSize.width / 2 //Button Width
        //println(buttonwidthScreen)
        //mapview.frame = CGRectMake(0,64, ScreenSize.width, 120)
        view.addSubview(mapview)
        mapview.delegate = self
        self.displayAnnotations()

        
        mettingFinder.frame = CGRect(x: 0, y: mapheight, width: buttonwidthScreen - 2, height: buttonHeight - 2)
        mettingFinder.backgroundColor = UIColor.white
        mettingFinder.titleEdgeInsets =  UIEdgeInsetsMake(textTop, textLeft, textButtom, textRight)
        mettingFinder.addTarget(self, action: #selector(FirstViewController.mettingFinderClick(_:)), for: UIControlEvents.touchUpInside)
        mettingFinder.setTitle("Meeting Finder", for: UIControlState())
        mettingFinder.titleLabel!.font =  SMLGlobal.sharedInstance.fontSize(12)
        view.addSubview(mettingFinder)
        mettingFinder.setTitleColor(UIColor.black, for: UIControlState())
        let meetingImage = UIImageView()
        meetingImage.image = UIImage(named: "meeting_finder")
        meetingImage.frame = CGRect(x: (mettingFinder.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        mettingFinder.addSubview(meetingImage)
        
        
        addMetting.frame = CGRect(x: buttonwidthScreen, y: mapheight, width: buttonwidthScreen , height: buttonHeight - 2)
        addMetting.backgroundColor = UIColor.white
        addMetting.titleEdgeInsets =  UIEdgeInsetsMake(textTop, textLeft, textButtom, textRight)
        addMetting.addTarget(self, action: #selector(FirstViewController.addMettingClick(_:)), for: UIControlEvents.touchUpInside)
        addMetting.setTitle("Add Meetings", for: UIControlState())
        addMetting.titleLabel!.font =  SMLGlobal.sharedInstance.fontSize(12)
        view.addSubview(addMetting)
        addMetting.setTitleColor(UIColor.black, for: UIControlState())
        
        
        addMettingImage.image = UIImage(named: "add_meeting")
        addMettingImage.frame = CGRect(x: (addMetting.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        addMetting.addSubview(addMettingImage)
        
        checkIn.frame = CGRect(x: 0, y: mapheight + mettingFinder.frame.height + 2, width: buttonwidthScreen - 2, height: buttonHeight - 2)
        checkIn.titleEdgeInsets =  UIEdgeInsetsMake(textTop, textLeft, textButtom, textRight)
        checkIn.backgroundColor = UIColor.white
        checkIn.setTitle("Check In", for: UIControlState())
        checkIn.addTarget(self, action: #selector(FirstViewController.checkInClick(_:)), for: UIControlEvents.touchUpInside)
        checkIn.titleLabel!.font =   SMLGlobal.sharedInstance.fontSize(12)
        checkIn.setTitleColor(UIColor.black, for: UIControlState())
        view.addSubview(checkIn)
        
        checkInImage.image = UIImage(named: "checkin")
        checkInImage.frame = CGRect(x: (checkIn.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        checkIn.addSubview(checkInImage)
        
        sobriety.frame = CGRect(x: buttonwidthScreen, y: mapheight + mettingFinder.frame.height + 2, width: buttonwidthScreen , height: buttonHeight - 2)
        sobriety.titleEdgeInsets =  UIEdgeInsetsMake(textTop, textLeft, textButtom, textRight)
        sobriety.backgroundColor = UIColor.white
        sobriety.setTitle("Sobriety Calculator", for: UIControlState())
        sobriety.titleLabel!.font =   SMLGlobal.sharedInstance.fontSize(12)
        sobriety.addTarget(self, action: #selector(FirstViewController.sobrietyClick(_:)), for: UIControlEvents.touchUpInside)
        sobriety.setTitleColor(UIColor.black, for: UIControlState())
        view.addSubview(sobriety)
        
        sobrietyImage.image = UIImage(named: "soberty_calculator")
        sobrietyImage.frame = CGRect(x: (sobriety.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        sobriety.addSubview(sobrietyImage)

        let callSponsorHeight = mapheight + (mettingFinder.frame.height * 2) + 4
        callSponsor.frame = CGRect(x: 0, y: callSponsorHeight , width: buttonwidthScreen - 2, height: buttonHeight - 2)
        callSponsor.backgroundColor = UIColor.white
        callSponsor.titleEdgeInsets =  UIEdgeInsetsMake(textTop, textLeft, textButtom, textRight)
        // callSponsor.setImage(callSponsorImage, forState: .Normal)
        callSponsor.setTitle("Call Sponsor", for: UIControlState())
        callSponsor.addTarget(self, action: #selector(FirstViewController.callSponsorClick(_:)), for: UIControlEvents.touchUpInside)
        callSponsor.titleLabel!.font =   SMLGlobal.sharedInstance.fontSize(12)
        callSponsor.setTitleColor(UIColor.black, for: UIControlState())
        view.addSubview(callSponsor)
        
        callSponsorImage.image = UIImage(named: "call_sponser")
        callSponsorImage.frame = CGRect(x: (callSponsor.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        callSponsor.addSubview(callSponsorImage)
        
        let motivationalWallHeight = mapheight + (mettingFinder.frame.height * 3) + 6
        motivationalWall.frame = CGRect(x: buttonwidthScreen, y: callSponsorHeight, width: buttonwidthScreen, height: buttonHeight - 2)
        motivationalWall.backgroundColor = UIColor.white
        motivationalWall.titleEdgeInsets =  UIEdgeInsetsMake(textTop, textLeft, textButtom, textRight)
        //        motivationalWall.setImage(motivationalImage, forState: .Normal)
        motivationalWall.setTitle("Motivation Wall", for: UIControlState())
        motivationalWall.addTarget(self, action: #selector(FirstViewController.motivationalWallClick(_:)), for: UIControlEvents.touchUpInside)
        motivationalWall.titleLabel!.font =   SMLGlobal.sharedInstance.fontSize(12)
        motivationalWall.setTitleColor(UIColor.black, for: UIControlState())
        view.addSubview(motivationalWall)
        
        motivationalWallImage.image = UIImage(named: "motivationalwall")
        motivationalWallImage.frame = CGRect(x: (motivationalWall.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        motivationalWall.addSubview(motivationalWallImage)
        
        notes1.frame = CGRect(x: 0, y: motivationalWallHeight, width: buttonwidthScreen - 2 , height: buttonHeight - 2)
        notes1.backgroundColor = UIColor.white
        notes1.titleEdgeInsets =  UIEdgeInsetsMake(textTop, textLeft, textButtom, textRight)
        // notes.setImage(notesImage, forState: .Normal)
        notes1.setTitle("Notes", for: UIControlState())
        notes1.titleLabel!.font =   SMLGlobal.sharedInstance.fontSize(12)
        notes1.addTarget(self, action: #selector(FirstViewController.notesClick(_:)), for: UIControlEvents.touchUpInside)
        notes1.setTitleColor(UIColor.black, for: UIControlState())
        view.addSubview(notes1)
        
        notesImage.image = UIImage(named: "notes")
        notesImage.contentMode = UIViewContentMode.scaleAspectFit
        notesImage.frame = CGRect(x: (notes1.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        notes1.addSubview(notesImage)
        
        attendedMeeting = UIButton()
        attendedMeeting.frame = CGRect(x: buttonwidthScreen, y: motivationalWallHeight, width: buttonwidthScreen , height: buttonHeight - 2)
        attendedMeeting.backgroundColor = UIColor.white
        attendedMeeting.titleEdgeInsets =  UIEdgeInsetsMake(textTop, textLeft, textButtom, textRight)
        attendedMeeting.setTitle("Attended Meetings", for: .normal)
        attendedMeeting.titleLabel!.font =   SMLGlobal.sharedInstance.fontSize(12)
        attendedMeeting.setTitleColor(UIColor.black, for: UIControlState.normal)
        view.addSubview(attendedMeeting)
        
        
        meetingAttend.image = UIImage(named: "contact")
        meetingAttend.contentMode = UIViewContentMode.scaleAspectFit
        meetingAttend.frame = CGRect(x: (attendedMeeting.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        attendedMeeting.addSubview(meetingAttend)
        
        attendMeetingCount = UILabel()
        attendMeetingCount.frame = CGRect(x: (attendedMeeting.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        attendMeetingCount.layer.cornerRadius = attendMeetingCount.frame.size.width/2;
        attendMeetingCount.clipsToBounds = true
        attendMeetingCount.textAlignment = NSTextAlignment.center
        attendMeetingCount.font = SMLGlobal.sharedInstance.fontSize(14)
        attendMeetingCount.textColor = UIColor.white
        attendMeetingCount.backgroundColor = UIColor.clear
        attendedMeeting.addSubview(attendMeetingCount)

        let notesPosition = notes1.frame.origin.y + notes1.frame.size.height

       
        adMobView.frame = CGRect(x: 0, y: notes1.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - notesPosition)
        // println(notes.frame.origin.y)
        //adMobView.backgroundColor = UIColor.redColor()
        if(upgradeInfo == "1")
        {
            adMobView.removeFromSuperview()
            adMobView.delegate = nil
        }
        else
        {
           view.addSubview(adMobView)
        }
        adMobView.delegate = self
        adMobView.adUnitID =  "ca-app-pub-1324313420606812/7520347287"
        adMobView.rootViewController = self
        let request: GADRequest = GADRequest()
        //request.testDevices = [ kGADSimulatorID ]
        adMobView.load(request)
        // Do any additional setup after loading the view, typically from a nib.
        
        self.getAttendedMeetings()
    }
    func frameReset()
    {
            var imgheight = CGFloat(0)
            var textTop = CGFloat(0)
            var textLeft = CGFloat(0)
            var textButtom = CGFloat(0)
            var textRight = CGFloat(0)
            var mapheight = CGFloat(0)
            var screen = CGFloat(0)
            
            if  ScreenSize.height == 480
            {
                mapview.frame = CGRect(x: 0,y: 64, width: ScreenSize.width, height: 80)
                mapheight = mapview.frame.height + 64
                screen = ScreenSize.height - (mapheight + 50)
                imgheight = 50
                textTop = 50
                textLeft = 10
                textButtom = 0
                textRight = 10
                
            } else {
                
                mapview.frame = CGRect(x: 0,y: 64, width: ScreenSize.width, height: 120)
                mapheight = mapview.frame.height + 64
                screen = ScreenSize.height - (mapheight + 50)
                imgheight = 61
                textTop = 60
                textLeft = 10
                textButtom = 0
                textRight = 10
            }
            
            let user = SMLAppUser.getUser()
            let upgradeInfo : (NSString) = user.upgrade
            if(upgradeInfo == "1")
            {
                mapheight = mapheight + 50
                var mapFrame : (CGRect) =  mapview.frame
                mapFrame.size.height = mapFrame.size.height  + 50
                mapview.frame = mapFrame
            }
            else
            {
            }
            let buttonHeight = screen / 4

            
        
            backBtn.frame = CGRect(x: 10,y: 20, width: 20, height: 20)

            
        
            editBtn.frame = CGRect(x: navigationView.frame.size.width - 30, y: 20, width: 20, height: 20)

            
        
            titleLabel.frame=CGRect(x: 30, y: 20, width: navigationView.frame.size.width-50, height: 20)

            let buttonwidthScreen = ScreenSize.width / 2

            self.displayAnnotations()
            
            mettingFinder.frame = CGRect(x: 0, y: mapheight, width: buttonwidthScreen - 2, height: buttonHeight - 2)

            
            addMetting.frame = CGRect(x: buttonwidthScreen, y: mapheight, width: buttonwidthScreen , height: buttonHeight - 2)
 
            
            addMettingImage.frame = CGRect(x: (addMetting.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        
            checkIn.frame = CGRect(x: 0, y: mapheight + mettingFinder.frame.height + 2, width: buttonwidthScreen - 2, height: buttonHeight - 2)

            
            checkInImage.frame = CGRect(x: (checkIn.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
            sobriety.frame = CGRect(x: buttonwidthScreen, y: mapheight + mettingFinder.frame.height + 2, width: buttonwidthScreen , height: buttonHeight - 2)
 
            sobrietyImage.frame = CGRect(x: (sobriety.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
        
            let callSponsorHeight = mapheight + (mettingFinder.frame.height * 2) + 4
            callSponsor.frame = CGRect(x: 0, y: callSponsorHeight , width: buttonwidthScreen - 2, height: buttonHeight - 2)
        
            callSponsorImage.frame = CGRect(x: (callSponsor.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
            let motivationalWallHeight = mapheight + (mettingFinder.frame.height * 3) + 6
            motivationalWall.frame = CGRect(x: buttonwidthScreen, y: callSponsorHeight, width: buttonwidthScreen, height: buttonHeight - 2)

            
            motivationalWallImage.frame = CGRect(x: (motivationalWall.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
            notes1.frame = CGRect(x: 0, y: motivationalWallHeight, width: buttonwidthScreen - 2 , height: buttonHeight - 2)
            notesImage.frame = CGRect(x: (notes1.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
            attendedMeeting.frame = CGRect(x: buttonwidthScreen, y: motivationalWallHeight, width: buttonwidthScreen , height: buttonHeight - 2)
            meetingAttend.frame = CGRect(x: (attendedMeeting.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)
            attendMeetingCount.frame = CGRect(x: (attendedMeeting.frame.size.width - imgheight)/2, y: 5,width: imgheight, height: imgheight)

            
  
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
        let user : (SMLAppUser) = SMLAppUser.getUser()
        print(user.userId)
        let upgrade : (NSString) = user.upgrade
        if(upgrade == "1")
        {
             adMobView.removeFromSuperview()
             adMobView.delegate = nil
            self.frameReset()
         //   adMobView.frame = CGRect(x: 0, y: notes.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - notesPosition)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func SideMenu(_ sender : UIButton)
    {
        let sidePanel : JASidePanelController = JASidePanelController()
        sidePanel.shouldDelegateAutorotateToVisiblePanel = false;
        // self.navigationController?.pushViewController(sidePanel, animated: true)
        sidePanel.leftPanel = SideMenuViewController()
    }
    
    func mettingFinderClick(_ sender:UIButton)
    {
        let findMeeting : meetingFinderViewController = meetingFinderViewController(nibName: nil, bundle: nil)
        findMeeting.classAction = 2
        self.navigationController?.pushViewController(findMeeting, animated: false)
    }
    
    func addMettingClick(_ sender :UIButton)
    {
      //  let addMeeting : AddMeetingViewController = AddMeetingViewController(nibName: nil, bundle: nil)
      //  self.navigationController?.pushViewController(addMeeting, animated: false)
        
        
        let homeView: HomeViewController = HomeViewController()
        self.navigationController?.pushViewController(homeView, animated: false)
    }
    
    func notesClick(_ sender:UIButton)
    {
        let notesView : notes = notes(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(notesView, animated: false)
    }
    func motivationalWallClick(_ sender:UIButton)
    {
        let notesView : motivationalWallViewController = motivationalWallViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(notesView, animated: false)
    }
    func contactsClick(_ sender:UIButton)
    {
        
    }
    func callSponsorClick(_ sender:UIButton)
    {
        let sponsors : callSponsorViewController = callSponsorViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(sponsors, animated: false)
    }
    func sobrietyClick(_ sender:UIButton)
    {
        let sobriety : sobrietyCalculatorViewController = sobrietyCalculatorViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(sobriety, animated: false)
    }
    
    func checkInClick(_ sender : UIButton)
    {
        let meetFinder : meetingFinderViewController = meetingFinderViewController(nibName: nil, bundle: nil)
        meetFinder.classAction  = 1
        self.navigationController?.pushViewController(meetFinder, animated: false)
    }
    

    func displayAnnotations()
    {
        var latStr: (NSString)!
        var longStr : (NSString)!
        let userDefaults : UserDefaults = UserDefaults.standard
            
            if (userDefaults.object(forKey: "Location") != nil)
            {
                let dict : (NSDictionary) = UserDefaults.standard.object(forKey: "Location") as! NSDictionary
                latStr = dict.value(forKey: "latitude") as! String as (NSString)!
                longStr = dict.value(forKey: "longitude") as! String as (NSString)!
                
                let latitude : (CLLocationDegrees) = latStr.doubleValue
                let longitude : (CLLocationDegrees) = longStr.doubleValue
                
                latdelta = 1
                londelta = 1
                // var locValue:CLLocationCoordinate2D = locationManager.location.coordinate
                //println("locations = \(locValue.latitude) \(locValue.longitude)")
                
                let span:MKCoordinateSpan = MKCoordinateSpanMake(latdelta, londelta)
                let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude )
                let resion:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
                
                mapview.setRegion(resion, animated: true)
                annotation = MKPointAnnotation()
                annotation.coordinate = location
                latdelta = location.latitude
                londelta = location.longitude
                /* if placemarks.count > 0 {
                let pm = placemarks[0] as! CLPlacemark
                self.displayLocationInfo(pm)
                } else {
                println("Problem with the data received from geocoder")
                }*/
                mapview.addAnnotation(annotation)
            }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //println("Function Called")
        if !(annotation is MKPointAnnotation) {
            return nil
        }
        let reuseId = "test"
        var imgAnnotation = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if imgAnnotation == nil {
            imgAnnotation = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            
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
    
    //MARK: - Webservice Methods
    func getAttendedMeetings()
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsfindSobrietyCount?user_id=12&sob_Date=2015-06-18
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
            SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
            let user : (SMLAppUser) = SMLAppUser.getUser()
            let loginId : (NSString) = user.userId;
            let pickerDate : (Date) = Date()
            let df : (DateFormatter) = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let dateStr : (NSString) = df.string(from: pickerDate) as (NSString)
            //latitude=30.6799&longitude=76.722130.680339, 76.728552
            let parameters : (NSDictionary) = ["user_id" : loginId,
                                               "sob_Date" : dateStr]
            print(parameters)
            WebserviceManager.sharedInstance.findSobrietyCalculator(params: parameters) { (responseObject, error) in
                if responseObject != nil
                {
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    if success == 0
                    {
                        attendMeetingCount.text = "0";
                        SVProgressHUD .dismiss()
                    }
                    else if success == 1
                    {
                        //let meetingsAdded : (NSString) =  (responseObject as! NSDictionary).value(forKey: "meetings_added") as! String as (NSString)
                        let meetingsAttended : (NSString) =  (responseObject as! NSDictionary).value(forKey: "meetings_attended") as! String as (NSString)
                        attendMeetingCount.text = meetingsAttended as String
                        //self.valueaddedMeeting.text = meetingsAdded as String
                        //self.valueAttendedMeeting.text = meetingsAttended as String
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
    
}
