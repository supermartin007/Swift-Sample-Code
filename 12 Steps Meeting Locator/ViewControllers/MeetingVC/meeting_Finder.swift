//
//  meeting_Finder.swift
//  mainView
//
//  Created by iApp on 03/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



var lat : NSString = NSString()
var long : NSString = NSString()
var mapSegment: UISegmentedControl = UISegmentedControl()
var searchTextView: UIView = UIView()
var textSearchView = ScreenSize.height / 6
var meetingMapview : MKMapView = MKMapView()
var listTableview:  UITableView!
var searchButton: UIButton = UIButton()
var searchBarView: UISearchBar  = UISearchBar()
var seg = 0
var mapSelect = 0
var listSelected = 1
var listSelected2 = 2
var combineStr : (NSMutableString) = NSMutableString()



let compelteArray : (NSDictionary) = NSDictionary()
//var latdelta : (CLLocationDegrees) = CLLocationDegrees()
//var londelta = CLLocationDegrees()
//var annotation = MKPointAnnotation()
//var customSegmentedControl = UISegmentedControl (items: ["Map","List"])

 var items:NSArray!
var finalArray: NSArray!
var itemsArr : (NSArray) =  NSArray()
var mapBtn: UIButton!
var ListBtn: UIButton!
var viewC: UIView = UIView()

