//
//  HomeViewController.swift
//  12 Steps Meeting Locator
//
//  Created by Rajni on 11/16/16.
//  Copyright © 2016 iapp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import AddressBookUI
import Contacts
class HomeViewController: UIViewController,UITextFieldDelegate,UITextViewDelegate,UITableViewDataSource, UITableViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate,UIGestureRecognizerDelegate
{
    var isKeyboardShow : Bool = false
    var latitudeValue : (CLLocationDegrees)!
    var longitudeValue : (CLLocationDegrees)!
    var categoryArray : NSArray!
    var programArray : NSArray!
    var textMName : UITextField!
    var textZip : UITextField!
    var textAddress1 : UITextField!
    var textAddress2 : UITextField!
    var textEmail : UITextField!
    var textCountry : UITextField!
    var textCity : UITextField!
    var textState : UITextField!
    var textTime : UITextField!
    var textdelValue = 0
    var textdelValue1 = 0
    var textdelValue10 = 0
    var textdelValue11 = 1
    var textdelValue2 = 0
    var textdelValue3 = 0
    var textdelValue4 = 0
    var textdelValue5 = 0
    var textdelValue6 = 0
    var textdelValue7 = 0
    var textdescription : UITextField!
    var stateTableView : UITableView! = UITableView()
    var cityTableView : UITableView! = UITableView()
    var countryTableView : UITableView = UITableView()
    var dateTableView : UITableView! = UITableView()
    var dayTableView : UITableView! = UITableView()
    var monthTableView : UITableView! = UITableView()
    var firstBlnkValue = 0
    
    
    var cityArray : NSArray!
    var countryArray : NSArray!
    var stateArray : NSArray!
    
    var dayArray  : NSArray!
    var dateArray : NSArray!
    var monthArray : NSArray!
    
    
    var countryLabel : UILabel!
    var cityLabel : UILabel!
    var StateLabel : UILabel!
    
    
    var dayLabel : UILabel!
    var dateLabel : UILabel!
    var monthLabel : UILabel!
    
    var AABtn : UIButton!
    var NABtn : UIButton!
    var CRBtn : UIButton!
    
    var catBtn : UIButton!
    var catBtn1 : UIButton!
    
    var programView : UIView!
    var categoriesView :UIView!
    
    var timePickerView : UIView!
    var timePicker : UIDatePicker!
    
    
    var programSelectedInt : Int = 0
    var categorySelectedInt : Int = 0
    var daysOfArray : NSMutableArray!
    
    
    
    var backgroundScrollView : UIScrollView!
    
    var dayBtnsView : UIView!
    
    var programScrollView : UIScrollView!
    
    var categoriesScrollView : UIScrollView!
    
    var selectedCategoriesArray : NSMutableArray!
    
    var searchQuery : SPGooglePlacesAutocompleteQuery!
    
    var searchResultPlaces : (NSArray)!
    var searchStr : (NSMutableString)!
    
    var listTableView : UITableView!
    
    var addressLocation : (CLLocation)!
    
    var MeetingDetailsView : (UIView)!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        searchQuery = SPGooglePlacesAutocompleteQuery()
        searchQuery.radius = 100.0;
        searchStr = NSMutableString()
        
        searchResultPlaces = NSMutableArray()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = true
        
        categoryArray = NSMutableArray()
        daysOfArray = NSMutableArray()
        selectedCategoriesArray = NSMutableArray()
        
        self.cityArray = NSArray(objects: "Chandigarh","Delhi","Shimla")
        self.countryArray = NSArray(objects: "Asia","Australia","")
        self.stateArray = NSArray(objects: "J&k" , "Uttranchal")
        
        self.dayArray = NSArray(objects: "Mon","Tues", "Wed","Thu","Fri","Sat","Sun")
        self.monthArray = NSArray(objects: "January","February","March", "April","May","June","July","August","September","October","November","December")
        
        self.dateArray = NSArray(objects: "1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31")
        
        
        //var arr: Array  = Array("1")
        
        //        countryTableView = UITableView()
        //        cityTableView = UITableView()
        //        stateTableView = UITableView()
        //        dayTableView = UITableView()
        //        dateTableView = UITableView()
        //        monthTableView = UITableView()
        
        
        
        //Navigation View
        //self.navigationItem.hidesBackButton = true
        self.navigationController!.navigationBar.barTintColor  = UIColor(red: 0.0/255.0, green:135.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white , NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(13)]
        self.navigationItem.title = "Create New Location Profile"
        
        let backImage =  UIImage(named: "home")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(HomeViewController.backBtnAction(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.view.backgroundColor = UIColor(red: 239.0/255.0, green: 253.0/255.0, blue: 254.0/255.0, alpha: 1.0)
        self.getAllCategories()
        // Do any additional setup after loading the view.
        
        
    }
    func bgScrollViewGesture()
    {
        self.resignAllTableViews()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool
    {
        if (touch.view?.isDescendant(of: listTableView))!
        {
            return false
        }
        return true
    }
    override func viewWillAppear(_ animated: Bool)
    {
        //self.navigationController?.navigationBarHidden = false
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.KeyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.KeyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    func KeyboardWillShow(_ note : Notification)
    {
        timePickerView.removeFromSuperview()
        if  !isKeyboardShow
        {
            isKeyboardShow = true
            backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width , height: backgroundScrollView.contentSize.height + 200)
        }
        
    }
    func KeyboardWillHide(_ note : Notification)
    {
        if isKeyboardShow
        {
            isKeyboardShow = false
            backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width , height: backgroundScrollView.contentSize.height - 200)
        }
    }
    override func viewWillDisappear(_ animated: Bool)
    {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    //MARK:- Create UI
    func createUI()
    {
    //        searchQuery =  SPGooglePlacesAutocompleteQuery()
    //        searchQuery.radius = 100.0
    //
    //        searchQuery.fetchPlaces { (, <#NSError!#>) -> Void in
    //            <#code#>
    //        }
    //ScrollView
    backgroundScrollView = UIScrollView()
    backgroundScrollView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
    backgroundScrollView.bounces = false
    self.view.addSubview(backgroundScrollView)
    let textColor = UIColor.black.withAlphaComponent(0.8)
    let headingFont : (UIFont) = SMLGlobal.sharedInstance.fontSize(14)
        
    //Program
    let programLabel = UILabel()
    programLabel.frame = CGRect(x: 10, y: 74, width: 100, height: 20);
    // programLabel.frame = CGRectMake(10, 64, 100, 40);
    programLabel.text = "Program"
    
    programLabel.font = headingFont
    programLabel.textColor = textColor
    backgroundScrollView.addSubview(programLabel);
    
    //Program Buttons
    var p : Int! = 0
    var q : Int! = 0
    var isSize : Bool!
     print(programArray.count)
    if(programArray.count > 3)
    {
    if(programArray.count%3==0)
    {
    p = programArray.count/3
    q=3
    isSize = false
    }
    else
    {
    p = programArray.count/3+1
    q = programArray.count%3
    isSize = true
    }
    }
    else
    {
    p = 1
    q = programArray.count
    }
    
    programScrollView = UIScrollView()
    programScrollView.isScrollEnabled = true
    programScrollView.frame = CGRect(x: 10, y: programLabel.frame.maxY+10, width: ScreenSize.width - 20, height: 200);
    programScrollView.backgroundColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1.0)
    backgroundScrollView.addSubview(programScrollView)
    
    
    programView = UIView()
    programView.frame = CGRect(x: 0, y: 0, width: programScrollView.frame.size.width,  height: programScrollView.frame.size.height);
    programView.backgroundColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1.0)
    //programScrollView.addSubview(programView)
    
    
    var pFrame : (CGRect) = CGRect(x: 0, y: 0, width: 50, height: 30)
    var cnt :Int! = 0
    var programBtns = UIButton()
    for i in 0 ..< p
    {
    
    if(isSize == true)
    {
    if(i == p-1)
    {
    q = programArray.count%3
    }
    else
    {
    q = 3
    }
    
    }
    for j in 0 ..< q
    {
    programBtns = UIButton.init(type: UIButtonType.custom)
    programBtns.frame = pFrame
    programBtns.addTarget(self, action: #selector(HomeViewController.CategoryAction1(_:)), for: UIControlEvents.touchUpInside)
    programBtns .setImage(UIImage(named: "uncheck"), for: UIControlState())
    programBtns.addTarget(self, action: #selector(HomeViewController.programSelectionAction(_:)), for: UIControlEvents.touchUpInside)
    programBtns.tag = cnt
    programScrollView.addSubview(programBtns);
    
    let programLabel = UILabel()
    let programName : (NSString) = (programArray.object(at: cnt) as! NSDictionary).value(forKey: "program_name") as! String as (NSString)
    programLabel.text = programName as String
    programLabel.textColor = textColor
    programLabel.font = SMLGlobal.sharedInstance.fontSize(12)
    
    
    if ScreenSize.height == 667
    {
    pFrame.origin.x = pFrame.origin.x+pFrame.size.width+60
    programLabel.frame = CGRect(x: 40,y: 5, width: 90, height: 20)
    } else if ScreenSize.height == 480 {
    pFrame.origin.x = pFrame.origin.x+pFrame.size.width+30
    programLabel.frame = CGRect(x: 40,y: 5, width: 50, height: 20)
    } else {
    pFrame.origin.x = pFrame.origin.x+pFrame.size.width+40
    programLabel.frame = CGRect(x: 40,y: 5, width: 70, height: 20)
    }
    programBtns.addSubview(programLabel)
    cnt  = cnt + 1
    
    }
    pFrame.origin.y = pFrame.origin.y+pFrame.size.height+5
    pFrame.origin.x = 0
    programScrollView.contentSize = CGSize(width: programScrollView.frame.size.width,  height: pFrame.origin.y+10)
    // programView.frame = CGRectMake(0,0, programScrollView.frame.width, pFrame.origin.y+10)
    }
    
    
    
    let PF : CGFloat = programBtns.frame.maxY
    var PSF : (CGRect) = programScrollView.frame
    var PV : (CGRect) = programView.frame
    if(PF>200)
    {
    PSF.size.height = 200
    PV.size.height = 200
    programScrollView.frame = PSF
    //programView.frame = PV
    //programScrollView.frame = CGRectMake(0, CGRectGetMaxY(programLabel.frame)+10, ScreenSize.width, 200);
    
    }
    else
    {
    PSF.size.height = PF
    PV.size.height = PF
    programScrollView.frame = PSF
    // programView.frame = PV
    }
    //Categories
    let categoriesLabel = UILabel()
    categoriesLabel.frame = CGRect(x: 10, y: programScrollView.frame.maxY+10, width: 100, height: 20);
    //categoriesLabel.frame = CGRectMake(10, CGRectGetMaxY(programScrollView.frame)+10, 100, 40);
    categoriesLabel.text = "Categories"
    categoriesLabel.textColor = textColor
    categoriesLabel.font = headingFont
    categoriesLabel.backgroundColor = UIColor.clear
    backgroundScrollView.addSubview(categoriesLabel)
    
    var cat : Int! = 0
    var qat : Int! = 0
    var isSizeCat : Bool!
    if(self.categoryArray.count%2==0)
    {
    cat = self.categoryArray.count/2
    qat = 2
    isSizeCat = false
    }
    else
    {
    cat = self.categoryArray.count/2+1
    qat = 1
    isSizeCat = true
    }

    categoriesScrollView = UIScrollView()
    categoriesScrollView.isScrollEnabled = true
    categoriesScrollView.frame = CGRect(x: 10, y: categoriesLabel.frame.maxY+10, width: ScreenSize.width - 20, height: 200);
    categoriesScrollView.backgroundColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1.0)
    backgroundScrollView.addSubview(categoriesScrollView)

    //CategoriesBtn
    categoriesView = UIView()
    categoriesView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 200);
    categoriesView.backgroundColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1.0)
    // categoriesScrollView.addSubview(categoriesView)
    
