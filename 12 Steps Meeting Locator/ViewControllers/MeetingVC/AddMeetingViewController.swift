//
//  AddMeetingViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 03/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class AddMeetingViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
     var meetingArray : NSArray!
    var detailTableView : UITableView!
    var navigationView : UIView!
    var filteredArray  : NSMutableArray!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredArray = NSMutableArray()
        self.navigationController?.isNavigationBarHidden = true
        
        
        self.navigationController!.navigationBar.barTintColor  = UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0)
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white , NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(15)]
        
        self.navigationItem.title = "Add Meetings"
        
        
        // self.navigationItem.leftBarButtonItem?.image = UIImage(named: "back_errow")
        // self.navigationItem.rightBarButtonItem?.image = UIImage(named: "fb")
        
        let backImage =  UIImage(named: "home")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, landscapeImagePhone: nil, style: UIBarButtonItemStyle.plain, target: self, action: #selector(AddMeetingViewController.backBtnAction(_:)))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.view.backgroundColor = UIColor.white
    //Navigation View
        
        
        
        navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 100)
        navigationView.backgroundColor = UIColor(red: 0.0/255.0, green:135/255, blue: 206.0/255.0, alpha: 1.0)
        self.view.addSubview(navigationView)
        
        let backBtn = UIButton.init(type: UIButtonType.custom)
        let image = UIImage(named: "home")
        backBtn.addTarget(self, action: #selector(AddMeetingViewController.backBtnAction(_:)), for: UIControlEvents.touchUpInside)
        
        backBtn.frame = CGRect(x: 10,y: 25, width: 30, height: 30)
        backBtn.setImage(image, for: UIControlState())
        navigationView.addSubview(backBtn)
        
        
        let titleLabel = UILabel()
        titleLabel.frame=CGRect(x: 30, y: 25, width: navigationView.frame.size.width-50, height: 20)
        titleLabel.text = "Add meetings"
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(13)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        navigationView.addSubview(titleLabel)
        
        
        
        
        
        let createLocationProfileBtn = UIButton.init(type: UIButtonType.custom)
        // createLocationProfileBtn.setTitle("Create New Location Profile", forState: UIControlState.Normal)
        createLocationProfileBtn.frame = CGRect(x: 50, y: 60, width: ScreenSize.width - 100, height: 30)
        //createLocationProfileBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(15)
        createLocationProfileBtn.addTarget(self, action: #selector(AddMeetingViewController.createLocationProfileBtn(_:)), for: UIControlEvents.touchUpInside)
        //createLocationProfileBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
        //createLocationProfileBtn.backgroundColor = UIColor.blueColor()
        //createLocationProfileBtn.layer.cornerRadius = 10.0
        //createLocationProfileBtn.layer.
        createLocationProfileBtn.setImage(UIImage(named: "cratenew"), for: UIControlState())
        navigationView.addSubview(createLocationProfileBtn)
        
        
        
        
         self.navigationController?.navigationItem.hidesBackButton = true
        
        
        
        
//                var editBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//                editBtn.frame = CGRectMake(navigationView.frame.size.width - 30, 20, 20, 20)
//                var image1 = UIImage(named: "edit")
//                editBtn.setImage(image1, forState: UIControlState.Normal)
//                navigationView.addSubview(editBtn)
//        

    }
    
   
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
       self.getAllMeetings()
    }
    
    
   
    
    
    func createUI()
    {
       // self.navigationController?.navigationBarHidden = true
        
        
//        var backBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        var image = UIImage(named: "home")
//        backBtn.addTarget(self, action: "backBtnAction:", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        backBtn.frame = CGRectMake(10,20, 20, 20)
//        backBtn.setImage(image, forState: UIControlState.Normal)
//        navigationView.addSubview(backBtn)
        
        
       // self.navigationController?.navigationItem.hidesBackButton = true
        
        
        
        
//        var editBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//        editBtn.frame = CGRectMake(navigationView.frame.size.width - 30, 20, 20, 20)
//        var image1 = UIImage(named: "edit")
//        editBtn.setImage(image1, forState: UIControlState.Normal)
//        navigationView.addSubview(editBtn)
        
        
//        var navigationView = UIView()
//        navigationView.frame = CGRectMake(0, 64, ScreenSize.width, 50)
//        navigationView.backgroundColor = UIColor(red: 31.0/255.0, green:134/255, blue: 209.0/255.0, alpha: 1.0)
//        self.view.addSubview(navigationView)

        
//        var titleLabel = UILabel()
//        titleLabel.frame=CGRectMake(30, 20, navigationView.frame.size.width-50, 20)
//        titleLabel.text = "Add meeting"
//        titleLabel.font = SMLGlobal.sharedInstance.fontSize(15)
//        titleLabel.textAlignment = NSTextAlignment.Center
//        titleLabel.textColor = UIColor.whiteColor()
//        navigationView.addSubview(titleLabel)
        
        
        
        
        
        
        
//        var createLocationProfileBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
//       // createLocationProfileBtn.setTitle("Create New Location Profile", forState: UIControlState.Normal)
//        createLocationProfileBtn.frame = CGRectMake(60, 10, ScreenSize.width - 120, 30)
//        //createLocationProfileBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(15)
//        createLocationProfileBtn.addTarget(self, action: "createLocationProfileBtn:", forControlEvents: UIControlEvents.TouchUpInside)
//        //createLocationProfileBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
//        //createLocationProfileBtn.backgroundColor = UIColor.blueColor()
//        //createLocationProfileBtn.layer.cornerRadius = 10.0
//        //createLocationProfileBtn.layer.
//        createLocationProfileBtn.setImage(UIImage(named: "cratenew"), forState: UIControlState.Normal)
//        navigationView.addSubview(createLocationProfileBtn)
        
        
        detailTableView = UITableView()
        detailTableView.frame = CGRect(x: 0, y: navigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - (navigationView.frame.size.height))
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(detailTableView)
        
        
        
       
  
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let meetingArr : (NSMutableArray) = self.filteredArray as NSMutableArray!
        return meetingArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell!.textLabel?.textColor = UIColor.black
            cell?.selectionStyle = UITableViewCellSelectionStyle.none
        }
      
        let subviews = cell!.contentView.subviews
        for view in subviews
        {
            view.removeFromSuperview()
        }
        
        let meetingArr : (NSMutableArray) = self.filteredArray as NSMutableArray!
       
        
      //  println()
        
        let programView = UIView()
        programView.frame = CGRect(x: 5, y: 5, width: 50, height: 50)
        cell?.contentView.addSubview(programView)
        
        let programImageView = UIImageView()
        programImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        //programImageView.image = UIImage(named: "place_hold_a")
        programView.addSubview(programImageView)
        
        let dictValues : (NSDictionary) = meetingArr.object(at: indexPath.row) as! NSDictionary
        let programLabel = UILabel()
        let programName = dictValues.object(forKey: "program_name")
        if (indexPath as NSIndexPath).row % 2 != 0 {
            cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            //cell!.backgroundColor = UIColor(white: 242/255.0, alpha: 1.0)
            programImageView.image = UIImage(named: "place_hold_b")
            
        } else {
            cell!.backgroundColor = UIColor.white
            //contentCell.leftView.backgroundColor = UIColor.whiteColor()
            programImageView.image = UIImage(named: "place_hold_a")
            
        }
        programLabel.text = programName as! String?
        programLabel.textAlignment = NSTextAlignment.center
        programLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        programLabel.textColor = UIColor.black
        programLabel.frame = CGRect(x: 10, y: 0, width: 30, height: 50)
        programView.addSubview(programLabel)
        
        
        
       // var labelWidth : (CGFloat) = (cell?.frame.size.width - programView.frame.size.width)
        
        let textLabel = UILabel()
        textLabel.frame = CGRect(x: programView.frame.maxX+10, y: 5, width: ScreenSize.width - 80, height: 20)
        textLabel.text = dictValues.object(forKey: "meeting_name") as! String?
        textLabel.font = SMLGlobal.sharedInstance.fontSize(15.0)
        textLabel.textColor = UIColor(red: 60.0/255.0, green: 92.0/255.0, blue: 152.0/255.0, alpha: 1.0)
        
       // let gray : UIColor! = UIColor(netHex: 0x4f5151)
        //var color = UIColor(red: 0xFF, blue: 0xFF, green: 0xFF)
       // var color2 = UIColor(netHex: 0x4f5151)
       // 60,92.152
        
        cell?.contentView.addSubview(textLabel)
        
        
        
        let detailTextLabel = UILabel()
        detailTextLabel.frame = CGRect(x: programView.frame.maxX+10, y: textLabel.frame.maxY+3, width: self.view.frame.size.width - 70, height: 20)
        detailTextLabel.text = dictValues.object(forKey: "address1") as! String?
        detailTextLabel.font = SMLGlobal.sharedInstance.fontSize(12.0)
        //detailTextLabel.textColor = UIColor.grayColor()
         detailTextLabel.textColor = UIColor(red: 81.0/255.0, green: 81.0/255.0, blue: 81.0/255.0, alpha: 1.0)
        cell?.contentView.addSubview(detailTextLabel)
       
        
        
        // textLabel.frame = CGRectMake(<#x: CGFloat#>, <#y: CGFloat#>, <#width: CGFloat#>, <#height: CGFloat#>)
      
