//
//  directionViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 21/07/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
var dirMapView : MKMapView!

class directionViewController: UIViewController, MKMapViewDelegate,CLLocationManagerDelegate{
 var detailArray : (NSDictionary) = NSDictionary()
    var location:CLLocationCoordinate2D!
    var latdelta = CLLocationDegrees()
    var londelta = CLLocationDegrees()
    var annotation = MKPointAnnotation()
    let locationManager = CLLocationManager()
    var resion:MKCoordinateRegion!
     var mapManager = MapManager()
     var currentlocation:CLLocationCoordinate2D!

    override func viewDidLoad() {
        super.viewDidLoad()
          self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor.white

        let navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        navigationView.backgroundColor = UIColor(red: 31.0/255.0, green:134/255, blue: 209.0/255.0, alpha: 1.0)
        self.view.addSubview(navigationView)
        
        let backBtn = UIButton.init(type: UIButtonType.custom)
        let image = UIImage(named: "back_errow")
        backBtn.addTarget(self, action: #selector(directionViewController.backBtnAction(_:)), for: UIControlEvents.touchUpInside)
        backBtn.frame = CGRect(x: 10,y: 25, width: 30, height: 30)
        backBtn.setImage(image, for: UIControlState())
        navigationView.addSubview(backBtn)
        
        
        let titleLabel = UILabel()
        titleLabel.frame=CGRect(x: 30,y: 32, width: navigationView.frame.size.width-50, height: 20)
        titleLabel.text = "Direction"
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        navigationView.addSubview(titleLabel)
        
        SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
        dirMapView  = MKMapView()
        dirMapView.frame = CGRect(x: 0, y: navigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height)
        dirMapView.delegate = self

        
        self.removeAllPlacemarkFromMap(shouldRemoveUserLocation: true)
        self.displayAnnotations()
        self.directionDraw()

        
        
      
       // self.locationManager.delegate = self
       // self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
       // self.locationManager.requestWhenInUseAuthorization()
       // self.locationManager.startUpdatingLocation()
       // self.displayAnnotations()
        


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func locationManager(_ manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
              self.latdelta = 0.01
              self.londelta = 0.01
                let locValue:CLLocationCoordinate2D = manager.location!.coordinate
                // println("locations = \(locValue.latitude) \(locValue.longitude)")
                
            
                let span:MKCoordinateSpan = MKCoordinateSpanMake(self.latdelta, self.londelta)
                 self.currentlocation = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude )
                let resion:MKCoordinateRegion = MKCoordinateRegionMake(self.currentlocation, span)
            
            
                
                
              dirMapView.setRegion(resion, animated: true)
                
                self.annotation.coordinate = self.currentlocation
                
             self.latdelta = self.currentlocation.latitude
               self.londelta = self.currentlocation.longitude
                
                
                
                
                
            
            if (placemarks?.count)! > 0 {
                let pm = (placemarks?[0])! as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
               // println("Problem with the data received from geocoder")
            }
            
            
            
            dirMapView.addAnnotation(self.annotation)
            
           
            
        })
    }
    
    func directionDraw() {
        self.view.endEditing(true)
        
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
            latStr  = "30.6793";
            longStr = "76.7293"
        }
        let latitude : (CLLocationDegrees) = latStr.doubleValue
        let longitude : (CLLocationDegrees) = longStr.doubleValue
        
        
        
        self.currentlocation = CLLocationCoordinate2DMake(latitude, longitude)
      
        print(self.currentlocation)
        print(location)
        
        
        mapManager.directionsUsingGoogle(from: self.currentlocation!, location!) { (route,directionInformation, boundingRegion, error) -> () in
            
            if(error != nil){
                
                print("error")
                
                
            }else{
                
                let pointOfOrigin = MKPointAnnotation()
                pointOfOrigin.coordinate = route!.coordinate
                pointOfOrigin.title = directionInformation?.object(forKey: "start_address") as! NSString as String
                pointOfOrigin.subtitle = directionInformation?.object(forKey: "duration") as! NSString as String
                
                let pointOfDestination = MKPointAnnotation()
                pointOfDestination.coordinate = route!.coordinate
                pointOfDestination.title = directionInformation?.object(forKey: "end_address") as! NSString as String
                pointOfDestination.subtitle = directionInformation?.object(forKey: "distance") as! NSString as String
                
                let start_location = directionInformation?.object(forKey: "start_location") as! NSDictionary
                let originLat = (start_location.object(forKey: "lat") as AnyObject).doubleValue
                let originLng = (start_location.object(forKey: "lng") as AnyObject).doubleValue
                
                let end_location = directionInformation?.object(forKey: "end_location") as! NSDictionary
                let destLat = (end_location.object(forKey: "lat") as AnyObject).doubleValue
                let destLng = (end_location.object(forKey: "lng") as AnyObject).doubleValue
                
                let coordOrigin = CLLocationCoordinate2D(latitude: originLat!, longitude: originLng!)
                let coordDesitination = CLLocationCoordinate2D(latitude: destLat!, longitude: destLng!)
                
                pointOfOrigin.coordinate = coordOrigin
                pointOfDestination.coordinate = coordDesitination
                //if let web = dirMapView

                
                DispatchQueue.main.async {
                    self.removeAllPlacemarkFromMap(shouldRemoveUserLocation: true)
                    dirMapView.add(route!)
                    dirMapView.addAnnotation(pointOfOrigin)
                    dirMapView.addAnnotation(pointOfDestination)
                    dirMapView.setVisibleMapRect(boundingRegion!, animated: true)
                                   // }
//                    DispatchQueue.main.asynchronously() {
                

                        
                }
                
            }
        }
        
        

    }
    
    
    func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            annotation.title = locality
        }
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
        
        
        
        latdelta = 0.5
        londelta = 0.5
        //var locValue:CLLocationCoordinate2D = manager.location.coordinate
        //println("locations = \(locValue.latitude) \(locValue.longitude)")
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latdelta, londelta)
        location = CLLocationCoordinate2DMake(latitude,longitude )
        resion = MKCoordinateRegionMake(location, span)
        
        dirMapView.setRegion(resion, animated: true)
        annotation = MKPointAnnotation()
        annotation.coordinate = location
        
        latdelta = location.latitude
        londelta = location.longitude
        dirMapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView!, viewFor annotation: MKAnnotation!) -> MKAnnotationView! {
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
    


    func backBtnAction(_ sender: UIButton) {
        navigationController!.isNavigationBarHidden = true
      navigationController?.popViewController(animated: false)
        
    }
    
    
    func removeAllPlacemarkFromMap(shouldRemoveUserLocation:Bool){
        
        if let mapView = dirMapView {
            for annotation in mapView.annotations
            {
                if shouldRemoveUserLocation
                {
                    if annotation as? MKUserLocation !=  mapView.userLocation
                    {
                        let overlays = mapView.overlays
                        mapView.removeOverlays(overlays)
                        mapView.removeAnnotation(annotation)
                    }
                }
                
                
            }
            
        }
        
        
    }


    func mapView(_ mapView: MKMapView!, rendererFor overlay: MKOverlay!) -> MKOverlayRenderer! {
        SVProgressHUD .dismiss()
        if overlay is MKPolyline {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blue
            polylineRenderer.lineWidth = 2
            //println("done")
            //NSLog("Hello")
            
             self.view.addSubview(dirMapView)
//            latdelta = 0.2
//            londelta = 0.2
//            let span:MKCoordinateSpan =  MKCoordinateSpan(latitudeDelta: latdelta,longitudeDelta: londelta)
//            let locationNew:CLLocationCoordinate2D = self.currentlocation
//            let resion:MKCoordinateRegion = MKCoordinateRegionMake(locationNew, span)
//            dirMapView.setRegion(resion, animated: true)
            return polylineRenderer
        }
        
        
        return nil
    }


}
