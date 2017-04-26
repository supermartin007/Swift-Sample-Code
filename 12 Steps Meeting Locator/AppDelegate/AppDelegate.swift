

//
//  AppDelegate.swift
//  12 Steps Meeting Locator
//
//  Created by iapp on 01/05/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
import UserNotifications

let PRODUCTID = "com.12StepLocator.YearlySubscription"
//let PRODUCTID = "com.hypnosis.hypnosisApp.consumableSingleStream"
var latdelta = CLLocationDegrees()
var londelta = CLLocationDegrees()
var annotation = MKPointAnnotation()
var mapview : MKMapView = MKMapView()



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate,inAppProductsDelegate,UNUserNotificationCenterDelegate
{
    
    var timerAttendMetting:(Timer)!
    var meetingIdAttendMetting = ""
    var attendanceIdAttendMetting = ""
    
    var timer = Timer()
    var window: UIWindow?
    var objNavigationConrtoller:UINavigationController?
    var objRootViewController:UIViewController?
    var currentUser : Bool?
    let locationManager = CLLocationManager()
    var latdelta = CLLocationDegrees()
    var londelta = CLLocationDegrees()
    var annotation = MKPointAnnotation()
    var inAppProducts: (inAppClass)!
   // var inapp : (inAppPurchase)!
    var productArray : NSMutableArray = NSMutableArray()
    var request : (URLRequest)!
    var operationQueue : (OperationQueue)!
   // var viewDelagate  : resignMethods!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        window = UIWindow(frame:  UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        if((UserDefaults.standard.object(forKey: "StepUserData")) != nil)
        {
            currentUser = true
        }
        else
        {
            //println("Hello")
            currentUser = nil
        }
        //currentUser = true
        if((currentUser) != nil)
        {
          objRootViewController = FirstViewController(nibName: nil, bundle: nil)
          self.callMethod(objRootViewController!)
        }
        else
        {
            objRootViewController = ViewController(nibName: nil, bundle: nil)
            objNavigationConrtoller = UINavigationController(rootViewController: objRootViewController!)
            window?.rootViewController = objNavigationConrtoller
        }
        mapview.delegate = self
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.distanceFilter=kCLDistanceFilterNone;
        self.inAppPurchase()
        FBSDKLoginButton();
        FBSDKProfile()
        
        switch UIDevice.current.systemVersion.compare("8.0.0", options: NSString.CompareOptions.numeric) {
        case .orderedSame, .orderedDescending:
            
            if #available(iOS 8.0, *) {
                self.locationManager.requestWhenInUseAuthorization()
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 8.0, *) {
                self.locationManager.requestAlwaysAuthorization()
            } else {
                // Fallback on earlier versions
            }
            self.locationManager.startUpdatingLocation()
            print(self.locationManager)
            break
        default:
            break
            
        }
        if #available(iOS 10.0, *){
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: {(granted, error) in
                if (granted)
                {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                else{
                    //Do stuff if unsuccessful...
                }
            })
        }
            
        else{ //If user is not on iOS 10 use the old methods we've been using
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            
        }
        