//        cell?.textLabel?.text = meetingArr.valueForKey("meeting_name")?.objectAtIndex(indexPath.row)  as? String
//        cell?.textLabel?.font = SMLGlobal.sharedInstance.fontSize(15.0)
//        cell?.textLabel?.textColor = UIColor.blueColor()
//        cell?.detailTextLabel?.text = meetingArr.valueForKey("location")?.objectAtIndex(indexPath.row)  as? String
//        cell?.detailTextLabel?.font = SMLGlobal.sharedInstance.fontSize(10.0)
//        cell?.detailTextLabel?.textColor = UIColor.grayColor()
//        
//

        
        
        
        
        //
        
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var detailMeeting : (MeetingDetailViewController) = MeetingDetailViewController()
//        
//         var meetingArr : (NSMutableArray) = self.filteredArray as NSMutableArray!
//       // var meetingArr : (NSMutableArray) = self.filteredArray.objectAtIndex(indexPath.row) as! (NSMutableArray)
//        detailMeeting.detailArray   = meetingArr.objectAtIndex(indexPath.row) as! (NSDictionary)
//        self.navigationController?.pushViewController(detailMeeting, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func backBtnAction(_ sender : UIButton)
    {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
    }
    
    func getAllMeetings()
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        //SVProgressHUD.showWithStatus("Please Wait")
         SVProgressHUD.show(withStatus: "Please Wait", maskType: SVProgressHUDMaskType.black)
        //SVProgressHUD.showProgress(1.0, status: "Please Wait")
        let parameters : (NSDictionary) = ["firstname" : ""]
        WebserviceManager.sharedInstance.getAllMeetings(params: parameters)
        { (responseObject, error) in
            if responseObject != nil
            {
                 let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
               

                if success == 0
                {
                     let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                    SMLGlobal.sharedInstance.displayAlertMessage(self, message as String as String as NSString, title: "")
                    SVProgressHUD .dismiss()
                }
                else if success == 1
                {
//                print(responseObject)
//                if(((responseObject?.value(forKey: "success") as AnyObject).boolValue) != nil)
//                {
                    self.meetingArray = responseObject?.value(forKey: "data") as! NSArray;
                    for i in 0..<self.meetingArray.count
                    {
                        let dictValues : (NSDictionary) = self.meetingArray.object(at: i) as! (NSDictionary)
                        let meetingId: (NSString) = dictValues.object(forKey: "meeting_id") as! (NSString)
                        if(self.filteredArray.count > 0)
                        {
                            //var filterdMeetingId: (NSString) = self.filteredArray .valueForKey("meeting_id") as! String
                            let predicate : NSPredicate = NSPredicate(format: "self.meeting_id contains[c] %@ ",meetingId)
                            // self.filteredArray = self.meetingArray.filteredArrayUsingPredicate(predicate)
                            let arrayValue : (NSArray) = self.filteredArray .filtered(using: predicate) as (NSArray)
                            //finalArray = self.meetingArray.filteredArrayUsingPredicate(predicate)
                            if(arrayValue.count == 0)
                            {
                                self.filteredArray .add(self.meetingArray.object(at: i))
                            }
                            else
                            {
                                
                            }
                        }
                        else
                        {
                            self.filteredArray .add(self.meetingArray.object(at: i))
                        }
                        //if(meet)
                    }
                    self.createUI()
                    SVProgressHUD.dismiss()
                    // self.meetingArray = dict.objectForKey("data") as! NSMutableArray
                    // self.programArray = dict.objectForKey("program") as! NSMutableArray
                }
            }
            else
            {
                SVProgressHUD.dismiss()
            }
        }
        }
        else
        {
            SMLGlobal.sharedInstance.NOINTERNETALERT(self)
        }
    }
    
    func createLocationProfileBtn(_ sender : UIButton)
    {
        let homeView: HomeViewController = HomeViewController()
        self.navigationController?.pushViewController(homeView, animated: false)
      //  let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
      //  delegate.callMethod(homeView)
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