    var catFrame : (CGRect) = CGRect(x: 0, y: 0, width: 50, height: 30)
    var catCount :Int! = 0
    var categoryBtn = UIButton()
    for iCat in 0 ..< cat
    {
    if(isSizeCat == true)
    {
    if(iCat == cat-1)
    {
    qat = 1
    }
    else
    {
    qat = 2
    }
    
    }
    
    for jCat in 0 ..< qat
    {
    categoryBtn = UIButton.init(type: UIButtonType.custom)
    categoryBtn.frame = catFrame
    
    categoryBtn.addTarget(self, action: #selector(HomeViewController.CategoryAction1(_:)), for: UIControlEvents.touchUpInside)
    categoryBtn .setImage(UIImage(named: "uncheck"), for: UIControlState())
    categoryBtn.addTarget(self, action: #selector(HomeViewController.catSelectionAction(_:)), for: UIControlEvents.touchUpInside)
    categoryBtn.tag = catCount
    categoriesScrollView.addSubview(categoryBtn);
    
    let catLabel = UILabel()
    catLabel.frame = CGRect(x: 40,y: 5, width: 100, height: 20)
    let catName : (NSString) = (self.categoryArray.object(at: catCount) as! NSDictionary).value(forKey: "cat_name") as! String as (NSString)
    catLabel.text = catName as String
    catLabel.textColor = textColor
    catLabel.font = SMLGlobal.sharedInstance.fontSize(12)
    categoryBtn.addSubview(catLabel)
    
    catFrame.origin.x = catFrame.origin.x+catFrame.size.width+100
    
    if ScreenSize.height >= 667 {
    catFrame.origin.x = ScreenSize.width - (catFrame.origin.x+catFrame.size.width)
    catLabel.frame = CGRect(x: 40,y: 5, width: 140, height: 20)
    }
    catCount  = catCount + 1
    }
    catFrame.origin.y = catFrame.origin.y+catFrame.size.height+5
    catFrame.origin.x = 0
    categoriesScrollView.contentSize = CGSize(width: categoriesScrollView.frame.size.width,  height: catFrame.origin.y+10)
    // categoriesView.frame = CGRectMake(0,0, categoriesScrollView.frame.width, catFrame.origin.y+10)
    }
    
    let CF : CGFloat = categoryBtn.frame.maxY
    var CSV : (CGRect) = categoriesScrollView.frame
    var CV : (CGRect) = categoriesView.frame
    if(CF>200)
    {
    CSV.size.height = 200
    CV.size.height = 200
    categoriesScrollView.frame = CSV
    categoriesView.frame = CV
    //programScrollView.frame = CGRectMake(0, CGRectGetMaxY(programLabel.frame)+10, ScreenSize.width, 200);
    }
    else
    {
    CSV.size.height = CF
    CV.size.height = CF
    categoriesScrollView.frame = CSV
    categoriesView.frame = CV
    }
    
    //MeetingDetails
    let meetingLabel = UILabel()
    meetingLabel.frame = CGRect(x: 10, y: categoriesScrollView.frame.maxY+10, width: 150, height: 20)
    //  meetingLabel.frame = CGRectMake(10, CGRectGetMaxY(categoriesScrollView.frame)+10, ScreenSize.width, 40)
    meetingLabel.text = "Meeting Details"
    meetingLabel.font = headingFont
    meetingLabel.textColor = textColor
    backgroundScrollView.addSubview(meetingLabel);
    
    MeetingDetailsView = UIView()
    MeetingDetailsView.frame = CGRect(x: 0, y: meetingLabel.frame.maxY + 10, width: ScreenSize.width, height: ScreenSize.height - (meetingLabel.frame.maxY-10) );
    
    if(ScreenSize.height == 667)
    {
    MeetingDetailsView.frame = CGRect(x: 0, y: meetingLabel.frame.maxY + 10, width: ScreenSize.width, height: ScreenSize.height - 190);
    }
    else if ScreenSize.height == 480
    {
    MeetingDetailsView.frame = CGRect(x: 0, y: meetingLabel.frame.maxY + 10, width: ScreenSize.width, height: ScreenSize.height);
    }
    else
    {
    MeetingDetailsView.frame = CGRect(x: 0, y: meetingLabel.frame.maxY + 10, width: ScreenSize.width, height: ScreenSize.height - 100);
    }
    
    MeetingDetailsView.backgroundColor = UIColor(red: 225, green: 225, blue: 225, alpha: 1.0)
    backgroundScrollView.addSubview(MeetingDetailsView)
    
    let  textField_X :(CGFloat) = 10;
    let  textField_Width :(CGFloat) = ScreenSize.width - 20;
    let  txtFont:UIFont = SMLGlobal.sharedInstance.fontSize(12)
    
    //Meeting Name
    self.textMName = UITextField()
    self.textMName.frame = CGRect(x: textField_X ,y: 5, width: textField_Width  , height: 30)
    self.textMName.tag = 1
    let FirstPlaceholder = NSAttributedString(string: "Meeting Name", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
    self.textMName.font = txtFont
    self.textMName.attributedPlaceholder = FirstPlaceholder;
    self.textMName.backgroundColor = UIColor.white
    self.textMName.delegate = self
    self.textMName.textColor = UIColor.black
    self.textMName.borderStyle = UITextBorderStyle.roundedRect;
    self.textMName.autocorrectionType = UITextAutocorrectionType.no
    self.textMName.returnKeyType=UIReturnKeyType.next
    self.textMName.leftViewMode = UITextFieldViewMode.always
    MeetingDetailsView.addSubview(self.textMName)
    
    self.textAddress1 = UITextField()
    self.textAddress1.frame = CGRect(x: textField_X , y: textMName.frame.maxY + 10, width: textField_Width, height: 30)
    self.textAddress1.tag = 2
    let FirstPlaceholder9 = NSAttributedString(string: "Address1", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
    self.textAddress1.font = txtFont
    self.textAddress1.textColor = UIColor.black
    self.textAddress1.attributedPlaceholder = FirstPlaceholder9;
    self.textAddress1.backgroundColor = UIColor.white
    self.textAddress1.delegate = self
    self.textAddress1.borderStyle = UITextBorderStyle.roundedRect;
    self.textAddress1.autocorrectionType = UITextAutocorrectionType.no
    self.textAddress1.returnKeyType=UIReturnKeyType.next
    self.textAddress1.leftViewMode = UITextFieldViewMode.always
    MeetingDetailsView.addSubview(self.textAddress1)
    
    self.textAddress2 = UITextField()
    self.textAddress2.frame = CGRect(x: textField_X , y: textAddress1.frame.maxY + 10, width: textField_Width, height: 30)
    self.textAddress2.tag = 3
    let FirstPlaceholder10 = NSAttributedString(string: "Address2", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
    self.textAddress2.font = txtFont
    self.textAddress2.textColor = UIColor.black
    self.textAddress2.attributedPlaceholder = FirstPlaceholder10;
    self.textAddress2.backgroundColor = UIColor.white
    self.textAddress2.delegate = self
    self.textAddress2.borderStyle = UITextBorderStyle.roundedRect;
    self.textAddress2.autocorrectionType = UITextAutocorrectionType.no
    self.textAddress2.returnKeyType=UIReturnKeyType.next
    self.textAddress2.leftViewMode = UITextFieldViewMode.always
    MeetingDetailsView.addSubview(self.textAddress2)
    
    let  calenderTextWidth  : (CGFloat)  =  (ScreenSize.width - 30)/2.0
    //Country
    self.textCountry = UITextField()
    self.textCountry.frame = CGRect(x: 10, y: self.textAddress2.frame.maxY + 10 , width: calenderTextWidth, height: 30)
    self.textCountry.tag = 4
    let FirstPlaceholder1 = NSAttributedString(string: "Country", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
    self.textCountry.font = txtFont
    self.textCountry.attributedPlaceholder = FirstPlaceholder1;
    self.textCountry.backgroundColor = UIColor.white
    self.textCountry.delegate = self
    self.textCountry.textColor = UIColor.black
    self.textCountry.borderStyle = UITextBorderStyle.roundedRect;
    self.textCountry.autocorrectionType = UITextAutocorrectionType.no
    self.textCountry.returnKeyType=UIReturnKeyType.next
    self.textCountry.leftViewMode = UITextFieldViewMode.always
    MeetingDetailsView.addSubview(self.textCountry)
    
    //State
    self.textState = UITextField()
    self.textState.frame = CGRect(x: textCountry.frame.maxX+10, y: self.textAddress2.frame.maxY + 10  , width: calenderTextWidth, height: 30)
    self.textState.tag = 4
    let FirstPlaceholder2 = NSAttributedString(string: "State", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
    self.textState.font = txtFont
    self.textState.attributedPlaceholder = FirstPlaceholder2;
    self.textState.backgroundColor = UIColor.white
    self.textState.delegate = self
    self.textState.textColor = UIColor.black
    self.textState.borderStyle = UITextBorderStyle.roundedRect;
    self.textState.autocorrectionType = UITextAutocorrectionType.no
    self.textState.returnKeyType=UIReturnKeyType.next
    self.textState.leftViewMode = UITextFieldViewMode.always
    MeetingDetailsView.addSubview(self.textState)
    
    self.textZip = UITextField()
    self.textZip.frame = CGRect(x: 10,y: textCountry.frame.maxY+10, width: calenderTextWidth, height: 30)
    self.textZip.tag = 5
    let FirstPlaceholder4 = NSAttributedString(string: "ZipCode", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
    self.textZip.font = txtFont
    self.textZip.attributedPlaceholder = FirstPlaceholder4;
    self.textZip.backgroundColor = UIColor.white
    self.textZip.delegate = self
    self.textZip.textColor = UIColor.black
    self.textZip.borderStyle = UITextBorderStyle.roundedRect;
    self.textZip.autocorrectionType = UITextAutocorrectionType.no
    self.textZip.returnKeyType=UIReturnKeyType.next
    self.textZip.leftViewMode = UITextFieldViewMode.always
    MeetingDetailsView.addSubview(self.textZip)
    
    //State
    self.textCity = UITextField()
    self.textCity.frame = CGRect(x: textZip.frame.maxX+10,y: textCountry.frame.maxY+10, width: calenderTextWidth, height: 30)
    self.textCity.tag = 5
    let FirstPlaceholder5 = NSAttributedString(string: "City", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
    self.textCity.font = txtFont
    self.textCity.attributedPlaceholder = FirstPlaceholder5;
    self.textCity.backgroundColor = UIColor.white
    self.textCity.delegate = self
    self.textCity.textColor = UIColor.black
    self.textCity.borderStyle = UITextBorderStyle.roundedRect;
    self.textCity.autocorrectionType = UITextAutocorrectionType.no
    self.textCity.returnKeyType=UIReturnKeyType.next
    self.textCity.leftViewMode = UITextFieldViewMode.always
    MeetingDetailsView.addSubview(self.textCity)
    
    let dayLabelss = UILabel()
    dayLabelss.frame = CGRect(x: 10, y: textCity.frame.maxY+10 , width: ScreenSize.width, height: 30)
    dayLabelss.text = "Days of the week meetings are held"
    dayLabelss.isUserInteractionEnabled = true
    dayLabelss.font = SMLGlobal.sharedInstance.fontSize(13)
    dayLabelss.textColor = UIColor.gray
    MeetingDetailsView.addSubview(dayLabelss);
    
    dayBtnsView = UIView ()
    dayBtnsView.frame = CGRect(x: 0, y: dayLabelss.frame.maxY + 5, width: MeetingDetailsView.frame.size.width - 20, height: 40)
    dayBtnsView.backgroundColor = UIColor.clear
    MeetingDetailsView.addSubview(dayBtnsView)
    
    var btnFrame : (CGRect) = CGRect(x: 0, y: 0,width: 40, height: 30)
    var count :Int! = 0
    var dayBtn = UIButton()
    for i in 0 ..< 7
    {
    dayBtn = UIButton.init(type: UIButtonType.custom)
    dayBtn.frame = btnFrame
    
    dayBtn.addTarget(self, action: #selector(HomeViewController.CategoryAction1(_:)), for: UIControlEvents.touchUpInside)
    dayBtn .setImage(UIImage(named: "uncheck"), for: UIControlState())
    //dayBtn .setImage(UIImage(named: "uncheck"), forState: UIControlState.Normal)
    dayBtn.addTarget(self, action: #selector(HomeViewController.DaySelectionAction(_:)), for: UIControlEvents.touchUpInside)
    //dayBtn.setTitle("Sun", forState: UIControlState.Normal)
    
    dayBtnsView.addSubview(dayBtn);
    
    let catBtnLabel2 = UILabel()
    catBtnLabel2.frame = CGRect(x: 30,y: 5,width: 30,height: 20)
    catBtnLabel2.text = dayArray.object(at: count) as? String
    dayBtn.tag = count+1
    catBtnLabel2.textColor = textColor
    catBtnLabel2.font = SMLGlobal.sharedInstance.fontSize(12)
    dayBtn.addSubview(catBtnLabel2)
    if(i==3)
    {
    btnFrame.origin.x = btnFrame.origin.x+btnFrame.size.width
    } else if(i==4)
    {
    btnFrame.origin.x = btnFrame.origin.x+btnFrame.size.width - 7
    }else if (i==5 ) {
    btnFrame.origin.x = btnFrame.origin.x+btnFrame.size.width - 5
    }
    else if (i==6 ) {
    btnFrame.origin.x = btnFrame.origin.x+btnFrame.size.width - 5
    }
    else
    {
    btnFrame.origin.x = btnFrame.origin.x+btnFrame.size.width + 3
    }
    count  = count + 1
    }
    
    
    //Zip Address
    self.textdescription = UITextField()
    self.textdescription.frame = CGRect(x: textField_X , y: dayBtnsView.frame.maxY + 10 ,width: ScreenSize.width-20 , height: 30)
    // self.textdescription.text = "Description"
    self.textdescription.tag = 9
    self.textdescription.font = txtFont
    self.textdescription.textColor = UIColor.black
    //self.textdescription.tag = 2
    let FirstPlaceholder8 = NSAttributedString(string: "Description", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
    self.textdescription.attributedPlaceholder = FirstPlaceholder8;
    self.textdescription.backgroundColor = UIColor.white
    self.textdescription.delegate = self
    self.textdescription.borderStyle = UITextBorderStyle.roundedRect;
    self.textdescription.autocorrectionType = UITextAutocorrectionType.no
    self.textdescription.returnKeyType=UIReturnKeyType.next
    // self.textdescription.layer.borderColor = UIColor.lightGrayColor().CGColor
    // self.textdescription.layer.borderWidth = 1.0
    // self.textdescription.layer.cornerRadius = 4.0
    // self.textdescription.leftViewMode = UITextFieldViewMode.Always
    MeetingDetailsView.addSubview(self.textdescription)
    
    
    let timeLabel = UILabel()
    timeLabel.frame = CGRect(x: 10,y: self.textdescription.frame.maxY + 10, width: ScreenSize.width, height: 30)
    timeLabel.text = "Time Meetings are held"
    timeLabel.font = SMLGlobal.sharedInstance.fontSize(13)
    timeLabel.textColor = UIColor.gray
    MeetingDetailsView.addSubview(timeLabel);
    
    self.textTime = UITextField()
    self.textTime.frame = CGRect(x: textField_X, y: timeLabel.frame.maxY + 10 , width: ScreenSize.width - 20, height: 30)
    // self.textdescription.text = "Description"
    self.textTime.tag = 10
    //self.textTime.enabled = true
    //self.textTime.userInteractionEnabled = true
    self.textTime.font = txtFont
    self.textTime.textColor = UIColor.black
    //self.textdescription.tag = 2
    let FirstPlaceholder6 = NSAttributedString(string: "Time", attributes: [NSForegroundColorAttributeName : TextPlaceHolderColor, NSFontAttributeName : txtFont])
    self.textTime.attributedPlaceholder = FirstPlaceholder6;
    self.textTime.backgroundColor = UIColor.white
    self.textTime.delegate = self
    self.textTime.borderStyle = UITextBorderStyle.roundedRect;
    self.textTime.autocorrectionType = UITextAutocorrectionType.no
    self.textTime.returnKeyType=UIReturnKeyType.done
    MeetingDetailsView.addSubview(self.textTime)
    let dayGesture = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.dayGestureAction(_:)))
    textTime.addGestureRecognizer(dayGesture)
    //
    //        //day
    //        dayLabel = UILabel()
    //        dayLabel.frame = CGRectMake(textField_X, CGRectGetMaxY(timeLabel.frame) + 10 , ScreenSize.width - 20, 30)
    //        dayLabel.text = "Time"
    //
    //        dayLabel.userInteractionEnabled = true
    //        dayLabel.font = SMLGlobal.sharedInstance.fontSize(12)
    //        dayLabel.textColor = UIColor.grayColor()
    //        MeetingDetailsView.addSubview(dayLabel);
    
    timePickerView = UIView()
    timePickerView.frame = CGRect(x: 0, y: self.view.frame.size.height - 250, width: ScreenSize.width, height: 250)
    timePickerView.backgroundColor = UIColor.white
    //scrollView.addSubview(datePickerView)
    
    var doneBtn : UIButton!
    doneBtn = UIButton.init(type: UIButtonType.custom)
    doneBtn .setTitleColor(UIColor.black, for: UIControlState())
    
    doneBtn.setTitle("Done", for: UIControlState())
    doneBtn.frame = CGRect(x: 10, y: 5 , width: 50, height: 30)
    doneBtn .addTarget(self, action: #selector(HomeViewController.DoneBtnAction(_:)), for: UIControlEvents.touchUpInside)
    timePickerView.addSubview(doneBtn)
    
    var CancelBtn : UIButton!
    CancelBtn = UIButton.init(type: UIButtonType.custom)
    CancelBtn.setTitle("Cancel", for: UIControlState())
    CancelBtn .setTitleColor(UIColor.black, for: UIControlState())
    CancelBtn.frame = CGRect(x: timePickerView.frame.size.width - 80 ,y: 5, width: 70, height: 30)
    CancelBtn .addTarget(self, action: #selector(HomeViewController.pickerCancelAction(_:)), for: UIControlEvents.touchUpInside)
    timePickerView.addSubview(CancelBtn)
    
    
    timePicker = UIDatePicker()
    timePicker.frame = CGRect(x: 0, y: 50, width: ScreenSize.width, height: 200)
    timePicker.datePickerMode = UIDatePickerMode.time
    timePickerView.addSubview(timePicker)
    
    
    let width : (CGFloat) = (ScreenSize.width-110)/2
    //SubMit Btn
    let submitBtn = UIButton.init(type: UIButtonType.custom)
    submitBtn.frame = CGRect(x: 50, y: textTime.frame.maxY + 20, width: width, height: 35)
    submitBtn.addTarget(self, action: #selector(HomeViewController.SubmitBtnAction(_:)), for: UIControlEvents.touchUpInside)
    submitBtn.backgroundColor = NavigationColor
    submitBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSizeBold(12)
    submitBtn.setTitle("Submit", for: UIControlState())
    submitBtn.setTitleColor(UIColor.white, for: UIControlState())
    submitBtn.layer.cornerRadius = 2.0
    
    //var  submitImage = UIImage(named: "register")
    //submitBtn .setImage(submitImage, forState: UIControlState.Normal)
    
    MeetingDetailsView.addSubview(submitBtn)
    
    //254,74,87
    let cancelBtn = UIButton.init(type: UIButtonType.custom)
    cancelBtn.frame = CGRect(x: submitBtn.frame.maxX + 10, y: textTime.frame.maxY + 20, width: width, height: 35)
    cancelBtn.addTarget(self, action: #selector(HomeViewController.CancelBtnAction(_:)), for: UIControlEvents.touchUpInside)
    cancelBtn.backgroundColor = UIColor(red: 254.0/255.0, green: 74.0/255.0, blue: 87.0/255.0, alpha: 1.0)
    cancelBtn.setTitle("Cancel", for: UIControlState())
    cancelBtn.setTitleColor(UIColor.white, for: UIControlState())
    cancelBtn.layer.cornerRadius = 2.0
    cancelBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSizeBold(12)
    // var  cancelBtnImage = UIImage(named: "cancel_add")
    //cancelBtn .setImage(cancelBtnImage, forState: UIControlState.Normal)
    
    MeetingDetailsView.addSubview(cancelBtn)
    backgroundScrollView.contentSize = CGSize(width: ScreenSize.width, height: MeetingDetailsView.frame.maxY)
    
    listTableView = UITableView()
    listTableView.frame = CGRect(x: textAddress1.frame.origin.x,y: textAddress1.frame.maxY, width: textAddress1.frame.size.width, height: 200)
    listTableView.dataSource = self
    listTableView.delegate = self
    listTableView.layer.borderColor = UIColor.gray.cgColor
    listTableView.layer.borderWidth = 1.0
    listTableView.layer.cornerRadius = 5.0
        
        let gesture = UITapGestureRecognizer.init(target: self, action:#selector(HomeViewController.bgScrollViewGesture))
        gesture.delegate = self
        backgroundScrollView .addGestureRecognizer(gesture)
    
    }

    
    //MARK:- Validation Methods
    func zipValidation(_ text: String)->Bool
    {
        let emailRegEx = "[A-Z]{1,2}[0-9R][0-9A-Z]?([0-9][ABD-HJLNP-UW-Z]{2}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        //println(String(format: "%@", emailTest.evaluateWithObject(text)))
        return emailTest.evaluate(with: text)
    }
    func isValidEmail(_ testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        //println(String(format: "%@", emailTest.evaluateWithObject(testStr)))
        return emailTest.evaluate(with: testStr)
    }
    
    
    func isValidZipCode(_ testStr : String) ->Bool
    {
        let emailRegEx = "(^{5}(-{4})?$)|(^[ABCEGHJKLMNPRSTVXY][A-Z][- ]*[A-Z]$)"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        // println(String(format: "%@", emailTest.evaluateWithObject(testStr)))
        return emailTest.evaluate(with: testStr)
    }
    func CancelBtnAction(_ sender : UIButton)
    {
        self.navigateToBackView()
    }
    
    func checkAllFields() ->Bool
    {
//        var  checkImage = UIImage(named: "check")
//        var  uncheckImage = UIImage(named:"uncheck")
        
        if(programSelectedInt == 0)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Program field is mandatory", title: "")
            return false;
        }
        else if(selectedCategoriesArray.count == 0)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Category field is mandatory", title: "")
            return false;
        }
        else if(self.textMName.text == ""  || firstBlnkValue == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Meeting Name field is mandatory", title: "")
            textMName.text = ""
            return false;
        }
        else if(self.textAddress1.text == "" || textdelValue10 == 1 )
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Address1 field is mandatory", title: "")
            textAddress1.text = ""
            listTableView.removeFromSuperview()
            return false;
        }
        else if textdelValue11 == 1
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please Select Correct Address", title: "")
            textAddress1.text = ""
            listTableView.removeFromSuperview()
            return false;
        }
        else if( textdelValue1 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Address2 field is mandatory", title: "")
            textAddress2.text = ""
            return false;
        }
        else if(self.textCountry.text == "" || textdelValue2 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Country field is mandatory", title: "")
            textCountry.text = ""
            return false;
        }
        else if(self.textState.text == "" || textdelValue3 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "State field is mandatory", title: "")
            textState.text = ""
            return false;
        }
        else if(self.textZip.text == "" || textdelValue4 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Zip field is mandatory", title: "")
            textZip.text = ""
            return false;
        }
        else if(self.textCity.text == "" || textdelValue5 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "City field is mandatory", title: "")
            textCity.text = ""
            return false;
        }
        else if(daysOfArray.count==0)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please select Days", title: "")
            return false;
        }
        else if(self.textdescription.text == "" ||  textdelValue6 == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please enter description", title: "")
            textdescription.text = ""
            return false;
        }
        else if(self.textTime.text == "")
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please Select time", title: "")
            return false;
        }
        else
        {
            return true;
        }
    }
    //MARK:- Text Field Delegate Methods
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        if(textField == textZip)
        {
            let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
            let startIndex = string.startIndex
            let endIndex = string.endIndex
            let range = startIndex..<endIndex
            if string.rangeOfCharacter(from: invalidCharacters, options: String.CompareOptions.caseInsensitive, range: range) != nil
            {
                SMLGlobal.sharedInstance.displayAlertMessage(self, "Please enter valid ZipCode", title: "")
                return false
            }
            else
            {
                
            }
        }
        else if (textField == textAddress1)
        {
            let d: unichar = 32
            let str1 = textAddress1.text! as NSString
            if textField.text == "" {
                
            } else {
                
                let c:unichar = str1.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    textdelValue10 = 1
                    listTableView.removeFromSuperview()
                    
                } else {
                    textdelValue10 = 0
                    
                }
            }
            
            if(!listTableView .isDescendant(of: backgroundScrollView))
            {
                MeetingDetailsView.addSubview(listTableView)
            }
            if(string == "")
            {
                searchStr .deleteCharacters(in: NSMakeRange(searchStr.length - 1, 1))
            }
            else
            {
                searchStr.append(string)
            }
            
            if(searchStr .isEqual(to: ""))
            {
                listTableView.removeFromSuperview()
            }
            if(textAddress1.text == "")
            {
                listTableView.removeFromSuperview()
            }
            self.handleSearch(searchStr)
        }
        return true
    }
    
    //MARK:- Webservice Methods
    func getAllCategories()
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        let parameters : (NSDictionary) = ["firstname" : ""]
        WebserviceManager.sharedInstance.getMeetingCategories(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if success == 0
                {
                    SVProgressHUD.dismiss()
                }
                else if success == 1
                {
                    let dict :(NSDictionary) = responseObject!.value(forKey: "data") as! NSDictionary;
                    print(dict)
                    self.categoryArray = dict.object(forKey: "category") as! NSArray
                    self.programArray = dict.object(forKey: "program") as! NSArray
                    print(self.categoryArray)
                    print(self.programArray)
                    self.createUI()
                    SVProgressHUD.dismiss()
                }
            }
            else
            {
                SVProgressHUD.dismiss()
            }
        }
        }
        else
        {
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }
    
    //MARK: Action Methods
    func DaySelectionAction(_ sender :UIButton)
    {
        let btn = sender as UIButton!
        let Image = UIImage(named: "check")
        let UnCheckImage = UIImage(named: "uncheck")
        if(btn?.image(for: UIControlState())! .isEqual(UnCheckImage))!
        {
            btn?.setImage(UnCheckImage, for: UIControlState())
            daysOfArray .remove(sender.tag)
        }
        else
        {
            btn?.setImage(Image, for: UIControlState())
            daysOfArray .add(sender.tag)
        }
    }
    func CategoryAction(_ sender :UIButton)
    {
        let btn = sender as UIButton!
        let Image = UIImage(named: "check")
        let UnCheckImage = UIImage(named: "uncheck")
        if(btn?.image(for: UIControlState())! .isEqual(Image))!
        {
            btn?.setImage(UnCheckImage, for: UIControlState())
        }
        else
        {
            btn?.setImage(Image, for: UIControlState())
        }
    }
    
    func CategoryAction1(_ sender :UIButton)
    {
        let btn = sender as UIButton!
        let Image = UIImage(named: "check")
        let UnCheckImage = UIImage(named: "uncheck")
        if(btn?.image(for: UIControlState())! .isEqual(Image))!
        {
            btn?.setImage(UnCheckImage, for: UIControlState())
        }
        else
        {
            btn?.setImage(Image, for: UIControlState())
        }
    }
    
    func DoneBtnAction(_ sender:UIButton)
    {
        //backgroundScrollView.contentOffset = CGPointMake(0, 0)
        let pickerDate : (Date) = timePicker.date
        let DF = DateFormatter()
        DF.dateFormat = "yyyy-MM-dd hh:mm:ss a"
        let dateStr = DF.string(from: pickerDate)
        let selectedDate : (Date) = DF.date(from: dateStr)!
        DF.dateFormat = "hh:mm:ss a"
        let selectedDateStr : (NSString) = DF.string(from: selectedDate) as (NSString)
        self.textTime.text = selectedDateStr as String;
        timePickerView .removeFromSuperview()
        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width , height: backgroundScrollView.contentSize.height - 200)
        self.setTimeAccordingToServer(strDate: dateStr as String)
    }
    
    func pickerCancelAction(_ sender:UIButton)
    {
        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width , height: backgroundScrollView.contentSize.height - 200)
        timePickerView.removeFromSuperview()
    }
    func handleSearch(_ search : NSString)
    {
        searchQuery.input = search as String
        searchQuery.fetchPlaces({ (places, error) -> Void in
            if((error) != nil)
            {
                SPPresentAlertViewWithErrorAndTitle(error, "Could not fetch Places")
            }
            else
            {
                self.searchResultPlaces = places as (NSArray)!
                self.listTableView.reloadData()
            }
        })
    }
    