//        case .orderedAscending:
//           // println("iOS < 8.0")
//            self.locationManager.startUpdatingLocation()
//            
//             UIApplication.shared.registerForRemoteNotificationTypes(.Badge | .Sound | .Alert)
//        }

        
        let user : (SMLAppUser) = SMLAppUser.getUser()
       if(user.userId .isEqual(to: ""))
       {
        
        }
        else
       {
        self.sendCurrentLocation()
        }
        UIApplication.shared.applicationIconBadgeNumber = 0

        window?.makeKeyAndVisible()
        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func callMethod(_ view : UIViewController)
    {
        let  panelController =  JASidePanelController()
        panelController.shouldDelegateAutorotateToVisiblePanel = false;
        panelController.leftPanel = SideMenuViewController()
        objRootViewController = UINavigationController(rootViewController: view)
        panelController.centerPanel = objRootViewController
        // self.viewController.centerPanel = [[JALeftViewController alloc]init];
        window?.rootViewController = panelController;
    }
    func callMethodGoParticuler(_ view : UIViewController)
    {
        let  panelController =  JASidePanelController()
        panelController.shouldDelegateAutorotateToVisiblePanel = false;
        panelController.leftPanel = SideMenuViewController()
        objRootViewController = UINavigationController(rootViewController: view)
        panelController.centerPanel = objRootViewController
        // self.viewController.centerPanel = [[JALeftViewController alloc]init];
        window?.rootViewController = panelController;
    }
   

    
    
    func application(_ application: UIApplication,
        open url: URL,
        sourceApplication: String?,
        annotation: Any) -> Bool {
            
        //return  FBAppCall.handleOpenURL(url, sourceApplication: sourceApplication, fallbackHandler: nil)
            return FBSDKApplicationDelegate.sharedInstance().application(
                application,
                open: url,
                sourceApplication: sourceApplication,
                annotation: annotation)
    }
    
    
    
    
    
   //MARK:- In-App Purchase
   func inAppPurchase()
   {
    inAppProducts = inAppClass.sharedInstance()
    inAppProducts .initialize()
    inAppProducts.delegate = self
    
    if(self.inAppProducts.products == nil)
    {
        self.inAppProducts.requestProducts(completionHandler: { (sucess : Bool, products) -> Void in
          
             var arr : (NSArray)
            if(sucess)
            {
              arr = products as! NSArray
                
                self.productArray = NSMutableArray()
                self.productArray = NSMutableArray(array: arr)
                
                if(arr.count > 0)
                {
                    
                }
                else
                {
                    SMLGlobal.sharedInstance.displayAlertMessage((self.window?.rootViewController)!, "Please wait while product is loaded", title: "")
                }
            }
        
       })
    }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            self.latdelta = 1
            self.londelta = 1
            let locValue:CLLocationCoordinate2D = manager.location!.coordinate
            //println("locations = \(locValue.latitude) \(locValue.longitude)")
            
            
            let span:MKCoordinateSpan = MKCoordinateSpanMake(self.latdelta, self.londelta)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude )
            let resion:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            mapview.setRegion(resion, animated: true)
            self.annotation.coordinate = location
            self.latdelta = location.latitude
            self.londelta = location.longitude
            let  latitudeStr : (NSString) = NSString(format: "%f", location.latitude)
            let longitudeStr : (NSString) =  NSString(format: "%f", location.longitude)
            //        var latitudeStr : (NSString) = (array .valueForKey("latitude")?.objectAtIndex(i) as? String)!
            //        var longitudeStr : (NSString) = (array.valueForKey("longitude")?.objectAtIndex(i) as? String)!
            
//            let MomentaryLatitude = latitudeStr.doubleValue
//            let MomentaryLongitude = longitudeStr.doubleValue
//            var latitude: (CLLocationDegrees)  = MomentaryLatitude
//            var longitude: (CLLocationDegrees)  = MomentaryLongitude
            let dictValue : (NSDictionary) = ["longitude" : longitudeStr,
                                                "latitude" : latitudeStr]
            UserDefaults.standard.set(dictValue, forKey: "Location")
            UserDefaults.standard.synchronize()
