//
//  WebserviceManager.swift
//  12 Step Meeting Locator Api
//
//  Created by Rajni on 11/3/16.
//  Copyright © 2016 Rajni. All rights reserved.
//

import UIKit
import Foundation

//Path Url
let serverUrl                           = "http://104.236.197.214/index.php/login/"
let profileImagesUrl                    = "http://104.236.197.214//profileImages/"
let motivationalImagesUrl               = "http://104.236.197.214/uploads/"
let motivationalImagesThumbUrl          = "http://104.236.197.214/uploads/thumbs/thumb_"

//LOGIN & REGISTRATION PATH
let LOGINPATH                           = "wslogin"
let REGISTRATIONPATH                    = "wsregistration"
let FORGOTPASSWORD_PATH                 = "wsforgotpassword"
let SIGNUPFB_PATH                       = "signupwithfb"

//MEETINGS PATH
let CHECKINMEETING_PATH                 = "wsmeetingAttended"
let MEETINGATTEND_PATH                  = "wsmeetingAttendedApproved"
let MEETINGNEARBY_PATH                  = "wsMeetingsNearby"
let GETALLMEETINGS_PATH                 = "wsAllMeetings"
let GETMEETINGSPROGRAM_PATH             = "wscategory_program"
let ADDMEETINGS_PATH                    = "wsaddmeeting"
let SEARCHMEETTING_PATH                 = "wssearchmeetings"

//wsPublicMotivationalImages
//MOTIVATIONAL PATH
let PUBLICMOTIVATIONALIMAGES_PATH       = "wsPublicMotivationalImages"
let PRIVATEMOTIVATIONALIMAGES_PATH      = "wsprivateMotivationalImages"
let UPLOADMOTIVATIONALIMAGES_PATH       = "wsUploadMotivationalImages"
let UPDATEMOTIVATIONALIMAGES_PATH       = "wsUpdateMotivationalImage"

//CALL SPONSORS PATH 
let LISTCALLSPONSORS_PATH               = "wsListSponsors"
let DELETECALLSPONSOR_PATH              = "wsDeleteSponsors"
let UPDATECALLSPONSOR_PATH              = "wsUpdateSponsors"
let ADDCALLSPONSOR_PATH                 = "wsAddSponsors"

//LOGOUT PATH
let PUSHNOTIFICATIONSTATUS_PATH         = "wsChangePushStatus"
let CHANGEEMAILSTATUS_PATH              = "wsChangeEmailStatus"
let LOGOUTWEBSERVICE_PATH               = "wsDeleteDeviceToken"
let EDITPROFILE_PATH                    = "wseditprofile"

let LISTALLCOMMENTS_PATH                = "wsListComments"
let ADDMOTIVATIONALIMAGECOMMENT_PATH    = "wsAddMotivationalImageComment"
let DELETEMOTIVATIONALIMAGE_PATH        = "wsDeleteMotivationalImage"
let DELETEMOTIVATIONALIMAGECOMMENT_PATH = "wsDeleteComment"

let GETSOBRIETYCALCULATOR_PATH          = "wsfindSobrietyCount"
let GETSOBRIETYCALCULATORSAVE_PATH      = "wssaveSobrietyDate"
let GETSOBRIETYCALCULATOROLDSTATUS_PATH = "wsSobrietyCalculate"
let CHANGEPASSWORD_PATH                 = "wschangepassword"

private let singletonInstance = WebserviceManager()

var sessionTask     :   URLSessionDataTask  = URLSessionDataTask()
var parameters      :   NSDictionary        = NSDictionary()
var servicePath     :   NSString            = NSString()


protocol WebserviceDelegate {
    func webserviceSuceedWithObject(responseObject : NSDictionary)
    func webserviceFailedWithError(error : NSError)
}
class WebserviceManager: NSObject {