    func backBtnAction (_ sender:UIButton)
    {
     //   self.navigateToBackView()
        
        
        navigationController!.isNavigationBarHidden = false
        // println("Hello Reja")
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
    }
    
    func NAActionBtn(_ sender:UIButton)
    {
        let btn = sender as UIButton!
        let Image = UIImage(named: "check")
        let UnCheckImage = UIImage(named: "uncheck")
        AABtn.setImage(UnCheckImage, for: UIControlState())
        CRBtn.setImage(UnCheckImage, for: UIControlState())
        if(btn?.image(for: UIControlState())! .isEqual(Image))!
        {
            btn?.setImage(UnCheckImage, for: UIControlState())
        }
        else
        {
            btn?.setImage(Image, for: UIControlState())
        }
    }
    func AAActionBtn(_ sender:UIButton)
    {
        let btn = sender as UIButton!
        let Image = UIImage(named: "check")
        let UnCheckImage = UIImage(named: "uncheck")
        
        NABtn.setImage(UnCheckImage, for: UIControlState())
        CRBtn.setImage(UnCheckImage, for: UIControlState())
        if(btn?.image(for: UIControlState())! .isEqual(Image))!
        {
            btn?.setImage(UnCheckImage, for: UIControlState())
        }
        else
        {
            btn?.setImage(Image, for: UIControlState())
        }
    }
    func CRActionBtn(_ sender:UIButton)
    {
        let btn = sender as UIButton!
        let checkImage = UIImage(named: "check")
        let UnCheckImage = UIImage(named: "uncheck")
        AABtn.setImage(UnCheckImage, for: UIControlState())
        NABtn.setImage(UnCheckImage, for: UIControlState())
        if(btn?.image(for: UIControlState())! .isEqual(checkImage))!
        {
            btn?.setImage(UnCheckImage, for: UIControlState())
        }
        else
        {
            btn?.setImage(checkImage, for: UIControlState())
        }
    }
    
    
    //MARK: Programs Actions
    func programSelectionAction(_ sender : UIButton)
    {
        resignAllTableViews()
        let subviews = programScrollView.subviews
        for view in subviews
        {
            if let btn = view as? UIButton
            {
                // var pBtn : (UIButton) = view as! (UIButton)
                // let btn = view as? UIButton
                btn.setImage(UIImage(named: "uncheck"), for: UIControlState())
                if(btn.tag == sender.tag)
                {
                    btn.setImage(UIImage(named: "check"), for: UIControlState())
                    let dictValues : NSDictionary = self.programArray.object(at: sender.tag) as! NSDictionary
                    let selectedprogramStr : (NSString) = dictValues.object(forKey: "id") as! (NSString)
                        //self.programArray.object(at: sender.tag) as! NSDictionary).value(forKey: "id") as String
                        //(self.programArray .value(forKey: "id") as AnyObject).objectAtIndex(sender.tag) as! String
                    programSelectedInt = selectedprogramStr.integerValue
                }
            }
        }
    }
    
