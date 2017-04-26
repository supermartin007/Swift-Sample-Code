//
//  SideMenuViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 01/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import Social

class SideMenuViewController : JADebugViewController,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate
{
    var tableViewArray : NSArray!
    var tableImageArray : NSArray!
    var viewupgradeViewController : upgradeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewArray = NSArray(objects: "Find Meeting" , "Add Meeting" , "Motivational Wall", "Upgrade To Premium","Restore","Profile","Settings ","About Us","LogOut")
        
        tableImageArray = NSArray(objects: "Side_Meeting1","Side_Meeting","motivational_wall" ,"upgrade","restore","profile","setting","about","logout")
        self.createUI()

        // Do any additional setup after loading the view.
    }
    
    func createUI()
    {
        //self.view.frame = CGRectMake(0, 0, ScreenSize.width - 80, ScreenSize.height)
        self.view.layer.cornerRadius = 4.0
        let  panelController =  JASidePanelController()
        let sideBarWidth : (CGFloat) = panelController.leftVisibleWidth
        
        // NSLog("%f", NSStringFromCGRect(panelController.leftPanelContainer.frame))
        let userValue : (SMLAppUser) = SMLAppUser.getUser()
        let userName : (NSString) = "\(userValue.firstName) \(userValue.lastName)" as (NSString)
        let userEmail : (NSString) = userValue.email
        
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "bg")
        bgImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(bgImageView)
        
        let profileImageView = UIImageView()
       
        let profileStr : (NSString) = userValue.profilePic
        if profileStr == ""
        {
             profileImageView.image = UIImage(named: "noImageAvailable")
        } else {
        
//        if(profileStr == "http://srv.iapptechnologies.com/12steplocator/profileImages/")
//        {
//            profileImageView.image = UIImage(named: "noImageAvailable.jpg")
//            
//        }
//        else
//        {
            let profileUrl : (URL) = URL(string: NSString(format: "%@", profileStr) as String)!
            profileImageView.sd_setImage(with: profileUrl)
        //}
        }
        profileImageView.frame = CGRect(x: (sideBarWidth-100)/2, y: 30, width: 100, height: 100)
        profileImageView.layer.borderWidth = 2.0
        profileImageView.layer.borderColor = UIColor.white.cgColor
       // profileImageView.backgroundColor = UIColor.whiteColor()
        profileImageView.clipsToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2;
        self.view.addSubview(profileImageView)

        let nameLabel = UILabel()
        nameLabel.text = userName as String
        nameLabel.font = SMLGlobal.sharedInstance.fontSize(17)
        nameLabel.textColor = UIColor.white
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.frame = CGRect(x: 0, y: profileImageView.frame.maxY+10, width: sideBarWidth, height: 30)
        self.view.addSubview(nameLabel)
        
        let emailLabel = UILabel()
        emailLabel.text = userEmail as String
        emailLabel.textColor = UIColor.white
        emailLabel.textAlignment = NSTextAlignment.center
        emailLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        emailLabel.frame = CGRect(x: 0, y: nameLabel.frame.maxY+5, width: sideBarWidth, height: 20)
        self.view.addSubview(emailLabel)
        
        let allCount : CGFloat = emailLabel.frame.maxY
        let lineView = UIView()
        lineView.backgroundColor = UIColor(red: 126.0/255.0, green: 103.0/255.0, blue: 155.0/255.0, alpha: 1.0)
        lineView.frame = CGRect(x: 20, y: emailLabel.frame.maxY+10, width: ScreenSize.width - 30, height: 1)
        self.view.addSubview(lineView)

        let sideMenuTableView = UITableView()
        sideMenuTableView.frame = CGRect(x: 20, y: lineView.frame.maxY+5, width: ScreenSize.width, height: ScreenSize.height - (allCount + 20))
        sideMenuTableView.separatorStyle = UITableViewCellSeparatorStyle.none
       sideMenuTableView.backgroundColor = UIColor.clear
       sideMenuTableView.dataSource = self
       sideMenuTableView.delegate = self
       self.view.addSubview(sideMenuTableView)
        