class meeting_Finder: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate,MKMapViewDelegate,CLLocationManagerDelegate, UITextFieldDelegate {
    let locationManager  = CLLocationManager()
    let contentCellIdentifier = "ContentCellIdentifier"
    var helper: meeting_Finder!
    var textView: UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewC.removeFromSuperview()
         self.view.backgroundColor = UIColor.white
      
      
        // Do any additional setup after loading the view.
        self.createUI();
    }
    
    func createUI()
    {
        /* Create Array */
        items = NSArray()
        finalArray = NSArray()
        /* Set Map By Default Open */
        
//        mapBtn.setTitleColor(UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0), forState: UIControlState.Normal)
//        ListBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        /* Create Top Custom View */
        searchTextView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 100 )
        searchTextView.backgroundColor = UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0)
        self.view.addSubview(searchTextView)
        
        
        /* Create Top Custom map View */
        meetingMapview.frame = CGRect(x: 0, y: searchTextView.frame.maxY + 1, width: ScreenSize.width, height: ScreenSize.height - searchTextView.frame.height)
        meetingMapview.delegate = self
        
        let tapGesture : (UITapGestureRecognizer) = UITapGestureRecognizer()
        meetingMapview.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self, action: #selector(meeting_Finder.MapViewGesture(_:)))
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //        locationManager.requestWhenInUseAuthorization()
        //       locationManager.startUpdatingLocation()
        //        locationManager.requestWhenInUseAuthorization()
        
        
        
        
        
        
        //        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //        locationManager.startUpdatingLocation()
        //        var latitude:CLLocationDegrees = locationManager.location.coordinate.latitude
        //        var longitude:CLLocationDegrees = locationManager.location.coordinate.longitude
        //        var homeLati: CLLocationDegrees = 40.01540192
        //        var homeLong: CLLocationDegrees = 20.87901079
        //        var latDelta:CLLocationDegrees = 0.01
        //        var longDelta:CLLocationDegrees = 0.01
        //        var theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        //        var myHome:CLLocationCoordinate2D = CLLocationCoordinate2DMake(homeLati, homeLong)
        //        var myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        //        var theRegion:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, theSpan)
        //        meetingMapview.setRegion(theRegion, animated: true)
        //        meetingMapview.mapType = MKMapType.Standard
        //        meetingMapview.showsUserLocation = true
        //        var myHomePin = MKPointAnnotation()
        //        myHomePin.coordinate = myHome
        //
        //        meetingMapview.addAnnotation(myHomePin)
        
        
        //        self.locationManager.delegate = self
        //        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
        /* Create Top Custom table View */
        
        listTableview = UITableView()
        listTableview.frame = CGRect(x: 0, y: searchTextView.frame.maxY + 1, width: ScreenSize.width, height: ScreenSize.height - searchTextView.frame.height)
        self.view.addSubview(listTableview)
        listTableview.isHidden = true
        listTableview.delegate = self
        listTableview.dataSource = self
        
        /* Create Top Custom Home Button */
        
        
        let homeButton: UIButton = UIButton()
        homeButton.frame = CGRect(x: 16, y: 25, width: 30, height: 30)
        let homeImage: UIImage = UIImage(named: "home")!
        homeButton.setBackgroundImage(homeImage, for: UIControlState())
        homeButton.addTarget(self, action: #selector(meeting_Finder.homeClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        homeButton.setBackgroundImage(homeImage, for: UIControlState())
        searchTextView.addSubview(homeButton)
        
        /* Create Top Custom Right Button View */
        
        let rightButton: UIButton = UIButton()
        rightButton.frame = CGRect(x: ScreenSize.width - 40, y: 30, width: 28, height: 29)
        rightButton.addTarget(self, action: #selector(meeting_Finder.rightButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //rightButton.backgroundColor = UIColor.whiteColor()
        let rightButtonImage: UIImage = UIImage(named: "arrow")!
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        rightButton.setBackgroundImage(rightButtonImage, for: UIControlState())
        searchTextView.addSubview(rightButton)
        
        /* Create  Custom customSegmentedControlView */
        
        let sgmentViewHeight = searchTextView.frame.height
        let customSegmentedControlView: UIView = UIView()
        customSegmentedControlView.frame = CGRect(x: homeButton.frame.maxX + 40, y: sgmentViewHeight / 4 + 5,width: 165, height: 24)
        customSegmentedControlView.backgroundColor = UIColor.gray
        customSegmentedControlView.backgroundColor = UIColor.clear
        customSegmentedControlView.layer.cornerRadius = 5
        customSegmentedControlView.layer.borderWidth = 2
        customSegmentedControlView.layer.borderColor = UIColor.white.cgColor
        searchTextView.addSubview(customSegmentedControlView)
        /* Create  Custom Map Button */
        mapBtn = UIButton.init(type: UIButtonType.custom)
        mapBtn.frame = CGRect(x: 2, y: 2,width: 80, height: 20)
        mapBtn.setTitle("Map", for: UIControlState())
        mapBtn.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
        mapBtn.addTarget(self, action: #selector(meeting_Finder.MapClicks(_:)), for: UIControlEvents.touchUpInside)
        mapBtn.setTitleColor(UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0), for: UIControlState())
        mapBtn.backgroundColor = UIColor.white
        customSegmentedControlView.addSubview(mapBtn)

        /* Create  Custom List Button */
        ListBtn = UIButton.init(type: UIButtonType.custom) 
        ListBtn.frame = CGRect(x: mapBtn.frame.maxX+2, y: 2,width: 80, height: 20)
        ListBtn.setTitle("List", for: UIControlState())
        ListBtn.titleLabel!.font =  UIFont.systemFont(ofSize: 14)
        ListBtn.addTarget(self, action: #selector(meeting_Finder.ListClicks(_:)), for: UIControlEvents.touchUpInside)
        ListBtn.setTitleColor(UIColor.white, for: UIControlState())
        ListBtn.backgroundColor = UIColor.clear
        customSegmentedControlView.addSubview(ListBtn)
        
        //var value = searchTextView.frame.height - 50
        /* Create  Custom Search Bar */
        
        let value = searchTextView.frame.height - 50
        
        let searchView: UIButton = UIButton()
        searchView.frame = CGRect(x: 20, y: value + 13, width: ScreenSize.width - 40,  height: 20 * 1.35)
        searchView.backgroundColor = UIColor.white
        searchView.layer.cornerRadius = 0.04 * searchView.frame.width
        searchView.layer.borderColor = UIColor.clear.cgColor
        //searchBarView.showsBookmarkButton = true
        searchView.clipsToBounds = true
        searchTextView.addSubview(searchView)
        
        
        textView.frame = CGRect(x: 30, y: 0, width: searchView.frame.width - 50,  height: 20 * 1.35)
        
        let placeholder1 = NSAttributedString(string: "Search by title", attributes: [NSForegroundColorAttributeName : UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.6)])
        textView.attributedPlaceholder = placeholder1;
        textView.font = SMLGlobal.sharedInstance.fontSize(10)
        searchView.addSubview(textView)
        textView.delegate = self
        
        let UIImg : UIButton = UIButton()
        UIImg.frame = CGRect(x: searchView.frame.width - 27,y: (searchView.frame.size.height - 25)/2, width: 25, height: 25)
        let  butImg = UIImage(named: "search_arrow_icon")
        UIImg.setBackgroundImage(butImg, for: UIControlState())
        UIImg.addTarget(self, action: #selector(meeting_Finder.searchButt(_:)), for: UIControlEvents.touchUpInside)
        searchView.addSubview(UIImg)
        
        let searchIcon : UIImageView = UIImageView()
        searchIcon.frame = CGRect(x: 5, y: 3.5, width: 20, height: 20)
        
        searchIcon.image = UIImage(named: "search_icon")
        searchView.addSubview(searchIcon)
        
        
        //        searchBarView.frame = CGRectMake(20, value + 20, ScreenSize.width - 40,  20 * 1.2)
        //        searchBarView.placeholder = "Click Here To Search"
        //        searchBarView.layer.cornerRadius = 0.04 * searchBarView.frame.width
        //        searchBarView.layer.borderColor = UIColor.clearColor().CGColor
        //        searchBarView.showsBookmarkButton = true
        //        searchBarView.clipsToBounds = true
        //
        //        var imageBar = UIImage(named: "dc7eA98di")
        //        searchBarView.setImage(imageBar, forSearchBarIcon: UISearchBarIcon.Bookmark, state: UIControlState.Normal)
        //        searchTextView.addSubview(searchBarView)
        
        /* Register Custom Cell   */
        
        listTableview.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: contentCellIdentifier)
        
        
        searchBarView.delegate = self
        searchBarView.barTintColor = UIColor.white
        
        // navigationController!.navigationBarHidden = true
        self.getNearByMeetings()
        if seg == 0 {
            meetingMapview.isHidden = false
            listTableview.isHidden = true
        }  else if seg == 1 {
            meetingMapview.isHidden = true
            listTableview.isHidden = false
            listSelected2 = 2
            //webserviceCall()
            //listTableview.reloadData()
            //listTableview.estimatedRowHeight = 200
            //TableViewCell.
        }
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
       // listTableview.reloadData()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchButt(_ sender : UIButton)
    {
//        if textView.text
//        {
//            combineStr.deleteCharactersInRange(NSMakeRange(combineStr.length - 1, 1))
//        }
//        else
//        {
//            combineStr.appendString(string)
//        }
        
        
        
        if(textView.text == "")
        {
            finalArray = items
            listTableview.reloadData()
            
        }
        else
        {
            let predicate : NSPredicate = NSPredicate(format: "meeting_name contains[c] %@ ", textView.text!)
            finalArray = items.filtered(using: predicate) as NSArray!
            // println(finalArray)
            listTableview.reloadData()
        }
    }
    
    func homeClick(_ sender: UIButton) {
        navigationController!.isNavigationBarHidden = false
       // self.navigationController?.popViewControllerAnimated(false)
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
    }
    
    func rightButtonClick(_ sender: UIButton) {
        //println("rightButton Clicked")
    }
    
    
//    func MapClick(sender: UIButton) {
//        println("rightButton Clicked")
//        mapBtn.backgroundColor = UIColor.whiteColor()
//        ListBtn.backgroundColor = UIColor.clearColor()
//        mapBtn.setTitleColor(UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0), forState: UIControlState.Normal)
//        ListBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        meetingMapview.hidden = false
//        listTableview.hidden = true
//       
//    }
//    
//    
//    //ListClick:
//    func ListClick(sender: UIButton) {
//        ListBtn.backgroundColor = UIColor.whiteColor()
//        mapBtn.backgroundColor = UIColor.clearColor()
//        ListBtn.setTitleColor(UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0), forState: UIControlState.Normal)
//        mapBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
//        meetingMapview.hidden = true
//        listTableview.hidden = false
//        listSelected2 = 2
//        //webserviceCall()
//        listTableview.reloadData()
//    }
    
    func MapClicks(_ sender: UIButton) {
       // println("rightButton Clicked")
        mapBtn.backgroundColor = UIColor.white
        ListBtn.backgroundColor = UIColor.clear
        mapBtn.setTitleColor(UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0), for: UIControlState())
        ListBtn.setTitleColor(UIColor.white, for: UIControlState())
        meetingMapview.isHidden = false
        listTableview.isHidden = true
        
    }
    
    
    //ListClick:
    func ListClicks(_ sender: UIButton)
    {
        ListBtn.backgroundColor = UIColor.white
        mapBtn.backgroundColor = UIColor.clear
        mapBtn.setTitleColor(UIColor.white, for: UIControlState())
        ListBtn.setTitleColor(UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0), for: UIControlState())
        meetingMapview.isHidden = true
        listTableview.isHidden = false
    }

    