    func catSelectionAction(_ sender : UIButton)
    {
        resignAllTableViews()
        let btn = sender as UIButton!
        let Image = UIImage(named: "check")
        let UnCheckImage = UIImage(named: "uncheck")
        if(btn?.image(for: UIControlState())! .isEqual(UnCheckImage))!
        {
            btn?.setImage(UnCheckImage, for: UIControlState())
            let dictValues : NSDictionary = self.categoryArray.object(at: sender.tag) as! NSDictionary
            let selectedprogramStr : (NSString) = dictValues.object(forKey: "id") as! (NSString)
            selectedCategoriesArray .remove(selectedprogramStr)
        }
        else
        {
            btn?.setImage(Image, for: UIControlState())
            let dictValues : NSDictionary = self.categoryArray.object(at: sender.tag) as! NSDictionary
            let selectedprogramStr : (NSString) = dictValues.object(forKey: "id") as! (NSString)
            selectedCategoriesArray .add(selectedprogramStr)
        }
    }
    
    
    //MARK : Actions
    func CountryGestureAction(_ recognizer : UIGestureRecognizer)
    {
        self.resignAllTableViews()
        //         backgroundScrollView.contentOffset = CGPointMake(backgroundScrollView.frame.origin.x, backgroundScrollView.frame.origin.y+30)
        self.countryTableView = UITableView()
        self.countryTableView.frame = CGRect(x: countryLabel.frame.origin.x,y: self.countryLabel.frame.maxY+180, width: countryLabel.frame.size.width, height: 70)
        self.countryTableView.dataSource = self
        self.countryTableView.delegate = self
        self.countryTableView.layer.borderColor = UIColor.gray.cgColor
        self.countryTableView.layer.borderWidth = 1.0
        //self.countryTableView.layer.cornerRadius =
        backgroundScrollView.addSubview(self.countryTableView)
    }
    