//
//            if placemarks.count > 0 {
//                let pm = placemarks[0] as! CLPlacemark
//                self.displayLocationInfo(pm)
//            } else {
//                println("Problem with the data received from geocoder")
//            }
            mapview.addAnnotation(self.annotation)
        })
    }
    private func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == CLAuthorizationStatus.authorizedWhenInUse
        {
            self.locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
           // locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            
            annotation.title = locality
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
    


    func applicationWillResignActive(_ application: UIApplication)
    {
       isForgotValue = 0
    }

    func applicationDidEnterBackground(_ application: UIApplication)
    {
        
      isForgotValue = 0
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication)
    {
          isForgotValue = 0
    }

    func applicationDidBecomeActive(_ application: UIApplication)
    {
         isForgotValue = 0
        
         FBSDKAppEvents.activateApp()
        
        switch UIDevice.current.systemVersion.compare("8.0.0", options: NSString.CompareOptions.numeric) {
        case .orderedSame, .orderedDescending:
           // println("iOS >= 8.0")
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.requestAlwaysAuthorization()
        case .orderedAscending:
           // println("iOS < 8.0")
            self.locationManager.startUpdatingLocation()
        }
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(timeForsendLatlong), userInfo: nil, repeats: true)
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication)
    {
        var managedContext : (NSManagedObjectContext)!
        if #available(iOS 10.0, *) {
            managedContext = self.managedObjectContext!
        } else {
            // Fallback on earlier versions
        }
        
        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"MeetingFinder")
        
        //3
        //var error: NSError?
        
        //        let fetchedResults =
        //        managedObjectContext.executeFetchRequest(fetchRequest,
        //            error: &error) as? [NSManagedObject]
        //        var array = NSArray()
        
        
        if let fetchResults = try? managedContext!.fetch(fetchRequest)
        {
            print(fetchResults)
        }
        self.saveContext()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    
    
    
    class  func sharedInstance() -> AppDelegate {
        let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate
    }
    
    
    
    
    
    
    // MARK: - Core Data stack
    
    lazy var applicationDocumentsDirectory: URL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.razeware.HitList" in the application's documents Application Support directory.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(urls[urls.count-1])
        return urls[urls.count-1] 
        }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = Bundle.main.url(forResource: "meetingFinder", withExtension: "momd")!
        //println(modelURL)
        return NSManagedObjectModel(contentsOf: modelURL)!
        
        }()
    
    @available(iOS 10.0, *)
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("meetingFinder.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        
        
        
        let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
 
        //Create New Cntainer
        let container = NSPersistentContainer(name: "meetingFinder")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
        if let error = error {
 
        }
 
 
        })
 
        do {
            try coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch var error1 as NSError {
            error = error1
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        } catch {
            fatalError()
        }
        
        return coordinator
    }()
       /* let description = NSPersistentStoreDescription()
        description.shouldInferMappingModelAutomatically = true
        description.shouldMigrateStoreAutomatically = true
        
        //Create New Cntainer
        let container = NSPersistentContainer(name: "meetingFinder")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                
            }
            
            
        })
        
      //  if coordinator?.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: "", at: url, options: nil){
        if coordinator!.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
           // NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
        }()*/
    
    @available(iOS 10.0, *)
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        if #available(iOS 10.0, *) {
            if let moc = self.managedObjectContext {
                var error: NSError? = nil
                if moc.hasChanges {
                    do {
                        try moc.save()
                    } catch let error1 as NSError {
                        error = error1
                        // Replace this implementation with code to handle the error appropriately.
                        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                        NSLog("Unresolved error \(error), \(error!.userInfo)")
                        abort()
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }

        /*if #available(iOS 10.0, *) {
            if let moc = self.managedObjectContext {
                var error: NSError? = nil
                do
                {
//                try moc.hasChanges && !moc.save(){
//                    // Replace this implementation with code to handle the error appropriately.
//                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                    // NSLog("Unresolved error \(error), \(error!.userInfo)")
//                    abort()
//                }
//                }
//                catch
//                {
//                    
//                }
            }
        } else {
            // Fallback on earlier versions
        }
    }*/
    }
    
    //MARK:- Push Notifications Methods
    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
       // println(deviceToken)
//        let deviceTokenString: String = ( deviceToken.description as NSString )
//            .trimmingCharacters( in: characterSet )
//            .replacingOccurrences( of: " ", with: "" ) as String
//        //var token : (NSString) = NSString(format: "%@", deviceToken)
//         print(deviceTokenString)
        
        var deviceTokenString: String = ""
        for i in 0..<deviceToken.count {
            deviceTokenString += String(format: "%02.2hhx", deviceToken[i] as CVarArg)
        }
        

        UserDefaults.standard.set(deviceTokenString, forKey: "DeviceToken")
        UserDefaults.standard.synchronize()
        let userInfo : (SMLAppUser) = SMLAppUser.getUser()
        let userId : (NSString) = userInfo.userId
        
        if(userId == "")
        {
        }
        else
        {
           self.getDeviceToken(deviceTokenString as NSString, loginId: userId)
        }
        
       // getDeviceToken(
        //send this device token to server
    }
    
    //Called if unable to register for APNS.
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        
        //println(error)
        
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, willPresentNotification notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        //Handle the notification
    }
    
    @available(iOS 10.0, *)
    func userNotificationCenter(center: UNUserNotificationCenter, didReceiveNotificationResponse response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //Handle the notification
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    {
        var alertMsgCompare = "" as! NSString
        var alertMsg = "" as! NSString
        var temp : NSDictionary = userInfo as NSDictionary
        if let info = userInfo["aps"] as? Dictionary<String, AnyObject>
        {
            print(info)
            temp = info as NSDictionary
            alertMsg = info["alert"] as! String as NSString
            if info.keys.contains("day")
            {
            alertMsgCompare = info["day"] as! NSString //dict.allKeys
            }
        }
    
        if(UIApplication.shared.applicationState == UIApplicationState.active)
        {
            if alertMsgCompare.isEqual(to:"mettingAfter_5min")
            {
                let alertController = UIAlertController(
                    title: "",
                    message: alertMsg as String,
                    preferredStyle: UIAlertControllerStyle.alert
                )
                
                let cancelAction = UIAlertAction(
                    title: "Continue",
                    style: UIAlertActionStyle.destructive) { (action) in
                        
                        
                        var mettingId = "" as! NSString

                            mettingId = temp["meetingId"] as! NSString //dict.allKeys
                        print(mettingId)

                        let findMeeting : meetingFinderViewController = meetingFinderViewController(nibName: nil, bundle: nil)
                        findMeeting.openListSegment = true
                        findMeeting.mettingIdBefore5 = mettingId
                        

                        self.callMethodGoParticuler(findMeeting)
                        // ...
                }
                
                let confirmAction = UIAlertAction(
                title: "OK", style: UIAlertActionStyle.default) { (action) in
                    // ...
                }
                
                alertController.addAction(confirmAction)
                alertController.addAction(cancelAction)
                
                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                
            }

            
        else
         {
            
        let alertController : UIAlertController = UIAlertController.init(title: "", message: alertMsg as String, preferredStyle: UIAlertControllerStyle.alert)
        self.window?.rootViewController?.present(alertController, animated: true, completion: nil)



        let okAlert : (UIAlertAction) = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in
            
            
            if alertMsgCompare.isEqual(to:"another day")
            {

            }
            else  if alertMsgCompare.isEqual(to:"same day")
            {
                let findMeeting : meetingFinderViewController = meetingFinderViewController(nibName: nil, bundle: nil)
                findMeeting.openListSegment = true

                self.callMethodGoParticuler(findMeeting)

            }
                
            else
            {
                let findMeeting : meetingFinderViewController = meetingFinderViewController(nibName: nil, bundle: nil)
                findMeeting.openListSegment = true
                self.callMethodGoParticuler(findMeeting)
            }
            })
        alertController .addAction(okAlert)
        
         }
        }
        else
        {
            if alertMsgCompare.isEqual(to:"mettingAfter_5min")
            {
                let alertController = UIAlertController(
                    title: "",
                    message: alertMsgCompare as String,
                    preferredStyle: UIAlertControllerStyle.alert
                )
                
                let cancelAction = UIAlertAction(
                    title: "Continue",
                    style: UIAlertActionStyle.destructive) { (action) in
                        var mettingId = "" as! NSString
                        
                        mettingId = temp["meetingId"] as! NSString //dict.allKeys
                        print(mettingId)
                        let findMeeting : meetingFinderViewController = meetingFinderViewController(nibName: nil, bundle: nil)
                        findMeeting.openListSegment  = true
                        findMeeting.mettingIdBefore5 = mettingId
                        self.callMethodGoParticuler(findMeeting)
                        // ...
                }
                
                let confirmAction = UIAlertAction(
                title: "OK", style: UIAlertActionStyle.default) { (action) in
                    // ...
                }
                
                alertController.addAction(confirmAction)
                alertController.addAction(cancelAction)
                
                self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                
            }

            
            else
            {

            if alertMsgCompare.isEqual(to: "another day")
            {
                
            }
            else  if alertMsgCompare.isEqual(to: "same day")
            {
                let findMeeting : meetingFinderViewController = meetingFinderViewController(nibName: nil, bundle: nil)
                findMeeting.openListSegment = true
                self.callMethodGoParticuler(findMeeting)
                
            }
            else
            {
                let findMeeting : meetingFinderViewController = meetingFinderViewController(nibName: nil, bundle: nil)
                findMeeting.openListSegment = true
                self.callMethodGoParticuler(findMeeting)
            }
            
            
        }
        }

    }
    
    
    func getDeviceToken(_ token : NSString , loginId : NSString)
    {
     // http://112.196.34.179/stepslocator/index.php/login/wsAddUserDeviceToken?user_id=2&device_id=fdsfdst4t5Fdsgfdg
 
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
        let deviceToken : (NSString) = UserDefaults.standard.object(forKey: "DeviceToken") as! NSString
        let urlStr = NSString(format: "%@wsAddUserDeviceToken?user_id=%@&device_id=%@", serverUrl,loginId,deviceToken)
        let url : (URL) = URL(string: urlStr as String)!
        

       // var data :(NSData) = NSData(contentsOfURL: url)!
        let request : (URLRequest) = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 60*5)
        let operationQueue = OperationQueue()
    
        NSURLConnection.sendAsynchronousRequest(request, queue: operationQueue, completionHandler:{ (response, data, error) -> Void in
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    print("ASynchronous\(jsonResult)")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }

        })
        }
        else
        {
        }
    }
    func upgradeRole()
    {
        let userInfo : (SMLAppUser) = SMLAppUser.getUser()
        let userId : (NSString) = userInfo.userId
        let urlStr = NSString(format: "%@wsUserPaymentRole?userId=%@", serverUrl,userId)
        let url = NSURL(string: urlStr as String)
        let request = NSURLRequest(url: url as! URL)
        
        
        NSURLConnection.sendAsynchronousRequest(request as URLRequest, queue: OperationQueue.main) {(response, data, error) in
            
            do {
                var jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject] as (AnyObject)
                // parse JSON
                
            } catch {
                print(error)
            }
            
        }

        
    }
    func sendCurrentLocation()
    {
        
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
       
      // http://112.196.34.179/stepslocator/index.php/login/wsSaveUserLatLong?user_id=2&latitude=30.6792824000&longitude=76.7293233000&status=1
        let userInfo : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = userInfo.userId
        let pushStatus : (NSString) = "1"

        let userDefaults : UserDefaults = UserDefaults.standard
        
        var latStr: (NSString) = NSString()
        var longStr : (NSString) = NSString()
        
        
        if (userDefaults.object(forKey: "Location") != nil)
        {
            
            let dict : (NSDictionary) = UserDefaults.standard.object(forKey: "Location") as! NSDictionary
            latStr = dict.value(forKey: "latitude") as! String as (NSString)
            longStr = dict.value(forKey: "longitude") as! String as (NSString)
        }
        
        
        
        
        var latitude : (CLLocationDegrees) = latStr.doubleValue
        var longitude : (CLLocationDegrees) = longStr.doubleValue
        
        if(loginId == "")
        {
            return
        }
        
        let urlStr : (NSString) = NSString(format: "%@wsSaveUserLatLong?user_id=%@&latitude=%@&longitude=%@&status=%@",serverUrl,loginId,latStr,longStr,pushStatus)
        
//        var urlStr = NSString(format: "http://112.196.34.179/stepslocator/index.php/login/wsSaveUserLatLong?user_id=%@&latitude=%@&longitude=%@&status=%@",loginId,latitude,longitude,pushStatus)
        let url : (URL) = URL(string: urlStr as String)!
        
        // var data :(NSData) = NSData(contentsOfURL: url)!
        let request : (URLRequest) = URLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData, timeoutInterval: 60*5)
        let operationQueue = OperationQueue()
        

        
      
        NSURLConnection.sendAsynchronousRequest(request, queue: operationQueue, completionHandler:{ (response, data, error) -> Void in
            
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary {
                    print("ASynchronous\(jsonResult)")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            
        })

    }
    else
    {
    }
    }
    func timeForsendLatlong()
    {
        let user : (SMLAppUser) = SMLAppUser.getUser()
        if(user.userId .isEqual(to: ""))
        {
            
        }
        else
        {
            self.sendCurrentLocation()
        }
    }
    
  // Meeting Attent webservice
    
    
    func timerFired()
    {
       var currMin : (Int)!
        let currentDate : (Date) = Date()
        if((UserDefaults.standard.object(forKey: "Timer")) != nil)
        {
            ////////// edit by tijender
            let jsonArray = UserDefaults.standard.object(forKey: "Timer") as! NSArray
            let previousArray : NSMutableArray = jsonArray.mutableCopy() as! NSMutableArray
               // let previousArray : NSMutableArray = UserDefaults.standard.object(forKey: "Timer") as! NSMutableArray
            
            
                let predicate : (NSPredicate) = NSPredicate(format: "self.MeetingID == %@", AppDelegate.sharedInstance().meetingIdAttendMetting)
                let arr : (NSArray) = previousArray.filtered(using: predicate) as (NSArray)
                if(arr.count != 0)
                {
                    let dict : (NSDictionary) = arr.object(at: 0) as! (NSDictionary)
                    // arr = arr.objectAtIndex(0) as! (NSArray)
                    let previousTime: (Date) = dict.object(forKey: "CurrentTime") as! Date
                    print(previousTime)
                    print(currentDate)


                    var com : (DateComponents) = Constants.myGlobalFunction.dateDifference(previousTime, toDate: currentDate)
                    let totalMIn : (Int) = com.minute!
                    print(totalMIn)
                    //Rajni Change Time 55 minutes to 1 minute
                    // chnageddddddd
                    currMin = 55 - totalMIn
                    if(currMin <= 0)
                    {
                      AppDelegate.sharedInstance().timerAttendMetting.invalidate()
                    //   UIAlertView(title: "", message: "Meeting approved by user", delegate: nil, cancelButtonTitle: "OK").show()
                     Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.attendiesApproveWebservice), userInfo: nil, repeats: false)
                    }
            }
        }
 
    }

    
    func attendiesApproveWebservice() // tijender
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
            
            SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
            
            //http://104.236.197.214/index.php/login/wsmeetingAttendedApproved?attendance_id=27
            
            //             let myNumber =  NSNumber.init( value: Int32("AppDelegate.sharedInstance().attendanceIdAttendMetting")!)

            
            // edit by tijender
            let userInfo : (SMLAppUser) = SMLAppUser.getUser()
            let userId : (NSString) = userInfo.userId
            
            let parameters : (NSDictionary) = ["attendance_id" : AppDelegate.sharedInstance().attendanceIdAttendMetting,"user_id":userId]
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
                        //self.start()
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
         //   SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }
    

    
}