//    func segmentedValueChanged(sender:UISegmentedControl!)
//    {
//         var seg = sender.selectedSegmentIndex
//        if sender.selectedSegmentIndex == 0 {
//          
//            println("entered")
//            
//        } else if sender.selectedSegmentIndex == 1 {
//           
//            println("entered")
//
//            //listTableview.estimatedRowHeight = 200
//            //TableViewCell.
//        }
//    }
    
    
    func getNearByMeetings()
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
        //http://112.196.34.179/stepslocator/index.php/login/wsMeetingsNearby?latitude=&longitude=
       
//        var delegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//       
//        var latitude : (CLLocationDegrees) = delegate.latdelta
//        var longitude : (CLLocationDegrees) = delegate.latdelta
        let userDefaults : UserDefaults = UserDefaults.standard
        var latStr: (NSString) = NSString()
        var longStr : (NSString) = NSString()
        if (userDefaults.object(forKey: "Location") != nil)
        {
         let dict : (NSDictionary) = UserDefaults.standard.object(forKey: "Location") as! NSDictionary
         latStr = dict.value(forKey: "latitude") as! String as (NSString)
         longStr = dict.value(forKey: "longitude") as! String as (NSString)
        }
        else
        {
//            latStr  = "30.6793";
//            longStr = "76.7293"
        }
       // var latitude : (CLLocationDegrees) = latStr.doubleValue
        //var longitude : (CLLocationDegrees) = longStr.doubleValue
        // latStr  = "30.6793";
        //longStr = "76.7293"
        //latitude=30.6799&longitude=76.722130.680339, 76.728552
         let parameters : (NSDictionary) = ["latitude" : latStr,
            "longitude" : longStr]
        WebserviceManager.sharedInstance.getMeetingNearBy(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if success == 0
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, "No result Found", title: "")
                }
                else if success == 1
                {
                    self.view.addSubview(meetingMapview)
                    items = responseObject?.value(forKey: "data") as! NSArray;
                    finalArray = responseObject?.value(forKey: "data") as! NSArray;
                    listTableview.reloadData()
                    self.displayAnnotations()
                }
            }
            else
            {
                
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
        var count : Int = 0
        for i in 0 ..< finalArray.count
       {
        //
       //println(items)
        var array : (NSArray) = NSArray()
        array  = finalArray as NSArray
        
     
        let dictValues : (NSDictionary) = array.object(at: i) as! NSDictionary
        let latitudeStr : (NSString) = dictValues.object(forKey: "latitude") as! (NSString)
        let longitudeStr : (NSString) = dictValues.object(forKey: "longitude") as! (NSString)
        
        
        let MomentaryLatitude = latitudeStr.doubleValue
        let MomentaryLongitude = longitudeStr.doubleValue
        
        if(lat.length<=0&&long.length<=0)
        {
            lat = latitudeStr
            long = longitudeStr
        }
        
        
        if (lat == latitudeStr && long == longitudeStr)
        {
          //  println(count)
            
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
        
        
       // meetingMapview.showAnnotations(annotation, animated: true)
        
//        latdelta = location.latitude
//        londelta = location.longitude
        
        
        let leftButton : UIButton = UIButton()
        leftButton.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        let img = UIImage(named: "place_hold_b")
        leftButton.setImage(img, for: UIControlState())
      //  viewC.addSubview(leftButton)
        
        
        
        
       // var latitudeStr : (NSString) = (array .valueForKey("latitude") as? String)!
       // var longitudeStr : (NSString) = (array.valueForKey("longitude") as? String)!
//        var meetingName : (NSString) = (array.valueForKey("meeting_name") as? String)!
//        var meetingaddress1 : (NSString) = (array.valueForKey("address1") as? String)!
//        var meetingdistance : (NSString) = (array.valueForKey("distance")as? String)!
//        var meeting_date_time : (NSString) = (array.valueForKey("meeting_date_time") as? String)!
//        
//        var namelbl: UILabel = UILabel()
//        namelbl.frame = CGRectMake(CGRectGetMinX(leftButton.frame) + 5, CGRectGetMinY(leftButton.frame) , leftButton.frame.size.width - 10, leftButton.frame.size.height - 10)
//        //namelbl.text = id as String
//        namelbl.font = UIFont.systemFontOfSize(12)
//        leftButton.addSubview(namelbl)
//        
//        var title: UILabel = UILabel()
//        title.frame = CGRectMake(CGRectGetMaxX(leftButton.frame) + 10, 5, 200, 15)
//        title.text = meetingName as String
//        title.font = UIFont.systemFontOfSize(14)
//        title.textColor = UIColor.whiteColor()
//        viewC.addSubview(title)
//        
//        var address: UILabel = UILabel()
//        address.frame = CGRectMake(CGRectGetMaxX(leftButton.frame) + 10, CGRectGetMaxY(title.frame) + 5, 170, 15)
//        address.text = meetingaddress1 as String
//        address.font = UIFont.systemFontOfSize(8)
//        address.textColor = UIColor.whiteColor()
//        viewC.addSubview(address)
//        
//        var distanceLabel: UILabel = UILabel()
//        distanceLabel.frame = CGRectMake(CGRectGetMaxX(leftButton.frame) + 10, CGRectGetMaxY(address.frame) + 5, 170, 15)
//        distanceLabel.text = meetingdistance as String
//        distanceLabel.font = UIFont.systemFontOfSize(10)
//        distanceLabel.textColor = UIColor.whiteColor()
//        viewC.addSubview(distanceLabel)
        meetingMapview.addAnnotation(annotation)


       }
   

    }
    
    
    
    
    
    
    


//-(void)addPinWithTitle:(NSString *)title AndCoordinate:(NSString *)strCoordinate
//{
//    MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
//    
//    // clear out any white space
//    strCoordinate = [strCoordinate stringByReplacingOccurrencesOfString:@" " withString:@""];
//    
//    // convert string into actual latitude and longitude values
//    NSArray *components = [strCoordinate componentsSeparatedByString:@","];
//    
//    double latitude = [components[0] doubleValue];
//    double longitude = [components[1] doubleValue];
//    
//    // setup the map pin with all data and add to map view
//    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
//    
//    mapPin.title = title;
//    mapPin.coordinate = coordinate;
//    
//    [self.mapView addAnnotation:mapPin];
//}










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
            imgAnnotation?.canShowCallout = false
            viewC.isHidden = false
        }
        else {
            imgAnnotation?.annotation = annotation
            //println("Else")
        }
        
        return imgAnnotation
    }
 
    
    func mapView(_ mapView: MKMapView!, didSelect view: MKAnnotationView!) {
        var selected : MKAnnotation = MKPointAnnotation()
         selected = view.annotation!
       //println() selected.coordinate
    
       // println(selected.coordinate.latitude , selected.coordinate.longitude , "selected" )
        
        
        let LA = NSString(format: "%f", selected.coordinate.latitude)
        let LO = NSString(format: "%f", selected.coordinate.longitude)

        
        
        var array : (NSArray)
        let predicate = NSPredicate(format: "latitude contains %@ AND longitude contains %@", LA,LO)
        
        array =  [finalArray .filtered(using: predicate)]
        
        var arr : (NSArray) = NSArray()
        arr  = array.object(at: 0) as! (NSArray)
        
       // println(array)
        
        
        if(arr.count > 0)
        {
        viewC.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        viewC.center=view.center
       // viewC.backgroundColor = UIColor(red: 49 / 255, green: 91 / 255, blue: 149 / 255, alpha: 1)
        viewC.frame = CGRect(x: viewC.center.x - 180, y: viewC.center.y-130, width: 200, height: 130)
        meetingMapview.addSubview(viewC)
        
        
        
        
        let imageView : (UIImageView) = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        imageView.image = UIImage(named: "map-back.png")
        viewC.addSubview(imageView)
        
        
        
       
        
        
        let dictValues  : (NSDictionary) = arr.object(at: 0) as! NSDictionary
        let meetingName : (NSString) = dictValues.object(forKey: "meeting_name") as! (NSString)
        let meetingaddress1 : (NSString) = dictValues.object(forKey: "address1") as! (NSString)
        let meetingdistance : (NSString) = dictValues.object(forKey: "distance") as! (NSString)
        let meeting_date_time : (NSString) = dictValues.object(forKey: "meeting_date_time") as! (NSString)
//        _ :  (NSString) = dictValues.object(forKey: "meeting_date_time") as! (NSString)
        
        
        let leftButton : UIButton = UIButton()
        leftButton.frame = CGRect(x: 5, y: 5, width: 35, height: 35)
        let img = UIImage(named: "place_hold_b")
        leftButton.setImage(img, for: UIControlState())
        viewC.addSubview(leftButton)
        
        let namelbl: UILabel = UILabel()
        namelbl.frame = CGRect(x: leftButton.frame.minX + 5, y: leftButton.frame.minY , width: leftButton.frame.size.width - 10, height: leftButton.frame.size.height - 10)
        //namelbl.text = id as String
        namelbl.font = UIFont.systemFont(ofSize: 12)
        leftButton.addSubview(namelbl)
        
        let title: UILabel = UILabel()
        title.frame = CGRect(x: leftButton.frame.maxX + 5, y: 5, width: 200, height: 15)
        title.text = meetingName as String
        title.font = UIFont.systemFont(ofSize: 14)
        title.textColor = UIColor.white
        viewC.addSubview(title)
        
        let address: UILabel = UILabel()
        address.numberOfLines = 0
        address.frame = CGRect(x: leftButton.frame.maxX + 5, y: title.frame.maxY + 5, width: 150, height: 20)
        address.text = meetingaddress1 as String
        address.font = UIFont.systemFont(ofSize: 8)
        address.textColor = UIColor.white
        viewC.addSubview(address)
        
        let distanceLabel: UILabel = UILabel()
        distanceLabel.frame = CGRect(x: leftButton.frame.maxX + 5, y: address.frame.maxY + 5, width: 170, height: 15)
        distanceLabel.text = NSString(format: "Distance- %@", meetingdistance) as String
        distanceLabel.font = UIFont.systemFont(ofSize: 10)
        distanceLabel.textColor = UIColor.white
        viewC.addSubview(distanceLabel)
        
        
        
        
        
        
        
        let timingsLabel: UILabel = UILabel()
        timingsLabel.frame = CGRect(x: leftButton.frame.maxX + 5, y: distanceLabel.frame.maxY + 5, width: 170, height: 15)
        let timeStr = NSString(format: "Timings - %@", meeting_date_time)
        timingsLabel.text = timeStr as String
        timingsLabel.font = UIFont.systemFont(ofSize: 10)
        timingsLabel.textColor = UIColor.white
        viewC.addSubview(timingsLabel)
        
        
        meetingMapview.addAnnotation(annotation)
        }

        
        
        
        
        
        
        
        //viewC.center = CGPointMake(-70, -50)
        
        
        
        
        
        
       
        
       // viewC.backgroundColor =
//        viewC.frame = CGRectMake(0, 0, 200, 100)
//        viewC.backgroundColor = UIColor(red: 49 / 255, green: 91 / 255, blue: 149 / 255, alpha: 1)
//        
//        view.addSubview(viewC)
//        viewC.center = CGPointMake(-70, -50)
    }
    
    
    
    func customView(_ viewFrame : CGRect)
    {
  
    }
    
    
    
    
    

    
  
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // println("array count is %d",finalArray.count)

        return finalArray.count
        
    }
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         var findmeeting : (NSArray) = NSArray()
        
        let contentCell : TableViewCell = tableView.dequeueReusableCell(withIdentifier: contentCellIdentifier, for: indexPath) as! TableViewCell
       
         findmeeting  = finalArray as NSArray

        let dictValues : (NSDictionary) = findmeeting.object(at: indexPath.row) as! (NSDictionary)
        
        let program_name_Text = dictValues.object(forKey: "program_name") as! (NSString)
        let meetingName = dictValues.object(forKey: "meeting_name") as! (NSString)
        //var meetingLocation = findmeeting.valueForKey("location")?.objectAtIndex(indexPath.row)  as? String
        let meetingdistance : (NSString) = dictValues.object(forKey: "distance") as! (NSString)
        let meeting_date_time : (NSString) = dictValues.object(forKey: "meeting_date_time") as! (NSString)
        let meetingaddress1 : (NSString) = dictValues.object(forKey: "address1") as! (NSString)
      
        if listSelected == 1 {
            
            itemsArr  = items as NSArray!
            contentCell.program_name.text = program_name_Text as String
            contentCell.toplabel.text = meetingName as String
            contentCell.nextButtomlabel.text = meetingaddress1 as String
            contentCell.rightsecondLabel.text = "Direction"
            contentCell.secondLastLabel.text = "Distance - \(meetingdistance)"
            contentCell.lastLable.text  = "Attendees"
            contentCell.rightTopLabel.text = meeting_date_time as String
            //contentCell.leftimage.image = UIImage(named: "add_meeting")
            contentCell.directionImage.image = UIImage(named: "direction_icon")
            contentCell.leftsmallImage.image = UIImage(named: "user")
            
            
            if (indexPath as NSIndexPath).row % 2 != 0 {
                contentCell.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                contentCell.leftView.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
                contentCell.placeHolderImg.image = UIImage(named: "place_hold_b")
                
            } else {
                contentCell.backgroundColor = UIColor.white
                contentCell.leftView.backgroundColor = UIColor.white
                contentCell.placeHolderImg.image = UIImage(named: "place_hold_a")
                
            }
        }
       
        return contentCell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailMeeting : (MeetingDetailViewController) = MeetingDetailViewController()
       
        detailMeeting.detailArray   = finalArray.object(at: (indexPath as NSIndexPath).row) as! (NSDictionary)
        self.navigationController?.pushViewController(detailMeeting, animated: false)
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 92.0
    }
    
    
    func MapViewGesture(_ gesture : UITapGestureRecognizer)
    {
        viewC.removeFromSuperview()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        
        
        
        
        
        
        return true
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textView.resignFirstResponder()
        
        return true
    }


}
