//
//  Constants.swift
//  Spledger.iPhone
//
//  Created by Dimitar on 11/26/14.
//  Copyright (c) 2014 Dimitar Plamenov. All rights reserved.
//

import Foundation

class Constants
{
    struct CURRENT_DEVICE_IOS_VERSION
    {
        //       static let IS_IOS8:Bool = NSProcessInfo().isOperatingSystemAtLeastVersion(NSOperatingSystemVersion(majorVersion: 8, minorVersion: 0, patchVersion: 0))
        
//        static func SYSTEM_VERSION_EQUAL_TO(version: NSString) -> Bool
//        {
//            return UIDevice.currentDevice().systemVersion.compare(version,
//                options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedSame
//        }
//        
//        static func SYSTEM_VERSION_GREATER_THAN(version: NSString) -> Bool
//        {
//            return UIDevice.currentDevice().systemVersion.compare(version,
//                options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedDescending
//        }
//        
//        static func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version: NSString) -> Bool
//        {
//            return UIDevice.currentDevice().systemVersion.compare(version,
//                options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedAscending
//        }
//        
//        static func SYSTEM_VERSION_LESS_THAN(version: NSString) -> Bool
//        {
//            return UIDevice.currentDevice().systemVersion.compare(version,
//                options: NSStringCompareOptions.NumericSearch) == NSComparisonResult.OrderedAscending
//        }
//        
//        static func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version: NSString) -> Bool
//        {
//            return UIDevice.currentDevice().systemVersion.compare(version,
//                options: NSStringCompareOptions.NumericSearch) != NSComparisonResult.OrderedDescending
//        }
    }
    
    struct LocalNotification
    {
        static let kShowSideMenu = "kShowSideMenu"
        static let kShowAbout = "kShowAbout"
        static let kLogout = "kLogout"
        static let kSNotification = "notificationVC"
        static let kMyProfile = "kMyProfile"
        static let kSPushNotification = "PushNotificationVC"
    }
    
    struct NSUSERDEFAULTSKEY
    {
        static let DPassword            = "DPassword"
        static let DPushMessageInfo     = "DPushMessageInfo"
        static let DUserCredentials     = "DUserCredentials"
    }
    
    struct MyString {
        static func blank(_ text: String) -> Bool {
            let trimmed = text.trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    
    struct myGlobalFunction
    {
        static func  heightOfCommentRow (_ commentValue:NSString ,font:UIFont ,height:CGFloat) -> CGFloat
        {
            //var font = font
            let size = CGSize(width: height,height: CGFloat.greatestFiniteMagnitude)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineBreakMode = .byWordWrapping;
            let  attributes = [NSFontAttributeName:font,
                NSParagraphStyleAttributeName:paragraphStyle.copy()]
            let rect = commentValue.boundingRect(with: size, options:.usesLineFragmentOrigin, attributes: attributes, context:nil)
            return rect.size.height
        }
        
        static func dateDifference (_ fromDate:Date, toDate:Date) -> DateComponents
        {
//            let components = Calendar.current.components(.CalendarUnitSecond |
//                .CalendarUnitMinute | .CalendarUnitHour | .CalendarUnitDay |
//                  .CalendarUnitMonth | .CalendarUnitYear, fromDate: fromDate,
//                toDate: toDate, options: nil)
            let components = Calendar.current.dateComponents(Set<Calendar.Component>([.hour, .year, .minute,.second,.day,.month]), from: fromDate, to: toDate)
//            println("\(components.second) seconds")
//            println("\(components.minute) minutes")
//            println("\(components.hour) hours")
//            println("\(components.day) days")
            return components
        }
    }
    
    struct pushMessageStatus
    {
        static var MessageUnReadStatus = 0
        static var MessageReadStatus = 1
    }
}
