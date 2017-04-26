//
//  SMLGlobal.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 01/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

private let singletonClass = SMLGlobal()

let NavigationColor = UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0)
let profnavigationColor = UIColor(red: 57.0/255.0, green:134/255, blue: 210.255, alpha: 1.0)
let ButtonBlueColor = UIColor(red: 0.0/255.0, green: 87.0/255.0, blue: 166.0/255.0, alpha: 1.0)
let ButtonRedColor = UIColor(red: 246.0/255.0, green: 79.0/255.0, blue: 85.0/255.0, alpha: 1.0)




class SMLGlobal: NSObject {
    
    
    
    
    class var sharedInstance: SMLGlobal {
    return singletonClass
    }
    
    
    
    func fontSize(_ fontSize:CGFloat) -> UIFont
    {
      return UIFont(name: "OpenSans", size:fontSize)!
    }
    func fontSizeBold(_ fontSize:CGFloat) -> UIFont
    {
        //
        return UIFont(name: "OpenSans-Bold", size:fontSize)!
    }
    
    func checkFirstCharacter(_ textString : NSString) -> Bool
    {
        
        
        let string = textString.substring(with: NSRange(location: 0,length: 1))
        if(string == " ")
        {
            return false;
        }
        return true
    }
    
    
    
    
    
    
    func getTodayDate(_ todayDate:NSString) -> (NSString)
    {
       // println(todayDate)
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let serverDate : (Date) = df .date(from: todayDate as String)!
        let currentDate : (Date) = Date()
                var timeStr = NSString()
        var com : (DateComponents) = Constants.myGlobalFunction.dateDifference(currentDate, toDate: serverDate)
       
        if(com.year != 0)
        {
            df.dateFormat = "dd-MM-yyyy hh:mm a"
            timeStr = df.string(from: serverDate) as NSString
            return timeStr
        }
        else if(com.month != 0)
        {
            df.dateFormat = "dd-MM-yyyy hh:mm a"
            timeStr = df.string(from: serverDate) as NSString
            return timeStr
        }
        else if(com.day != 0)
        {
            df.dateFormat = "dd-MM-yyyy hh:mm a"
            timeStr = df.string(from: serverDate) as NSString
            return timeStr
        }
        else if(com.hour != 0)
        {
                       
            df.dateFormat = "hh:mm a"
            timeStr = df.string(from: serverDate) as NSString
            return timeStr
        }
        else if(com.minute != 0)
        {
            
            df.dateFormat = "hh:mm a"
            timeStr = df.string(from: serverDate) as NSString
            print(timeStr)
            return timeStr

        }
        else if(com.second!>=0)
        {
            if(com.second==0)
            {
                
                timeStr = NSString(format: "1 sec ago")
            }
            else
            {
                timeStr = NSString(format: "%ld secs ago", com.second!)
                
            }
            return timeStr
        }
        else
        {
            
            return ""
            
        }
        
 
    }
    
    func displayAlertMessage(_ vc:UIViewController , _ message : NSString,title : NSString)
    {
        let alertController : (UIAlertController) = UIAlertController.init(title: title as String, message: message as String, preferredStyle: UIAlertControllerStyle.alert)
        vc .present(alertController, animated: true, completion: nil)
        
        let okAction : (UIAlertAction) = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default) { (action) in
            
        }
        alertController.addAction(okAction)
    }
    func NOINTERNETALERT(_ vc:UIViewController)
    {
        let alert = UIAlertController.init(title: "Alert", message: "Please check your internet connection.It might be slow or disconnected", preferredStyle: UIAlertControllerStyle.alert)
        vc.present(alert, animated: true, completion: nil)
        let okAction : (UIAlertAction) = UIAlertAction.init(title: "OK", style: UIAlertActionStyle.default) { (action) in
        }
        alert.addAction(okAction)
        
    }
    

    

    
}
