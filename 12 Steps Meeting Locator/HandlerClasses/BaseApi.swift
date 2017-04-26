//
//  BaseApi.swift
//  Spledger.iPhone
//
//  Created by Dev Mac on 11/14/14.
//  Copyright (c) 2014 Dimitar Plamenov. All rights reserved.
//

import Foundation
import UIKit



var viewController1: ViewController!


 //MARK:- Base API

class BaseApi
{
    var timeOutSession:TimeInterval = 90
    // Structure of the app token
    
    struct API_TOKEN {
        var access_token:NSString
        var token_type:NSString
        var expires_in:AnyObject
        var issued:NSString
        var expires:NSString
    }
    
    // Web service endpoints configures
    struct Endpoints {
        static var RegisterSpledger:NSString { return "/api/accounts/register-spledger" }
        
    }
    

    struct Endkeywords {
        static var campaignsV1SingleSummaryKeyword:NSString { return "/summary"  }
        static var reportV1topSpledgersKeyword:NSString { return "/top-spledgers"  }
        static var reportV1SpledgersKeyword:NSString { return "/spledgers"  }
        
        static var reportV1recentSpledgersKeyword:NSString { return "/recent-spledgers"  }
        static var reportV1performanceStandingsKeyword:NSString { return "/program-standings"}
        static var reportV1performanceGamesKeyword:NSString { return "/game-statistics"}
        static var reportV1performanceGameSummery:NSString { return "/game-statistics"}

///programs
        
         static var campaignsV1SingleProgramsKeyword:NSString { return "/programs"}
        
        static var campaignsVSplegerSubmitKeyword:NSString { return "/spledges"}
 static var campaignsVAnonymousSubmitKeyword:NSString { return "/anonymous"}
        
        
        static var campaignsVMySpledgeKeyword:NSString { return "/me/spledges"}


//follow


 static var campaignsVFollowKeyword:NSString { return "/follow"}
 
        
        static var campaignsVNewsKeyword:NSString { return "/news"}
        
        
        static var spledgeHammerKeyword:NSString { return "/spledgehammer"}
        
        
       //RevV! Donantion
        
          static var spledgeRevVDonationKeyword:NSString { return "/donations"}
        
        
        //campaignDescription
         static var campaignDescriptionKeyword:NSString { return "/description"}
        
        ///performers
         static var performanceKeyword:NSString { return "/performers"}
    }
    // app token
    var appToken:API_TOKEN
    
    // user role
    var userRole:NSString
    
    var tokenDetail :NSMutableDictionary
    // current web host server
    let webHost:NSString = "http://projects.hypertrends.com/SpledgerApi"
    //
    // Static instance
    struct Client {
        static var staticInstance:BaseApi?
        static func Instance() -> BaseApi {
            if (staticInstance == nil) {
                staticInstance = BaseApi()
                
            }
            
            return staticInstance!
        }
    }
    
    /*
    // MARK: - Initialize
    */
    
    init() {
        self.appToken = API_TOKEN(access_token: "", token_type: "", expires_in: "" as AnyObject, issued: "", expires: "")
        self.userRole = "Guest"
        tokenDetail = [:] as NSMutableDictionary;
        var defaults: UserDefaults = UserDefaults.standard
    }
    
}
   