    func StateGestureAction(_ recognizer: UIGestureRecognizer)
    {
        self.resignAllTableViews()
        self.stateTableView = UITableView()
        self.stateTableView.frame = CGRect(x: StateLabel.frame.origin.x,y: self.StateLabel.frame.maxY+180, width: countryLabel.frame.size.width, height: 70)
        self.stateTableView.dataSource = self
        self.stateTableView.delegate = self
        self.stateTableView.layer.borderColor = UIColor.gray.cgColor
        self.stateTableView.layer.borderWidth = 1.0
        backgroundScrollView.addSubview(self.stateTableView)
    }
    func CityGestureAction(_ recognizer: UIGestureRecognizer)
    {
        self.resignAllTableViews()
        self.cityTableView = UITableView()
        self.cityTableView.frame = CGRect(x: cityLabel.frame.origin.x,y: self.cityLabel.frame.maxY+180, width: countryLabel.frame.size.width, height: 70)
        self.cityTableView.dataSource = self
        self.cityTableView.delegate = self
        self.cityTableView.layer.borderColor = UIColor.gray.cgColor
        self.cityTableView.layer.borderWidth = 1.0
        backgroundScrollView.addSubview(self.cityTableView)
    }
    func dayGestureAction(_ recognizer: UIGestureRecognizer)
    {
        self.resignAllTableViews()
        backgroundScrollView.contentSize = CGSize(width: backgroundScrollView.frame.size.width , height: backgroundScrollView.contentSize.height + 200)
        //        backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.frame.size.width, backgroundScrollView.frame.size.height+400)
        //scrollView.contentOffset = CGPointMake(0, 0)
        self.view.addSubview(timePickerView)
    }
    func dateGestureAction(_ recognizer: UIGestureRecognizer)
    {
        self.resignAllTableViews()
        backgroundScrollView.contentOffset = CGPoint(x: backgroundScrollView.frame.origin.x, y: backgroundScrollView.contentOffset.y+30)
        self.dateTableView = UITableView()
        self.dateTableView.frame = CGRect(x: dateLabel.frame.origin.x,y: dayLabel.frame.maxY + 160, width: countryLabel.frame.size.width, height: 70)
        self.dateTableView.dataSource = self
        self.dateTableView.delegate = self
        self.dateTableView.layer.borderColor = UIColor.gray.cgColor
        self.dateTableView.layer.borderWidth = 1.0
        backgroundScrollView.addSubview(self.dateTableView)
    }
    func monthGestureAction(_ recognizer: UIGestureRecognizer)
    {
        self.resignAllTableViews()
        backgroundScrollView.contentOffset = CGPoint(x: backgroundScrollView.frame.origin.x, y: backgroundScrollView.frame.origin.y+30)
        self.monthTableView = UITableView()
        self.monthTableView.frame = CGRect(x: monthLabel.frame.origin.x,y: dayLabel.frame.maxY + 160, width: countryLabel.frame.size.width, height: 70)
        self.monthTableView.dataSource = self
        self.monthTableView.delegate = self
        self.monthTableView.layer.borderColor = UIColor.gray.cgColor
        self.monthTableView.layer.borderWidth = 1.0
        backgroundScrollView .addSubview(self.monthTableView)
    }
    