//        //SignUP
//        var fbBtn : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        var image = UIImage(named: "fb")
//        fbBtn.frame = CGRectMake(80, CGRectGetMaxY(sideMenuTableView.frame)+10, 33, 33)
//        fbBtn .setImage(image, forState: UIControlState.Normal)
//        fbBtn.addTarget(self, action: "fbBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(fbBtn)
//        
//        var btnSignTwitter : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        var twitterImage = UIImage(named: "tewitter")
//        btnSignTwitter.frame = CGRectMake(CGRectGetMaxX(fbBtn.frame)+5, CGRectGetMaxY(sideMenuTableView.frame)+10, 33, 33)
//        btnSignTwitter .setImage(twitterImage, forState: UIControlState.Normal)
//        btnSignTwitter.addTarget(self, action: "TwitterSignInAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(btnSignTwitter)
//        
//        
//        var InBtn : UIButton = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        var inImage = UIImage(named: "in")
//        InBtn.frame = CGRectMake(CGRectGetMaxX(btnSignTwitter.frame)+5, CGRectGetMaxY(sideMenuTableView.frame)+10, 33, 33)
//        InBtn .setImage(inImage, forState: UIControlState.Normal)
//        InBtn.addTarget(self, action: "InSignAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        self.view.addSubview(InBtn)
        
    }
    
    
    func fbBtnAction(_ sender : UIButton)
    {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook)
        {
            let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Share on Facebook")
            self.present(facebookSheet, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func TwitterSignInAction(_ sender : UIButton)
    {
        if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter){
            let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Share on Twitter")
            self.present(twitterSheet, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to share.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
//    func fbBtnAction(sender : UIButton)
//    {
//        
//    }
//    func TwitterSignInAction(sender : UIButton)
//    {
//        
//    }
    
    func InSignAction(_ sender : UIButton)
    {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell!.textLabel?.textColor = UIColor.black
            cell?.textLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
            
            let  lineColor = UIColor(red: 126.0/255.0, green: 103.0/255.0, blue: 155.0/255.0, alpha: 1.0)
            let lineView = UIView()
            lineView.frame = CGRect(x: 0, y: 43, width: cell!.frame.size.width - 40, height: 1)
            lineView.backgroundColor = lineColor
            cell?.contentView.addSubview(lineView)
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
        
       // cell.sele
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.text = self.tableViewArray .object(at: indexPath.row) as? String
        //
        cell?.textLabel?.textColor = UIColor.white
       
        cell?.textLabel?.font = SMLGlobal.sharedInstance.fontSize(15)
        //cell?.imageView?.image = self.tableImageArray.objectAtIndex(indexPath.row) as? UIImage
        cell?.imageView?.image = UIImage(named: self.tableImageArray.object(at: indexPath.row) as! String)
      //  NSLog("%@", self.tableImageArray)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //Find Meeting
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if((indexPath as NSIndexPath).row == 0)
        {
            let view = meetingFinderViewController(nibName: nil, bundle: nil)
            view.classAction = 2
            delegate.callMethod(view)
        }
        //Add Meeting
        else if((indexPath as NSIndexPath).row == 1)
        {
//            var view = AddMeetingViewController(nibName: nil, bundle: nil)
//            delegate.callMethod(view)
            let view: HomeViewController = HomeViewController()
             delegate.callMethod(view)
            
        }
        //Motivational Wall
        else if((indexPath as NSIndexPath).row == 2)
        {
            let view = motivationalWallViewController(nibName: nil, bundle: nil)
            delegate.callMethod(view)
        }
        //Upgrade To premium
        else if((indexPath as NSIndexPath).row == 3)
        {
            let user : (SMLAppUser) = SMLAppUser.getUser()
            let upgrade : (NSString) = user.upgrade
            if(upgrade == "0")
            {
                viewupgradeViewController = upgradeViewController(nibName: nil, bundle: nil)
                delegate.callMethod(viewupgradeViewController)
            }
            else
            {
                UIAlertView(title: "", message: "You already upgrade this premium", delegate: nil, cancelButtonTitle: "OK").show()
            }
            
        }
       // Restore
        else if((indexPath as NSIndexPath).row == 4)
        {
            let user : (SMLAppUser) = SMLAppUser.getUser()
            print(user.userId)
            let userId : (NSString) = user.userId
            let upgrade : (NSString) = user.upgrade
            if(upgrade == "0")
            {
                viewupgradeViewController = upgradeViewController(nibName: nil, bundle: nil)
                viewupgradeViewController.isRestore = true
                delegate.callMethod(viewupgradeViewController)
            }
            else
            {
                UIAlertView(title: "", message: "You already upgrade this premium", delegate: nil, cancelButtonTitle: "OK").show()
            }

        }
        //Profile
        else if((indexPath as NSIndexPath).row == 5)
        {
            let view = ProfileViewController(nibName: nil, bundle: nil)
            delegate.callMethod(view)
        }
        //Settings
        else if((indexPath as NSIndexPath).row == 6)
        {
            let view = settingView(nibName: nil, bundle: nil)
            delegate.callMethod(view)
        }
        //About Us
        else if((indexPath as NSIndexPath).row == 7)
        {
            let view = AboutUsViewController(nibName: nil, bundle: nil)
            delegate.callMethod(view)
        }
        //Log Out
        else if((indexPath as NSIndexPath).row == 8)
        {
            let alertView : (UIAlertView) = UIAlertView(title: "", message: "Do you want to Logout?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
            alertView.show()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            let appUser : (SMLAppUser) = SMLAppUser.getUser()
            let push : (NSString) = appUser.pushNotification
            if push == "0"
            {
            
            let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let firstView = ViewController(nibName: nil, bundle: nil)
            
            let navig = UINavigationController(rootViewController: firstView)
            
            delegate.window!.rootViewController = navig
            SMLAppUser.deleteUser()
            _ = navigationController?.popToRootViewController(animated: false)
            let manager : FBSDKLoginManager = FBSDKLoginManager()
            manager.logOut()
            }
            else
            {
            self.logoutWebservice()
            }
        }
    }
    func logoutWebservice()
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
       
        //http://srv.iapptechnologies.com/12steplocator/index.php/login/wsDeleteDeviceToken?userId=
        SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
        let appUser : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = appUser.userId
        let tokenId : (NSString) =    UserDefaults.standard.object(forKey: "DeviceToken") as! NSString

        let parameters : (NSDictionary) = ["userId" : loginId, "DeviceToken" : tokenId]
        WebserviceManager.sharedInstance.logoutWebservice(params: parameters)
        { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                _ = responseObject?.value(forKey: "message") as! NSString
                if success == 0
                {
                    //                var alertView = UIAlertView(title: "", message:message as NSString as String, delegate: nil, cancelButtonTitle: "Ok")
                    //                alertView.show()
                    SVProgressHUD .dismiss()
                }
                else if success == 1
                {
                    let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    let firstView = ViewController(nibName: nil, bundle: nil)
                    let navig = UINavigationController(rootViewController: firstView)
                    delegate.window!.rootViewController = navig
                    SMLAppUser.deleteUser()
                   // UserDefaults.standard .set(nil, forKey: "StepUserData")
                    self.navigationController?.popToRootViewController(animated: false)
                    let manager : FBSDKLoginManager = FBSDKLoginManager()
                    manager.logOut()
                    SVProgressHUD .dismiss()
    
             }
            else
            {
                SVProgressHUD .dismiss()
            }
            }
        }
        }
        else
        {
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
