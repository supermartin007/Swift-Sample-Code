//
//  settingView.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 08/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

//var cell : UITableViewCell!

var tableArray : NSArray!

class settingView: UIViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        /* Hide navugation Bar*/
        self.navigationController!.isNavigationBarHidden = true
        
        var pushVal : (Int) = 0
        var emailVal : (Int) = 0
        
        /* Table View array*/
        
        tableArray = NSArray(objects: "Account","Help","Push Notification","Terms & Condition","FAQ")
        
//        self.navigationController!.navigationBar.barTintColor  = UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0)
//        
//        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor() , NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(15)]
//        
//        self.navigationItem.title = "Setting"
        
         /* Hide navugation Back Button*/
        
        self.navigationItem.hidesBackButton = true
        
        /* Background View*/
        
        var backView : UIView = UIView()
        backView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height)
        backView.backgroundColor = UIColor.white
        self.view.addSubview(backView)
        
        /* Navigation Bar View*/
        
        var navView: UIView = UIView()
        //var nheight =  navigationController?.navigationBar.frame.height + 20
        navView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 80)
        navView.backgroundColor = UIColor(red: 0/255.0, green:135/255, blue: 206/255, alpha: 1.0)
        backView.addSubview(navView)
        var navHeight = navView.frame.height
        var navMid = navHeight / 2 - 15
        
         /* Home Button*/
        
        var leftButton: UIButton = UIButton()
        leftButton.frame = CGRect(x: 16, y: navMid, width: 30, height: 30)
        var img = UIImage(named: "home")
        leftButton.setBackgroundImage(img, for: UIControlState())
        leftButton.addTarget(self, action: #selector(settingView.homeClick(_:)), for: UIControlEvents.touchUpInside)
        navView.addSubview(leftButton)
        var titlepos = ScreenSize.width / 2 - 60
        
         /* Navigation Title*/
        
        var titleButton: UIButton = UIButton()
        titleButton.frame = CGRect(x: titlepos - 2, y: navMid, width: 120, height: 30)
        titleButton.setTitle("Settings", for: UIControlState())
        titleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        titleButton.setTitleColor(UIColor.white, for: UIControlState())
        navView.addSubview(titleButton)
      
           /* Table View*/
        
        var settingTable: UITableView = UITableView()
        settingTable.frame = CGRect(x: 0, y: navHeight, width: ScreenSize.width, height: 250)
        view.addSubview(settingTable)
        settingTable.backgroundColor = UIColor.clear
        
          /* Table View delegate and dataSource*/
        settingTable.delegate  = self
        settingTable.dataSource = self
        
        self.view.backgroundColor = UIColor.white
        
       

    }
    
     /* HomeButton Function*/
    func homeClick(_ sender: UIButton) {
        navigationController!.isNavigationBarHidden = false
        var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return tableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var appUser = SMLAppUser.getUser()
        
       var push =  appUser.pushNotification
        //println(push)
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
    
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell!.textLabel?.textColor = UIColor.black
            cell?.textLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
            cell?.backgroundColor = UIColor.clear
           /* Cell Background Set*/
                //cell!.backgroundColor = UIColor(red: 249.0 / 255, green: 247.0 / 255, blue: 248.0 / 255, alpha: 1)
            
      /* Cell Line View*/
            var sepView: UIButton = UIButton()
            var cellhei = cell!.frame.height
            sepView.frame = CGRect(x: 0, y: 49, width: 15, height: 1)
            sepView.backgroundColor = UIColor(red: 223.0 / 255, green: 222.0 / 255, blue: 225.0 / 255, alpha: 1)
            cell!.addSubview(sepView)
            
             /* Cell Label Call*/
            
            cell!.textLabel?.text = tableArray[indexPath.row] as? String
            
             /* disclosureIndicator Button Set*/
            var disclosureIndicator: UIButton = UIButton()
            disclosureIndicator.frame = CGRect(x: ScreenSize.width - 33, y: 18, width: 12, height: 15)
            disclosureIndicator.backgroundColor = UIColor.clear
            //disclosureIndicator.setTitle(">", forState: .Normal)
            var imgIndicator = UIImage(named: "forward_arrow")
            disclosureIndicator.setBackgroundImage(imgIndicator, for: UIControlState())
            disclosureIndicator.setTitleColor(UIColor.black, for: UIControlState())
            disclosureIndicator.tag = (indexPath as NSIndexPath).row
            cell!.addSubview(disclosureIndicator)

            if (indexPath as NSIndexPath).row == 2 {
                 /* disclosureIndicator Button hidden*/
                if disclosureIndicator.tag == 2 {
                    disclosureIndicator.isHidden = true
                }
                 /* pushNotification switch Button set*/
                var pushonOff : UISwitch = UISwitch()
                
                var pushNotif : (NSString) = appUser.pushNotification
                if(pushNotif .isEqual(to: "1"))
                {
                    pushonOff.isOn = true
                }
                else
                {
                    pushonOff.isOn = false
                }
                pushonOff.frame = CGRect(x: ScreenSize.width - 70, y: 10, width: 50, height: 30)
                pushonOff.onTintColor = UIColor(red: 241.0 / 255, green: 77.0 / 255, blue: 84.0 / 255, alpha: 1)
                
                pushonOff.addTarget(self, action: #selector(settingView.pushNotification(_:)), for: UIControlEvents.valueChanged)
                //onOff
                cell?.addSubview(pushonOff)
            }
            
//            }  else if indexPath.row == 3 {
//                
//                 /* disclosureIndicator Button hidden*/
//                if disclosureIndicator.tag == 3 {
//                    disclosureIndicator.hidden = true
//                }
//                /* pushNotification switch Button set*/
//                
//                var eMailonOff : UISwitch = UISwitch()
//                
//                var emailNotif : (NSString) = appUser.emailNotification
//                if(emailNotif .isEqualToString("1"))
//                {
//                    eMailonOff.on = true
//                }
//                else
//                {
//                    eMailonOff.on = false
//                }
//                eMailonOff.frame = CGRectMake(ScreenSize.width - 70, 10, 200, 30)
//                eMailonOff.onTintColor = UIColor(red: 241.0 / 255, green: 77.0 / 255, blue: 84.0 / 255, alpha: 1)
//                 eMailonOff.addTarget(self, action: "emailNotification:", forControlEvents: UIControlEvents.ValueChanged)
//            
//                cell?.addSubview(eMailonOff)
//            } 
            else if (indexPath as NSIndexPath).row == 4 {
                if disclosureIndicator.tag == 5 {
                    disclosureIndicator.isHidden = true
                }
            }

            
            
            
        }
        

        
        
        
        return cell!
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
        
       
    {
        /* Cell Color Change when Cell is Clicked*/
        let cellToDeSelect:UITableViewCell = tableView.cellForRow(at: indexPath)!
        cellToDeSelect.contentView.backgroundColor = UIColor(red: 242.0 / 255, green: 253.0 / 255, blue: 254.0 / 255, alpha: 1)
         ///println(cellToDeSelect)
        if ((indexPath as NSIndexPath).row == 0) {
            let cngpassword: changePasswordViewController = changePasswordViewController()
            self.navigationController?.pushViewController(cngpassword, animated: true)
        }
        
        if ((indexPath as NSIndexPath).row == 1) {
            let cngpassword: helpViewController = helpViewController()
            self.navigationController?.pushViewController(cngpassword, animated: true)
        }
        
        if ((indexPath as NSIndexPath).row == 3) {
            let cngpassword: term_conditionViewController = term_conditionViewController()
            self.navigationController?.pushViewController(cngpassword, animated: true)
        }
        
        if ((indexPath as NSIndexPath).row == 4) {
            let cngpassword: faqViewController = faqViewController()
            self.navigationController?.pushViewController(cngpassword, animated: true)
        }

}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        /* Cell Height Set*/
        return 50
    }
    func pushNotification(_ sender: UISwitch)
    {
       // println(sender.enabled)
        if(sender.isOn)
        {
          
            self.pushNotificationWebservice(1)
        }
        else
        {
            self.pushNotificationWebservice(0)
        }
        
       // println("pushNotification Switch")
        
    }
    
    func pushNotificationWebservice(_ status:Int)
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
        //http://112.196.34.179/stepslocator/index.php/login/wsChangePushStatus?userId=&status=
        SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
        let appUser : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = appUser.userId
        let parameters : (NSDictionary) = ["userId" : loginId,
            "status" : status]
        WebserviceManager.sharedInstance.pushNotificationWebservice(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                var success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                var message = responseObject?.value(forKey: "message") as! NSString
                if success == 0
                {
                    SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                    SVProgressHUD .dismiss()
                }
                else if success == 1
                {
                    var alertView = UIAlertView(title: "", message:message as NSString as String, delegate: self, cancelButtonTitle: "Ok")
                    alertView.show()
                    var satus : (NSString) = NSString(format: "%d", status)
                    appUser.pushNotification = satus
                    
                    if(satus .isEqual(to: "1"))
                    {
                        var delegateObj : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
                        
                        
                        
                        if( UserDefaults.standard.object(forKey: "DeviceToken") != nil)
                        {
                            var deviceToken : (NSString) = UserDefaults.standard.object(forKey: "DeviceToken") as! NSString
                            delegateObj.getDeviceToken(deviceToken, loginId: appUser.userId)
                        }
                    }
                    SMLAppUser.saveUser(appUser)
                    SVProgressHUD .dismiss()
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
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }
    
    func emailNotification(_ sender: UISwitch)
    {
        if(sender.isOn)
        {
            self.emailNotificationWebservice(1)
        }
        else
        {
            self.emailNotificationWebservice(0)
        }
        
    }
    
    func emailNotificationWebservice(_ status:Int)
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
        //SVProgressHUD.showWithStatus("Loading...")
          SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
        let appUser : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = appUser.userId
        //http://112.196.34.179/stepslocator/index.php/login/wsChangeEmailStatus?userId=&status=
        let parameters : (NSDictionary) = ["userId" : loginId,
            "status" : 1]
        WebserviceManager.sharedInstance.changeEmailStatusWebservice(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                let message = responseObject?.value(forKey: "message") as! NSString
                if success == 0
                {
                   SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                    SVProgressHUD .dismiss()
                }
                else if success == 1
                {
                    let alertView = UIAlertView(title: "", message:message as NSString as String, delegate: self, cancelButtonTitle: "Ok")
                    alertView.show()
                    
                    let satus : (NSString) = NSString(format: "%d", status)
                    appUser.emailNotification = satus
                    SMLAppUser.saveUser(appUser)
                    SVProgressHUD .dismiss()
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
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
     }

}