    func resignAllTableViews()
    {
        textMName.resignFirstResponder()
        textZip.resignFirstResponder()
        textAddress1.resignFirstResponder()
        textAddress2.resignFirstResponder()
        self.textdescription.resignFirstResponder()
        textCountry.resignFirstResponder()
        textCity.resignFirstResponder()
        textState.resignFirstResponder()
        textTime.resignFirstResponder()
    }
    
    //MARK:- TableView Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if(tableView == countryTableView)
        {
            return countryArray.count
        }
        else if(tableView == cityTableView)
        {
            return cityArray.count
        }
        else if(tableView == stateTableView)
        {
            return stateArray.count
        }
        else if(tableView == dayTableView)
        {
            return dayArray.count
        }
        else if(tableView == dateTableView)
        {
            return dateArray.count
        }
        else if(tableView == monthTableView)
        {
            return monthArray.count
        }
        else if(tableView == listTableView)
        {
            return searchResultPlaces.count
        }
        else
        {
            return 1
        }
        }
 
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     {
     
         var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
         
         if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell!.textLabel?.textColor = UIColor.black
            cell?.textLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
         }
     
         if(tableView == countryTableView)
         {
            cell?.textLabel?.text = countryArray .object(at: indexPath.row) as? String
         }
         else if(tableView == cityTableView)
         {
            cell?.textLabel?.text = cityArray .object(at: indexPath.row) as? String
         }
         else if(tableView == stateTableView)
         {
            cell?.textLabel?.text = stateArray .object(at: indexPath.row) as? String
         }
         else if(tableView == dayTableView)
         {
            cell?.textLabel?.text = dayArray .object(at: indexPath.row) as? String
         }
         else if(tableView == dateTableView)
         {
            cell?.textLabel?.text = dateArray .object(at: indexPath.row) as? String
         }
         else if(tableView == monthTableView)
         {
            cell?.textLabel?.text = monthArray .object(at: indexPath.row) as? String
         }
         else if(tableView == listTableView)
         {
            let places : (SPGooglePlacesAutocompletePlace) = searchResultPlaces .object(at: (indexPath as NSIndexPath).row) as! (SPGooglePlacesAutocompletePlace)
            let tetStr  : (NSString) = places.name as (NSString)
            cell?.textLabel?.text = tetStr as String
         }
         else
         {
            cell?.textLabel?.text = ""
         }
        return cell!
     }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
    //self.resignAllTableViews()
        if(tableView == countryTableView)
        {
            countryLabel.text = countryArray.object(at: (indexPath as NSIndexPath).row) as? String
            countryLabel.textColor = UIColor.black
         }
         else if(tableView == cityTableView)
         {
            cityLabel.text = cityArray .object(at: (indexPath as NSIndexPath).row) as? String
            cityLabel.textColor = UIColor.black
         }
         else if(tableView == stateTableView)
         {
            StateLabel.text = stateArray .object(at: (indexPath as NSIndexPath).row) as? String
            StateLabel.textColor = UIColor.black
         }
         else if(tableView == dayTableView)
         {
            dayLabel.text = dayArray .object(at: (indexPath as NSIndexPath).row) as? String
            dayLabel.textColor = UIColor.black
         }
         else if(tableView == dateTableView)
         {
             dateLabel.text = dateArray .object(at: (indexPath as NSIndexPath).row) as? String
             dateLabel.textColor = UIColor.black
         }
         else if(tableView == monthTableView)
         {
             monthLabel.text = monthArray .object(at: (indexPath as NSIndexPath).row) as? String
             monthLabel.textColor = UIColor.black
         }
         else if(tableView == listTableView)
         {
         //SVProgressHUD.showWithStatus("Loading...")
         SVProgressHUD.show(withStatus: "Loading...", maskType: SVProgressHUDMaskType.black)
         self.textCity.text = ""
         self.textCountry.text = ""
         self.textState.text = ""
         self.textZip.text = ""
         self.listTableView .removeFromSuperview()
         let places : (SPGooglePlacesAutocompletePlace) = searchResultPlaces .object(at: (indexPath as NSIndexPath).row) as! (SPGooglePlacesAutocompletePlace)
         let tetStr  : (NSString) = places.name as (NSString)
         self.textAddress1.text = tetStr as String;
         let address = tetStr as String;
         
         searchStr = NSMutableString()
         searchStr = tetStr.mutableCopy() as! (NSMutableString);
         
         //AIzaSyCl72yvTpELfdPsUMlh60YhkYoaXf5Y85s
         //            var urlString : (String) = String(format: "https://maps.google.com/maps/api/geocode/json?key=AIzaSyCu3RgLlDtHgw3ujBCQdL63m40iW5HbcxU&sensor=true&address=%@", address)
         var urlString : (String) = String(format: "https://maps.google.com/maps/api/geocode/json?key=AIzaSyCl72yvTpELfdPsUMlh60YhkYoaXf5Y85s&sensor=true&address=%@",address)
         urlString = urlString.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil)
         
         let url : URL = URL(string:urlString as String)!
         let data : (Data) = try! Data(contentsOf: url)
         var json: (AnyObject)!
         do {
         json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] as (AnyObject)
         
         } catch {
         print(error)
         }
         let dict :(NSDictionary) = json as! (NSDictionary)
         print(dict)

         let result: NSArray  =  dict.value(forKey: "results") as! (NSArray )
         print(result)
            if result.count == 0
            {
               SVProgressHUD .dismiss()
                return
            }
         let firstItem:  NSDictionary  = result.object(at: 0) as! NSDictionary
         let geometry:  NSDictionary  =  firstItem.object(forKey: "geometry") as! NSDictionary
         let address_components:  NSArray  =  firstItem.object(forKey: "address_components") as! NSArray
         print(address_components)
         let location: NSDictionary  =  geometry.object(forKey: "location") as! NSDictionary
         let lati:  NSNumber  = location.object(forKey: "lat") as! NSNumber
         let long:  NSNumber  = location.object(forKey: "lng") as! NSNumber
         var postal_code_value:  NSDictionary!
         var postal_code : String!
         var city_value:  NSDictionary!
         var city_value_code : String!
        
            
         postal_code_value = address_components.lastObject as! NSDictionary
         postal_code  = postal_code_value.object(forKey: "long_name") as! String
         city_value = address_components.object(at: 2) as! NSDictionary
         city_value_code  = city_value.object(forKey: "long_name") as! String
           print(city_value_code)
           print(city_value)

            
