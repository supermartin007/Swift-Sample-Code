//
//  callSponsorViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 22/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class callSponsorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UIAlertViewDelegate {
    
    var customView  =  UIView()
    var navigationView = UIView()
    
    var callTableView : UITableView!
    
    var listArray = NSMutableArray()
    var addButton:(UIButton)!
    
    var deleteAlertView : (UIAlertView) = UIAlertView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
       // self.listAllSponsors()
        self.createUI()
        
        /* Hide navugation Bar*/
        self.navigationController!.isNavigationBarHidden = true
        
        
        
        /* Hide navugation Back Button*/
        
        self.navigationItem.hidesBackButton = true
        
        
        
       

    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        
       self.listAllSponsors()
        
    }
    
    func createUI()
    {
        customView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 80)
        customView.backgroundColor = UIColor(red: 0/255.0, green: 136/255.0, blue: 206 / 255.0, alpha:1.0)
        self.view.addSubview(customView)
        
        //navigationView
        
        navigationView.frame = CGRect(x: 0, y: customView.frame.height - 30, width: ScreenSize.width, height: 30)
        navigationView.backgroundColor = UIColor(red: 0 / 255.0, green: 106 / 255.0, blue: 160 / 255.0, alpha:1.0)
        customView.addSubview(navigationView)
        
        
        
        var leftButton: UIButton = UIButton()
        leftButton.frame = CGRect(x: 20, y: customView.frame.height - 60, width: 25, height: 25)
        var img = UIImage(named: "home")
        leftButton.setBackgroundImage(img, for: UIControlState())
        leftButton.addTarget(self, action: #selector(callSponsorViewController.homeClick(_:)), for: UIControlEvents.touchUpInside)
        customView.addSubview(leftButton)
        
        var titlepos = ScreenSize.width / 2 - 60
        
        /* Navigation Title*/
        
        var titleButton: UIButton = UIButton()
        titleButton.frame = CGRect(x: titlepos - 2, y: customView.frame.height - 60, width: 120, height: 30)
        titleButton.setTitle("Call sponsor", for: UIControlState())
        titleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        titleButton.setTitleColor(UIColor.white, for: UIControlState())
        customView.addSubview(titleButton)
        
        
        
        var textLabel : UILabel = UILabel()
        textLabel.frame = CGRect(x: 20, y: 0, width: 100, height: 30)
        textLabel.text = "Sponsors"
        textLabel.textColor = UIColor.white
        textLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        navigationView.addSubview(textLabel)
       
        addButton = UIButton.init(type: UIButtonType.custom)
        addButton.addTarget(self, action: #selector(callSponsorViewController.addButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //rightButton.backgroundColor = UIColor.whiteColor()
        var rightButtonImage: UIImage = UIImage(named: "add_icon")!
        addButton.frame = CGRect(x: ScreenSize.width - 44, y: 0, width: 30, height: 30)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addButton.setBackgroundImage(rightButtonImage, for: UIControlState())
        navigationView.addSubview(addButton)
        
        
        
        callTableView = UITableView()
        callTableView.frame = CGRect(x: 0, y: customView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - 80)
        self.view.addSubview(callTableView)
     
        callTableView.delegate = self
        callTableView.dataSource = self
        
        
        callTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func listAllSponsors()
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
        //SVProgressHUD.showWithStatus("Loading")
         SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
        var user : (SMLAppUser) = SMLAppUser.getUser()
        var loginId : (NSString) = user.userId
        
        //http://112.196.34.179/stepslocator/index.php/login/wsListSponsors?userId=11
        
        var parameters : (NSDictionary) = ["userId" : loginId]
        WebserviceManager.sharedInstance.listCallSponsors(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                var success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if success == 0
                {
                    var message : NSString = responseObject!.value(forKey: "message") as!NSString
                    var alertView = UIAlertView(title: "", message:message as String, delegate: nil, cancelButtonTitle: "Ok")
                    alertView.show()
                    self.listArray = NSMutableArray()
                    self.callTableView.reloadData()
                    //self.listArray.count = 0
                    SVProgressHUD .dismiss()
                }
                else if success == 1
                {
                    self.listArray = NSMutableArray()
                    var userList : (NSArray) = responseObject!.value(forKey: "sponsors") as! NSArray
                    var adminList : (NSArray) = responseObject!.value(forKey: "adminsponsors") as! NSArray
                    if(userList.count>=2)
                    {
                        for i in 0..<userList.count
                        {
                            self.listArray .add(userList.object(at: i))
                            if(self.listArray.count == 2)
                            {
                                break;
                            }
                        }
                    }
                    else if(userList.count == 1)
                    {
                        self.listArray.add(userList.object(at: 0))
                        
                        if(adminList.count > 0)
                        {
                            self.listArray.add(adminList.object(at: 0))
                        }
                    }
                    else if(userList.count == 0)
                    {
                        for i in 0..<adminList.count
                        {
                            self.listArray .add(adminList.object(at: i))
                            if(self.listArray.count == 2)
                            {
                                break;
                            }
                        }
                    }
                    // var dict : (NSDictionary) = responseObject.valueForKey("sponsors") as! NSDictionary
                    // self.listArray = responseObject.valueForKey("sponsors") as! NSArray
                                        if(self.listArray.count>=2)
                    {
                        self.addButton.isHidden = true
                    }
                    //println(self.listArray.count)
                    self.callTableView.reloadData()
                    SVProgressHUD .dismiss()
                }
            }
            else
            {
                var message : NSString = responseObject!.value(forKey: "message") as!NSString
                var alertView = UIAlertView(title: "", message:message as String, delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()

                SVProgressHUD .dismiss()
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        //println("array count is %d",finalArray.count)
        return listArray.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var findmeeting : (NSArray) = NSArray()
         var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell?.textLabel?.textColor = UIColor.black
        }
        
        var subviews = cell?.contentView.subviews
        // println("Hello\(subviews.count)")
        for view in subviews!
        {
            view.removeFromSuperview()
        }
        //cell?.separatorInset =
        var meetingBackView = UIView()
        meetingBackView.backgroundColor = UIColor.red
        meetingBackView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width , height: 70)
        cell?.contentView.addSubview(meetingBackView)
        var higt = (meetingBackView.frame.size.height - 48) / 2
        
        
        
        
        
        var leftTableView : (UIView) = UIView()
        leftTableView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width - 70, height: 70)
        leftTableView.isUserInteractionEnabled  = true
        leftTableView.tag = indexPath.row
        cell?.contentView.addSubview(leftTableView)
        
        
        let tapGesture : (UITapGestureRecognizer) = UITapGestureRecognizer(target: self, action: #selector(callSponsorViewController.CallGesture(_:)))
        leftTableView.addGestureRecognizer(tapGesture)
        
//        var leftImage : UIImageView = UIImageView()
//        leftImage.frame = CGRectMake(15, higt, 50, 48)
//        leftImage.image = UIImage(named: "call_icon")
//        //meetingBackView.addSubview(leftImage)
        
//        var programName: UILabel = UILabel()
//        programName.frame = CGRectMake((leftImage.frame.width  / 2) - 10, (leftImage.frame.height  / 2) - 12, 30, 20)
//        programName.text = "AA"
//        programName.font = SMLGlobal.sharedInstance.fontSize(12)
//        programName.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
//        //leftImage.addSubview(programName)
        
        //var leftimageWidth = CGRectGetMaxX(leftImage.frame) + 5
        var dict: (NSDictionary) = self.listArray.object(at: (indexPath as NSIndexPath).row) as! NSDictionary
        var title: UILabel = UILabel()
    
        
        title.font = SMLGlobal.sharedInstance.fontSize(12)
        var firstName : (NSString) = dict.value(forKey: "firstname") as! NSString
        var lastName : (NSString) = dict.value(forKey: "lastname") as! NSString
        var fullName  : (NSString) = NSString(format: "%@ %@", firstName,lastName)
        title.text = fullName as String
        var size : (CGRect) = fullName.boundingRect(with: CGSize(width: ScreenSize.width - 100, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : title.font], context: nil)
        title.textColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.5)
        title.frame = CGRect(x: 20, y: higt + 3, width: ScreenSize.width - 100,height: 20)
        leftTableView.addSubview(title)
        
        
        
        var phoneImage : (UIImageView) = UIImageView()
        
        phoneImage.frame = CGRect(x: 20, y: title.frame.maxY+5, width: 15, height: 15)
        phoneImage.image = UIImage(named: "call_icon")
        leftTableView.addSubview(phoneImage)
        
        var callNumber: UILabel = UILabel()
        callNumber.frame = CGRect(x: 40, y: title.frame.maxY + 2, width: ScreenSize.width - 40 , height: 20)
        var phoneNumber : (NSString) = dict.value(forKey: "phone_number") as! NSString
        
        
        var code : (NSString) = dict.value(forKey: "country_code") as! NSString
        var fullMob  : (NSString) = NSString(format: "%@ %@", code,phoneNumber)
       
        callNumber.text = fullMob as String
        callNumber.font = SMLGlobal.sharedInstance.fontSize(8)
        callNumber.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        //callNumber.numberOfLines = 0
        leftTableView.addSubview(callNumber)
        
        var deleteButton : (UIButton) = UIButton.init(type: UIButtonType.custom)
        deleteButton.setImage(UIImage(named: "delet_icon"), for: UIControlState())
        deleteButton.frame = CGRect(x: meetingBackView.frame.size.width - 40, y: (60 - 25)/2, width: 25, height: 25)
        deleteButton.tag = (indexPath as NSIndexPath).row
        deleteButton .addTarget(self, action: #selector(callSponsorViewController.deleteData(_:)), for: UIControlEvents.touchUpInside)
        
        
        
        var linesep: UIView = UIView()
        linesep.frame =  CGRect(x: meetingBackView.frame.size.width - 43, y: (60 - 15)/2, width: 1, height: 15)
        linesep.backgroundColor = UIColor(red: 200 / 255, green: 200 / 255, blue: 200 / 255, alpha: 1)
       
        var editButton : (UIButton) = UIButton.init(type: UIButtonType.custom)
        editButton.setImage(UIImage(named: "edit_icon"), for: UIControlState())
        editButton.addTarget(self, action: #selector(callSponsorViewController.editButton(_:)), for: UIControlEvents.touchUpInside)
        editButton.frame = CGRect(x: meetingBackView.frame.size.width - 70, y: (60 - 25)/2, width: 25, height: 25)
        editButton.tag = (indexPath as NSIndexPath).row
     
    
    var user : (SMLAppUser) = SMLAppUser.getUser()
    var loginId : (NSString) = user.userId
        var sponsorId : (NSString) = (listArray.value(forKey: "user_id_fk") as AnyObject).object(at :indexPath.row) as! NSString
    if(loginId .isEqual(to: sponsorId as String))
    {
           meetingBackView.addSubview(deleteButton)
           meetingBackView.addSubview(editButton)
         meetingBackView.addSubview(linesep)
    }
    
            if (indexPath as NSIndexPath).row % 2 != 0 {
                meetingBackView.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
                //leftImage.image = UIImage(named: "place_hold_b")
                
                
            } else {
                meetingBackView.backgroundColor = UIColor.white
                //leftImage.image = UIImage(named: "place_hold_a")
                
           
        }
            cell?.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        
        
       
      
      
        
//        //NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", numberToCall]];
//        if ([[UIApplication sharedApplication] canOpenURL:phoneURL]) {
//            [[UIApplication sharedApplication] openURL:phoneURL];
//        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func homeClick(_ sender: UIButton) {
        navigationController!.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: true)
    }
    
    func addButtonClick(_ sender: UIButton) {
        let addContact: addContactViewController = addContactViewController()
        navigationController?.pushViewController(addContact, animated: true)
    }
    
    func deleteData(_ sender: UIButton)
    {
        deleteAlertView = UIAlertView(title: "", message: "Do you want to delete this sponsor?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
        deleteAlertView.tag = sender.tag
        deleteAlertView.show()
    }
    
    func CallGesture(_ gesture : UITapGestureRecognizer)
    {
        print(gesture.view?.tag)
        let alertView = UIAlertView(title: "", message: "Do you want to call this sponsor?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
        alertView.tag = (gesture.view?.tag)!
        alertView.show()
    }
    
    func editButton(_ sender: UIButton)
    {
        let editDict : (NSDictionary) = self.listArray .object(at: sender.tag) as! (NSDictionary)
        let editContact : (contactViewController) = contactViewController()
        editContact.editDict = editDict
        self.navigationController?.pushViewController(editContact, animated: false)
    }
    
    
    func deleteSponsors()
    {
        
    }
    
    
    //MARK: AlertView Delegate Methods
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
    {

        //Delete Contact
        if alertView == deleteAlertView
        {
        //Cancel
        if buttonIndex == 0
        {
            
        }
        //Ok
        else if buttonIndex == 1
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
            
            //http://112.196.34.179/stepslocator/index.php/login/wsDeleteSponsors?sponsorId=
                //SVProgressHUD.showWithStatus("Loading")
             SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
                 var editDict : (NSDictionary) = self.listArray .object(at: alertView.tag) as! (NSDictionary)
                var ids : (NSString) = editDict.object(forKey: "id") as! String as (NSString)
            
                var parameters : (NSDictionary) = ["sponsorId" : ids]
            
                WebserviceManager.sharedInstance.deleteCallSponsors(params: parameters) { (responseObject, error) in
                if responseObject != nil
                {
                    var success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    
                    if success == 0
                    {
                        var message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                        var alertView = UIAlertView(title: "", message:message as String, delegate: nil, cancelButtonTitle: "Ok")
                        alertView.show()
                        SVProgressHUD .dismiss()

                        // println("Hello Reja")
                    }

                        
                    else if success == 1
                    {
                        var message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                        var alertView = UIAlertView(title: "", message:message as String, delegate: self, cancelButtonTitle: "Ok")
                        alertView.show()
                        //self.listAllSponsors()
                        self.listArray.removeObject(at: self.deleteAlertView.tag)
                        self.callTableView.reloadData()
                        if(self.listArray.count == 0)
                        {
                            UIAlertView(title: "", message:"No Sponsors Found", delegate: nil, cancelButtonTitle: "Ok").show()
                            self.addButton.isHidden = false
                        }
                        else
                        {
                            if(self.listArray.count <= 2)
                            {
                                self.addButton.isHidden = false
                            }
                            else
                            {
                                self.addButton.isHidden = true
                            }
                            
                        }
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
        //Make A Call
        else
        {
            
            //Cancel
            if buttonIndex == 0
            {
                
            }
                //Ok
            else if buttonIndex == 1
            {
                var dict: (NSDictionary) = self.listArray.object(at: alertView.tag) as! NSDictionary
                let phoneNumber : (NSString) = dict.value(forKey: "phone_number") as! NSString
                var phoneUrl : (URL) = URL(string: NSString(format: "tel:%@", phoneNumber) as String)!
                
                if UIApplication.shared.canOpenURL(phoneUrl)
                {
                    UIApplication.shared.openURL(phoneUrl)
                }
            }
        }
    
    }

}
