//
//  SideMenuController.swift
//  Spledger.iPhone
//
//  Created by Dimitar on 11/26/14.
//  Copyright (c) 2014 Dimitar Plamenov. All rights reserved.
//

import Foundation

class SideMenuController: UIViewController
{
    @IBOutlet var buttonMyaccount: UIButton!
    @IBOutlet var buttonNotifications: UIButton!
    @IBOutlet var buttonLogout: UIButton!
    @IBOutlet var buttonAbout: UIButton!
    @IBOutlet var titleMenu: UILabel!
    
    @IBOutlet var buttonNotificationAction: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        buttonNotificationAction.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(17)
        buttonMyaccount.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(17)
        buttonAbout.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(17)
        buttonLogout.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(17)
        titleMenu.font = SMLGlobal.sharedInstance.fontSize(17)
//        if BaseApi.Client.Instance().userRole == "Guest"
//        {
//            buttonLogout.setTitle("login", for: UIControlState())
//        }
    }

    @IBAction func onNotifications(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.LocalNotification.kSNotification), object: nil)
    }
    

    @IBAction func onMyAccount(_ sender: AnyObject)
    {
          NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.LocalNotification.kMyProfile), object: nil)
    }
    
    @IBAction func onAbout(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.LocalNotification.kShowAbout), object: nil)
    }
    
    @IBAction func onLogout(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.LocalNotification.kLogout), object: nil)
    }
    
    
    @IBAction func onNotificationAction(_ sender: AnyObject)
    {
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.LocalNotification.kSNotification), object: nil)
    }
}