//         if address_components.count >= 6 {
//         city_value = address_components.object(at: 2) as! NSDictionary
//         city_value_code  = city_value.object(forKey: "long_name") as! String
//         } else {
//         city_value = address_components.object(at: 0) as! NSDictionary
//         city_value_code  = city_value.object(forKey: "long_name") as! String
//         }
         latitudeValue = CLLocationDegrees(lati)
         longitudeValue = CLLocationDegrees(long)
         textdelValue11 = 0
         
//         var eror: NSError?
//         var geocoder = CLGeocoder()
//         geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
            
            //New Code 
            let geocoder = CLGeocoder()
            
            geocoder.geocodeAddressString(address, completionHandler: {(placemarks, eror) -> Void in
                if let validPlacemark = placemarks?[0]
         
         // })
         //            geocoder.geocodeAddressString(address, completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
//         if (((placemarks?[0])! as? CLPlacemark) != nil)
         {
             let placemark:CLPlacemark = (validPlacemark as CLPlacemark);
         //var placemark:CLPlacemark = placemarks![0]
         let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
         //let title = ABCreateStringWithAddressDictionary(placemark.addressDictionary!, false)
            if((eror) != nil)
         {
         }
         else
         {
         let dict  = placemark.addressDictionary! as NSDictionary
         if ((dict.object(forKey: "ZIP")) == nil )
         {
         self.textZip.text = postal_code
         self.textCity.text = city_value_code
         if ((dict.object(forKey: "Country")) != nil)
         {
         self.textCountry.text = dict.object(forKey: "Country") as! NSString as String
         }
         if ((dict.object(forKey: "State")) != nil)
         {
         self.textState.text = dict.object(forKey: "State") as! NSString as String
         }
         }
         else
         {
         if ((dict.object(forKey: "ZIP")) != nil)
         {
         self.textZip.text = dict.object(forKey: "ZIP") as! NSString as String
         }
         if ((dict.object(forKey: "City")) != nil)
         {
         self.textCity.text = dict.object(forKey: "City") as! NSString as String
         }
         
         if ((dict.object(forKey: "Country")) != nil)
         {
         self.textCountry.text = dict.object(forKey: "Country") as! NSString as String
         }
         if ((dict.object(forKey: "State")) != nil)
         {
         self.textState.text = dict.object(forKey: "State") as! NSString as String
         }
         print(coordinates.latitude)
         print(coordinates.longitude)
         }
         SVProgressHUD .dismiss()
         }
         
         } else {
         SVProgressHUD .dismiss()
         let city   = address_components.object(at: 0) as! NSDictionary
         let  cityValue  = city.object(forKey: "long_name") as! String
         let state   = address_components.object(at: 0) as! NSDictionary
         let  stateValue  = state.object(forKey: "long_name") as! String
         let country    = address_components.object(at: 2) as! NSDictionary
         let countryValue  = country.object(forKey: "long_name") as! String
         self.textCity.text = cityValue
         self.textCountry.text = countryValue
         self.textState.text = stateValue
         
         }
         })
         }
         else
         {
         
         }
  }
    //MARK:- SUBMIT
    func SubmitBtnAction(_ sender : UIButton)
    {
    print(textdelValue1)
    let  checkImage = UIImage(named: "check")
    meetingval()
    if(self.checkAllFields())
    {
        
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
       
        SVProgressHUD.show(withStatus: "Loading..", maskType: SVProgressHUDMaskType.black)
    var appUser = SMLAppUser()
    appUser =   SMLAppUser.getUser()
    //var dictValues: (NSDictionary) = NSUserDefaults.standardUserDefaults().objectForKey("UserData") as! NSDictionary
    // println(dictValues)
    let loginId: (NSString) = appUser.userId
    let meetingName : (NSString) = textMName.text! as NSString
    let desc : (NSString) = textdescription.text! as NSString
    let cityText : (NSString) = textCity.text!  as NSString
    let timeText : (NSString) = textTime.text! as NSString
    let countryText : (NSString) = textCountry.text! as NSString
    let stateText : (NSString) = textState.text! as NSString
    let zipCode : (NSString) = textZip.text! as NSString
    //let address1 : (NSString) = textAddress1.text! as NSString
    //let address2 : (NSString) = textAddress2.text! as NSString
    let subviews = dayBtnsView.subviews
    
    
    for view in subviews
    {
    let btn = view as? UIButton
    if(btn!.isKind(of: UIButton.self))
    {
    if(btn?.image(for: UIControlState()) == checkImage)
    {
    // daysOfArray.addObject(btn?.tag)
    }
    //                    btn?.setImage(UIImage(named: "uncheck"), forState: UIControlState.Normal)
    //                    if(btn!.tag == sender.tag)
    //                    {
    //                        btn?.setImage(UIImage(named: "check"), forState: UIControlState.Normal)
    //                        var selectedprogramStr : (NSString) = self.programArray .valueForKey("id")?.objectAtIndex(sender.tag) as! String
    //                        programSelectedInt = selectedprogramStr.integerValue
    //                    }
    }
    }
    
    
    let daysString = NSMutableString()
    // println(daysOfArray)
    for ia in 0..<daysOfArray.count
    {
    
    let selectedDay : (Int) = self.daysOfArray.object(at: ia) as! (Int)
    let selectedStr : (NSString) = NSString(format: "%d", selectedDay)
    daysString .append(selectedStr as String)
    
    if(ia == daysOfArray.count - 1)
    {
    
    }
    else
    {
    daysString.append(",")
    }
    }
    
    
    let catString = NSMutableString()
    for  ca in 0..<selectedCategoriesArray.count
    {
    
    //var selectedCa : (Int) = self.selectedCategoriesArray.objectAtIndex(ca) as! (Int)
    // var selectedCaStr : (NSString) = NSString(format: "%d", selectedCa)
    let selectedCaStr : (NSString) = self.selectedCategoriesArray.object(at: ca) as! NSString
    catString .append(selectedCaStr as String)
    if(ca == selectedCategoriesArray.count - 1)
    {
    
    }
    else
    {
    catString.append(",")
    }
    }
    
    
    // http://112.196.34.179/stepslocator/index.php/login/wsaddmeeting?login_id=&program_id=&category_id=&meeting_name=&description=&country=&state=&city=&zip=&address1=&address2=&location=&meetingdatetime=&latitude=&longitude=&days_of_week=
    
        
    //            var location : (CLLocationCoordinate2D) = CLLocationCoordinate2DMake(addressLocation.coordinate.latitude, addressLocation.coordinate.longitude)
    
    //            var userDefaults : NSUserDefaults = NSUserDefaults.standardUserDefaults()
    
    //            if (userDefaults.objectForKey("Location") != nil)
    //            {
    //
    //
    //
    //            var dict : (NSDictionary) = NSUserDefaults.standardUserDefaults().objectForKey("Location") as! NSDictionary
    //
    //
    //            var latStr: (NSString) = dict.valueForKey("latitude") as! String
    //            var longStr : (NSString) = dict.valueForKey("longitude") as! String
    //
    //            latitude  = latStr.doubleValue
    //            longitude  = longStr.doubleValue
    //
    //            }
    //            else
    //            {
    //                latitude  = 00000
    //                longitude  =  00000
    //            }
    
    
    let parameters : (NSDictionary) =
    ["login_id" : loginId,
    "program_id" :   programSelectedInt,
    "category_id"  :  catString,
    "meeting_name" : meetingName,
    "description" : desc,
    "meetingdatetime" : timeText,
    "days_of_week"    : daysString,
    "latitude" : latitudeValue,
    "longitude" : longitudeValue,
    "country" : countryText,
    "state" : stateText,
    "city" : cityText,
    "zip" : zipCode,
    "address1" : textAddress1.text! as NSString,
    "address2" : textAddress2.text! as NSString]
            
     print(parameters)
        
//    let parameters : (NSDictionary) =       ["login_id" : loginId,
//                                             "program_id" : programSelectedInt,
//                                             "category_id" : catString,
//                                             "meeting_name" : meetingName,
//                                             "description" : desc,
//                                             "meetingdatetime" : timeText,
//                                             "days_of_week" : daysString,
//                                             "latitude" :  latitudeValue,
//                                             "longitude" : longitudeValue,
//                                             "country" : countryText,
//                                             "state" : stateText,
//                                             "city" : cityText,
//                                             "zipCode" : zipCode,
//                                             "address1" : textAddress1.text! as NSString,
//                                            "address2" : textAddress2.text! as NSString]
    
        print(parameters)
        WebserviceManager.sharedInstance.addMeeting(params: parameters, withCompletionBlock: { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if success == 0
                {
                    let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                    let alert : UIAlertController = UIAlertController.init(title: "", message: message as String, preferredStyle: UIAlertControllerStyle.alert)
                    self.present(alert, animated: true, completion: nil)
                    let okAction : UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        self.navigateToBackView()
                    })
                    alert.addAction(okAction)
                    SVProgressHUD.dismiss()
                }
                else
                {
//                var dict :(NSDictionary) = responseObject as! NSDictionary
                    let alert : UIAlertController = UIAlertController.init(title: "", message: "Your meeting has been added to our database. Once approved , you will be notified by push notification." as String, preferredStyle: UIAlertControllerStyle.alert)
                    self.present(alert, animated: true, completion: nil)
                    let okAction : UIAlertAction = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
                        self.navigateToBackView()
                    })
                    alert.addAction(okAction)
                    SVProgressHUD.dismiss()
                }
            }
            else
            {
                print(error?.localizedDescription)
                let string : (NSString) = error!.localizedDescription as NSString
                SVProgressHUD.dismiss()
                SMLGlobal.sharedInstance.displayAlertMessage(self, string , title: "")
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
    firstBlnkValue = 0
    
    }
    
    
    }
    func navigateToBackView()
    {
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: TextField Delegate Methods
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if(textField == textAddress1)
        {
            //          textdelValue = count(textAddress1.text)
            //            println("Text Enter Value:-\(textdelValue)")
        }
        else
        {
         listTableView.removeFromSuperview()
        }
        let tagValue : CGFloat =  CGFloat(textField.tag)
        if(tagValue == 10)
        {
            textField .resignFirstResponder()
            backgroundScrollView.contentOffset = CGPoint(x: 0,y: 250);
        }
        else
        {
            backgroundScrollView.contentOffset = CGPoint(x: 0,y: (tagValue * 30) + 250);
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //        if count(textAddress1.text) == -1  {
        //            listTableView.removeFromSuperview()
        //        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField .resignFirstResponder()
        if textField == textAddress1
        {
            listTableView.removeFromSuperview()
        }
        if textField == textMName
        {
            textAddress1.becomeFirstResponder()
        }
        else if textField == textAddress1
        {
            textAddress2.becomeFirstResponder()
        }
        else if textField == textAddress2
        {
            textCountry.becomeFirstResponder()
        }
        else if textField == textCountry
        {
            textState.becomeFirstResponder()
        }
        else if textField == textState
        {
            textZip.becomeFirstResponder()
        }
        else if textField == textZip
        {
            textCity.becomeFirstResponder()
        }
        else if textField == textCity
        {
           textdescription.becomeFirstResponder()
        }
        else if textField == textdescription
        {
          textField .resignFirstResponder()
        }
        else
        {
          textField .resignFirstResponder()
        }
        //backgroundScrollView.contentSize = CGSize.init(width: backgroundScrollView.frame.size.width, height: backgroundScrollView.contentSize.height - 200)
        //backgroundScrollView.contentOffset = CGPointMake(0, 0)
        return true
    }
    
    func meetingval() {
        
        let str = textMName.text! as NSString
        let str10 = textAddress1.text! as NSString
        let str1 = textAddress2.text! as NSString
        let str2 = textCountry.text! as NSString
        let str3 = textState.text! as NSString
        let str4 = textZip.text! as NSString
        let str5 = textCity.text! as NSString
        let str6 = textdescription.text! as NSString
        let d = 32 as unichar
        if (textMName.text?.characters.count)! > 2 {
            
            if str == "" {
                firstBlnkValue = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue = 1
                    
                } else {
                    firstBlnkValue = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if textMName.text?.characters.count == 1 {
            
            let c:unichar = str.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue = 1
                
            } else {
                firstBlnkValue = 0
                
            }
        }
        if  textAddress2.text == "" {
            textdelValue1 = 0
            
        }
        if (textAddress1.text?.characters.count)! > 2 {
            
            if str10 == "" {
                textdelValue10 = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str10.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str10.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    textdelValue10 = 1
                    
                } else {
                    textdelValue10 = 0
                }
                // println("Sk Rejabul")
            }
        }
        
        if textAddress1.text?.characters.count == 1 {
            let c:unichar = str10.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                textdelValue10 = 1
                
            } else {
                textdelValue10 = 0
            }
        }
        if (textAddress2.text?.characters.count)! > 2 {
            
            if str1 == "" {
                textdelValue1 = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str1.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str1.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    textdelValue1 = 1
                    
                } else {
                    textdelValue1 = 0
                }
            }
        }
        
        if textAddress2.text?.characters.count == 1 {
            let c:unichar = str1.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                textdelValue1 = 1
                
            } else {
                textdelValue1 = 0
            }
        }
        if (textCountry.text?.characters.count)! > 2 {
            
            if str2 == "" {
                self.textdelValue2 = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str2.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str2.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    textdelValue2 = 1
                    
                } else {
                    textdelValue2 = 0
                }
            }
        }
        
        if textCountry.text?.characters.count == 1 {
            
            let c:unichar = str2.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                textdelValue2 = 1
                
            } else {
                textdelValue2 = 0
                
            }
        }
        if (textState.text?.characters.count)! > 2 {
            
            if str3 == "" {
                textdelValue3 = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str3.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str3.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    textdelValue3 = 1
                    
                } else {
                    textdelValue3 = 0
                }
            }
        }
        
        if textState.text?.characters.count == 1 {
            
            let c:unichar = str3.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                textdelValue3 = 1
            } else {
                textdelValue3 = 0
            }
        }
        if (textZip.text?.characters.count)! > 2 {
            
            if str4 == "" {
                textdelValue4 = 0
                
                //println("Sk Rejabul")
            } else {
               // var value = str4.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str4.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    textdelValue4 = 1
                    
                } else {
                    textdelValue4 = 0
                }
            }
        }
        
        if textZip.text?.characters.count == 1 {
            
            let c:unichar = str4.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                self.textdelValue4 = 1
                
            } else {
                textdelValue4 = 0
            }
        }
        if (textCity.text?.characters.count)! > 2 {
            
            if str5 == "" {
                textdelValue4 = 0
                
                //println("Sk Rejabul")
            } else {
//                var value = str5.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str5.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    textdelValue5 = 1
                    
                } else {
                    textdelValue5 = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if textCity.text?.characters.count == 1 {
            
            let c:unichar = str5.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                textdelValue5 = 1
            } else {
                textdelValue5 = 0
            }
        }
        if (textdescription.text?.characters.count)! > 2 {
            
            if str6 == "" {
                self.textdelValue6 = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str6.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str6.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    textdelValue6 = 1
                    
                } else {
                    textdelValue6 = 0
                }
            }
        }
        
        if textdescription.text?.characters.count == 1 {
            let c:unichar = str6.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                textdelValue6 = 1
                
            } else {
                textdelValue6 = 0
                
            }
        }
    }

    
    
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func setTimeAccordingToServer(strDate: String)
    {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss" //yyyy-MM-dd hh:mm:ss a
//        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
//        let date = dateFormatter.date(from:strDate)
//        
//        // change to a readable time format and change to local time zone
//        dateFormatter.dateFormat = "hh:mm:ss a"
//        dateFormatter.timeZone = NSTimeZone.local
//        let timeStamp = dateFormatter.string(from: date!)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