    // Class method that will return singleton instance of this class
    class var sharedInstance: WebserviceManager {
        return singletonInstance
    }
    var delegate : WebserviceDelegate!

    
    func start(withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        var url = URL(string: serverUrl.addingPercentEscapes(using: String.Encoding.utf8)!)!
        
        
        
        let manager = AFHTTPSessionManager(baseURL: url)
    
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        
        
           let setTemp:NSSet = NSSet(array: ["application/json", "text/json", "text/javascript","text/html"])
        
        manager.responseSerializer.acceptableContentTypes = setTemp as? Set<String>
        manager.post(servicePath as String, parameters: parameters, progress: nil, success:
            { ( operation, responseObject) in
                block((responseObject as AnyObject?)!,nil)
            })
        { (operation,error) in
            block(nil,error)
        }
    }
    
    
    func cancelService()
    {
        self.delegate = nil
        sessionTask.cancel()
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

    
    // MARK : Webservices Call
    //Login Webservice
    //MARK:- Webservices Call
    func getLoginWebservice(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://srv.iapptechnologies.com/12steplocator/index.php/login/wslogin?email=rajni.a@yahoo.com&password=12345678
        parameters = params;
        servicePath = LOGINPATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- Register Webservice
    func getRegisterWebservice(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //
        parameters = params;
        servicePath = REGISTRATIONPATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
            
        }
    }
    
    //MARK:- Forgot Password Webservice
    func forgotPasswordWebservice(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
       //http://112.196.34.179/stepslocator/index.php/login/wsforgotpassword?&email=
        parameters = params;
        servicePath = FORGOTPASSWORD_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- SignUP With FB
    func signUpWithFb(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        parameters = params;
        servicePath = SIGNUPFB_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
            
        }
    }
    
    
    //MARK:- CheckIn Meeting
    func checkInMeeting(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsmeetingAttended?user_id=&meeting_id=&day=
        parameters = params;
        servicePath = CHECKINMEETING_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- MeetingAttended Approval
    func meetingAttendedApproval(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsmeetingAttendedApproved?attendance_id=
        parameters = params;
        servicePath = MEETINGATTEND_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    //MARK:- Get Meeting Nearby
    func getMeetingNearBy(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsMeetingsNearby?latitude=&longitude=
        parameters = params;
        servicePath = MEETINGNEARBY_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
   //MARK:- Get MEETINGS LIST BY SEARCHING
    func getMeetingBySearching(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        // 104.236.197.214/index.php/login/wssearchmeetings?searchmeeting=
        parameters = params;
        servicePath = SEARCHMEETTING_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- Get ALL MEETINGS
    func getAllMeetings(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsAllMeetings
        parameters = params;
        servicePath = GETALLMEETINGS_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- PRIVATE MOTIVATIONAL IMAGE WEBSERVICE
    func getPrivateMotivationalImages(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsprivateMotivationalImages?user_id=2&limit=0
        parameters = params;
        servicePath = PRIVATEMOTIVATIONALIMAGES_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    //MARK:- PUBLIC MOTIVATIONAL IMAGE WEBSERVICE
    func getPublicMotivationalImages(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsprivateMotivationalImages?user_id=2&limit=0
        parameters = params;
        servicePath = PUBLICMOTIVATIONALIMAGES_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    //MARK:- UPLOAD MOTIVATIONAL IMAGE WEBSERVICE
    func uploadMotivationalImages(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsUploadMotivationalImages?user_id=&image_title=&image_description=&image=
        parameters = params;
        servicePath = UPLOADMOTIVATIONALIMAGES_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- UPDATE MOTIVATIONAL IMAGE WEBSERVICE
    func updateMotivationalImage(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsUpdateMotivationalImage?image_id=&image_title=&image_description=&image=
        parameters = params;
        servicePath = UPDATEMOTIVATIONALIMAGES_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    //MARK:- LIST CALL SPONSORS
    func listCallSponsors(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsListSponsors?userId=11
        parameters = params;
        servicePath = LISTCALLSPONSORS_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- DELETE CALL LIST SPONSORS
    func deleteCallSponsors(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsDeleteSponsors?sponsorId=
        parameters = params;
        servicePath = DELETECALLSPONSOR_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- UPDATE CALL SPONSOR
    func updateCallSponsors(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsUpdateSponsors?sponsorId=49&firstname=developerIapp&lastname=Php&number=9988776655&country_code=&*klnhg15277
        parameters = params;
        servicePath = UPDATECALLSPONSOR_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
   
    //MARK:- ADD CALL SPONSOR WEBSERVICE
    func addSponsors(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        // http://112.196.34.179/stepslocator/index.php/login/wsAddSponsors?userId=10&firstname=developer&lastname=Iapp&number=9988997766&country_code=35tyf766
        parameters = params;
        servicePath = ADDCALLSPONSOR_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    //MARK:- PUSH NOTIFICATION WEBSERVICE
    func pushNotificationWebservice(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsChangePushStatus?userId=&status=
        parameters = params;
        servicePath = PUSHNOTIFICATIONSTATUS_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- EMAIL NOTIFICATION WEBSERVICE
    func changeEmailStatusWebservice(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsChangeEmailStatus?userId=&status=
        parameters = params;
        servicePath = CHANGEEMAILSTATUS_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- LOGOUT WEBSERVICE
    func logoutWebservice(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://srv.iapptechnologies.com/12steplocator/index.php/login/wsDeleteDeviceToken?userId=
        parameters = params;
        servicePath = LOGOUTWEBSERVICE_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- EDIT PROFILE WEBSERVICE
    func editProfile(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wseditprofile?user_id=&first_name=&last_name=&email=&city=&gender=&dob=&profile_pic=
        parameters = params;
        servicePath = EDITPROFILE_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
   
    //MARK:- LIST ALL COMMENTS WEBSERVICE
    func displayCommentsList(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsListComments?image_id=&limit=0
        parameters = params;
        servicePath = LISTALLCOMMENTS_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- ADD MOTIVATIONAL IMAGE COMMENT WEBSERVICE
    func addMotivationalImageComment(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsAddMotivationalImageComment?user_id=&comment=&image_id=
        parameters = params;
        servicePath = ADDMOTIVATIONALIMAGECOMMENT_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    //MARK:- DELETE MOTIVATIONAL IMAGE WEBSERVICE
    func deleteMotivationalImage(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //"http://srv.iapptechnologies.com/12steplocator/index.php/login/wsDeleteMotivationalImage?"
        parameters = params;
        servicePath = DELETEMOTIVATIONALIMAGE_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    //MARK:- DELETE IMAGE COMMENT WEBSERVICE
    func deleteImageComment(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsDeleteComment?commentId=
        parameters = params;
        servicePath = DELETEMOTIVATIONALIMAGECOMMENT_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    //MARK:- GET SOBRIETY CALCULATOR WEBSERVICE

    func findSobrietyCalculator(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsfindSobrietyCount?user_id=12&sob_Date=2015-06-18
        parameters = params;
        servicePath = GETSOBRIETYCALCULATOR_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    func findSobrietyCalculatorSave(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        // http://104.236.197.214/index.php/login/wssaveSobrietyDate?user_id=216&sob_Date=2014-11-22

        parameters = params;
        servicePath = GETSOBRIETYCALCULATORSAVE_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    func findSobrietyCalculateOldStatus (params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://104.236.197.214/index.php/login/wsSobrietyCalculate?user_id=216
        parameters = params;
        servicePath = GETSOBRIETYCALCULATOROLDSTATUS_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    
    

    //
    func getMeetingCategories(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://srv.iapptechnologies.com/12steplocator/index.php/login/wscategory_program
        parameters = params;
        servicePath = GETMEETINGSPROGRAM_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    func changePassword(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        ////http://112.196.34.179/stepslocator/index.php/login/wschangepassword?user_id=&oldpassword=&password=&cpassword=
        parameters = params;
        servicePath = CHANGEPASSWORD_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }
    
    
    func addMeeting(params : NSDictionary, withCompletionBlock block: @escaping (_ dict: AnyObject?,_ error: Error?) -> Void)
    {
        //http://112.196.34.179/stepslocator/index.php/login/wsaddmeeting?login_id=&program_id=&category_id=&meeting_name=&description=&country=&state=&city=&zip=&address1=&address2=&location=&meetingdatetime=&latitude=&longitude=&days_of_week=
        parameters = params;
        servicePath = ADDMEETINGS_PATH as NSString
        self.start { (responseObject, error) in
            if (responseObject != nil)
            {
                block(responseObject,nil)
            }
            else
            {
                block(nil,error)
            }
        }
    }

}


