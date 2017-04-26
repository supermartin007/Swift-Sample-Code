//
//  SMLAppUser.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 09/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class SMLAppUser: NSObject {
    
    var userId = NSString()
    var profilePic = NSString()
    var firstName = NSString()
    var lastName = NSString()
    var userName = NSString()
    var probationName = NSString()  //old one is Gender
    var probationEmail = NSString() //old one is City
    var dob = NSString()
    var userType = NSString()
    var email = NSString()
    var upgrade = NSString()
    var emailNotification = NSString()
    var pushNotification = NSString()
    
    
    
    
    
    
class func getUser() -> SMLAppUser
{
    let userData = SMLAppUser()
    //var uid = user.objectForKey("userType") as! NSString
   // println(uid)
    
    if(UserDefaults.standard.object(forKey: "StepUserData") != nil)
    {
        let user: NSDictionary = UserDefaults.standard.object(forKey: "StepUserData") as! NSDictionary
        userData.userId = user.object(forKey: "id") as! NSString
        userData.userName = user.object(forKey: "userName") as! NSString
        userData.firstName = user.object(forKey: "firstName") as! NSString
        userData.lastName = user.object(forKey: "lastName") as! NSString
        userData.probationName = user.object(forKey: "probationName") as! NSString
        userData.dob = user.object(forKey: "dob") as! NSString
        userData.probationEmail = user.object(forKey: "probationEmail") as! NSString
        userData.userType = user.object(forKey: "userType") as! NSString
        userData.email = user.object(forKey: "email") as! NSString
        userData.profilePic = user.object(forKey: "profileUrl") as! NSString
        userData.upgrade = user.object(forKey: "upgrade") as! NSString
        userData.emailNotification = user.object(forKey: "emailNotification") as! NSString
        userData.pushNotification = user.object(forKey: "pushNotification") as! NSString
        return userData
    }
    return userData
    
   
}
    
class func saveUser(_ user:SMLAppUser)
{

   let dictValues : NSDictionary = ["id" : user.userId,
                                       "userName" : user.userName,
                                        "firstName" : user.firstName,
                                        "lastName" : user.lastName,
                                        "probationName" : user.probationName,
                                        "probationEmail" : user.probationEmail,
                                        "dob" : user.dob,
                                        "userType" : user.userType,
                                        "email" : user.email,
                                        "profileUrl" : user.profilePic,
                                        "upgrade" : user.upgrade,
                                        "pushNotification" : user.pushNotification,
                                        "emailNotification" : user.emailNotification] as NSDictionary
    
    
    UserDefaults.standard.set(dictValues, forKey: "StepUserData")
    UserDefaults.standard.synchronize()
    
}
    //#PragmaMark: deleteUser
class func deleteUser()
{
    UserDefaults.standard.removeObject(forKey: "StepUserData")
    UserDefaults.standard.synchronize()
    UserDefaults.standard.removeObject(forKey: "Timer")
    UserDefaults.standard.synchronize()
    if(AppDelegate.sharedInstance().timerAttendMetting != nil)
    {
    AppDelegate.sharedInstance().timerAttendMetting.invalidate()
    AppDelegate.sharedInstance().timerAttendMetting = nil
    }
    AppDelegate.sharedInstance().meetingIdAttendMetting = ""
    AppDelegate.sharedInstance().attendanceIdAttendMetting = ""
}
}
