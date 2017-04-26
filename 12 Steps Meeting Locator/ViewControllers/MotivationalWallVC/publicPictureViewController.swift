//
//  publicPictureViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 30/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class publicPictureViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate,UIAlertViewDelegate  {
    var addPictureNav: UIView!
    var picView : UIScrollView!
    var picImageView : UIImageView!
    var commentView = UIView()
    var commentTabView = UIScrollView()
    var  appUser : (SMLAppUser) = SMLAppUser.getUser()
    var descriptionText :  UITextView = UITextView()
    var timestamp: String!
   var tableHeight = CGFloat(0)
    var  noLabel = UILabel()
    var firstBlnkValue = 0
    var commentTextField: (UITextField)!
    
    var tableViewArray : NSMutableArray = NSMutableArray()
    
    var totalCount : (Int) = 0
    
    
    var singleDict : NSDictionary!
    
    
    var uiView : UIButton!
    var commentTableView :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addPictureNav = UIView()
        addPictureNav.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        addPictureNav.backgroundColor = UIColor(red: 0 / 255.0, green:135.0 / 255, blue: 206.0 / 255, alpha: 1.0)
        self.view.addSubview(addPictureNav)
        
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        
        let leftHomeButton : UIButton = UIButton()
        let homeImage: UIImage = UIImage(named: "back_errow")!
        leftHomeButton.setBackgroundImage(homeImage, for: UIControlState())
        leftHomeButton.frame = CGRect(x: 16, y: 32, width: 20 , height: 20)
        leftHomeButton.addTarget(self, action: #selector(publicPictureViewController.homeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addPictureNav.addSubview(leftHomeButton)
        
        let meetingNodeTitel: UILabel = UILabel()
        meetingNodeTitel.text = singleDict.object(forKey: "image_title") as! String?
        meetingNodeTitel.font = SMLGlobal.sharedInstance.fontSize(14)
        meetingNodeTitel.textAlignment = .center
        meetingNodeTitel.frame = CGRect(x: (ScreenSize.width - 200) / 2, y: 32, width: 200, height: 20)
        meetingNodeTitel.textColor = UIColor.white
        
        addPictureNav.addSubview(meetingNodeTitel)
        
        
        picView = UIScrollView()
       
        picView.frame = CGRect(x: 0, y: addPictureNav.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - 60)
        picView.backgroundColor = UIColor.white
        picView.isScrollEnabled = true
        picView.bounces = true
       // picView.userInteractionEnabled = true
        self.view.addSubview(picView)
        
        
        picImageView = UIImageView()
        picImageView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: (ScreenSize.height / 4) - 15)
        let profileStr : (NSString) = singleDict.object(forKey: "img_names") as! NSString
//        if(profileStr == "http://srv.iapptechnologies.com/12steplocator/uploads/")
//        {
//            picImageView.image = UIImage(named: "")
//            
//        }
//        else
//        {
            let profileUrl : (URL) = URL(string: NSString(format: "%@%@", motivationalImagesUrl,profileStr) as String)!
            picImageView.sd_setImage(with: profileUrl)
       // }

//        picImageView.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin | UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleRightMargin | UIViewAutoresizing.FlexibleLeftMargin | UIViewAutoresizing.FlexibleTopMargin | UIViewAutoresizing.FlexibleWidth
        picImageView.contentMode = UIViewContentMode.scaleAspectFit
        picImageView.backgroundColor = UIColor(red: 54 / 255, green: 54 / 255, blue: 54 / 255, alpha: 1)
        picView.addSubview(picImageView)
        
        let descriptionLabel : UILabel = UILabel()
        descriptionLabel.frame = CGRect(x: 30, y: picImageView.frame.maxY + 3, width: ScreenSize.width - 50, height: 20)
        descriptionLabel.text = "Description"
        descriptionLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        descriptionLabel.textColor = UIColor(red: 0.0 / 255, green:  0.0 / 255, blue:  0.0 / 255, alpha: 0.8)
        picView.addSubview(descriptionLabel)
        let line = UILabel()
        line.frame = CGRect(x: 0, y: descriptionLabel.frame.size.height - 1, width: descriptionLabel.frame.size.width, height: 1)
        line.backgroundColor = UIColor(red: 214 / 255, green: 214 / 255, blue: 214 / 255, alpha: 1)
        descriptionLabel.addSubview(line)
        
        descriptionText.frame = CGRect(x: 30, y: descriptionLabel.frame.maxY  , width: ScreenSize.width - 60, height: 100)
        descriptionText.isScrollEnabled = true
        descriptionText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        descriptionText.font = SMLGlobal.sharedInstance.fontSize(10)
        descriptionText.text = singleDict.object(forKey: "image_description") as! NSString as String
        descriptionText.isEditable = false
        descriptionText.isUserInteractionEnabled = true
        picView.addSubview(descriptionText)
        
        commentView.frame = CGRect(x: 0, y: descriptionText.frame.maxY + 10 , width: ScreenSize.width, height: 210)

        picView.addSubview(commentView)
        
        
        let commentLabel : UILabel = UILabel()
        commentLabel.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 20)
        commentLabel.text  = "\t Comments"
        commentLabel.backgroundColor = UIColor(red: 0 / 255, green: 136 / 255, blue: 206 / 255, alpha: 1)
        commentLabel.textColor = UIColor.white
        commentLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        commentView.addSubview(commentLabel)
        
        commentTabView.frame = CGRect(x: 30, y: commentLabel.frame.maxY , width: ScreenSize.width - 60, height: 200)
        //commentTabView.backgroundColor = UIColor.redColor()
        commentView.addSubview(commentTabView)
        
        commentTableView = UITableView()
        commentTableView.frame = CGRect(x: 0, y: 0, width: commentTabView.frame.width, height: 149)
        commentTabView.addSubview(commentTableView)
        commentTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        commentTableView.delegate = self
        commentTableView.dataSource = self
        
        let commentSearchBar = UIView()
        commentSearchBar.frame = CGRect(x: 40, y: commentView.frame.size.height - 30 , width: ScreenSize.width - 80, height: 30)
        commentSearchBar.backgroundColor = UIColor(red: 206 / 255, green: 206 / 255, blue: 206 / 255, alpha: 1)
        commentView.addSubview(commentSearchBar)
        
        commentTextField  = UITextField()
        commentTextField.frame = CGRect(x: 3, y: 5, width: commentSearchBar.frame.width - 50, height: 20)
        commentTextField.placeholder = "\t Add Comment"
        commentTextField.delegate = self
        commentTextField.backgroundColor = UIColor.white
        commentTextField.font = SMLGlobal.sharedInstance.fontSize(10)
        commentTextField.layer.borderWidth = 1
        commentTextField.layer.cornerRadius = 5
        commentTextField.tag = 1
        commentTextField.layer.borderColor = UIColor.clear.cgColor
        commentSearchBar.addSubview(commentTextField)
        
        commentTextField.delegate = self
        
        
        
        
        let leftViewText = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        commentTextField.leftView = leftViewText
        commentTextField.leftViewMode  = UITextFieldViewMode.always
        
        
        let addComment: UIButton = UIButton()
        addComment.frame = CGRect(x: commentTextField.frame.maxX + 5, y: 6, width: 35, height: 18)
        let commAddImage = UIImage(named: "button_add")
        addComment.setImage(commAddImage, for: UIControlState())
        addComment.addTarget(self, action: #selector(publicPictureViewController.addCommentAction(_:)), for: UIControlEvents.touchUpInside)
        commentSearchBar.addSubview(addComment)
        //picView.backgroundColor = UIColor.redColor()
        
        
        picView.contentSize = CGSize(width: ScreenSize.width, height: addComment.frame.maxY+20)
        
        if ScreenSize.height == 480
        {
            picView.contentSize = CGSize(width: ScreenSize.width, height: ScreenSize.height+40)
            picView.bounces = false
            
        }
        
        
        self.listAllComments(0)
        
        
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let currentOffset : (CGFloat) = scrollView.contentOffset.y
        let maxOffset : (CGFloat) = scrollView.contentSize.height - scrollView.frame.size.height
        if (maxOffset - currentOffset <= 10.0)
        {
            if(tableViewArray.count>=10)
            {
                self .addMoreData()
            }
            
            //self.showMoreBtn(nil)
            //    [self methodThatAddsDataAndReloadsTableView];
        }
    }
    
    func addMoreData()
    {
        //println(self.tableViewArray)
        if(self.tableViewArray.count<self.totalCount)
        {
            self.listAllComments(self.tableViewArray.count)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Home Button Click
    func homeButtonClick(_ sender: UIButton) {
        navigationItem.hidesBackButton = true
        navigationController?.popViewController(animated: true)
    }
    //MARK:- numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewArray.count
    }
    //MARK:- cellForRowAtIndexPath
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
            as UITableViewCell!
       // printTimestamp()
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell!.textLabel?.textColor = UIColor.black
        }
        
        let subviews = cell!.contentView.subviews
        // println("Hello\(subviews.count)")
        for view in subviews
        {
            view.removeFromSuperview()
        }
        let singleArray : (NSDictionary) = self.tableViewArray.object(at: (indexPath as NSIndexPath).row) as! (NSDictionary)
        let commentStr : (NSString) = (singleArray.object(forKey: "comment") as? String)! as (NSString)
       // var commentLength : (CGSize) = commentStr.boundingRectWithSize(CGSizeMake(lbl - 60, 999), options:NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName : commentLbl.font], context: nil).size
        let meetingBackView = UIView()
         //meetingBackView.backgroundColor = UIColor.redColor()
        let height:CGFloat = self.tableView(tableView, heightForRowAt:indexPath)
        meetingBackView.frame = CGRect(x: 0, y: 0, width: commentTableView.frame.size.width, height: height)
        cell?.contentView.addSubview(meetingBackView)

        let imgView: UIImageView = UIImageView()
        imgView.frame = CGRect(x: 5, y: 5.0, width: 30.0, height: 30.0)
        let profileStr : (NSString) = (singleArray.object(forKey: "profile_pic") as? NSString)!
        if(profileStr == "")
        {
            imgView.image =  UIImage(named: "noImageAvailable")
        }
        else
        {
            let urlString : (NSString) = NSString(format: "%@%@",profileImagesUrl,profileStr)
            let profileUrl : (URL) = URL(string: urlString as String)!
            imgView.sd_setImage(with: profileUrl)
        }
        meetingBackView.addSubview(imgView)
        
        //meetingBackView.addSubview(imgView)
        let lbl = meetingBackView.frame.size.width
        
        let titleLbl : UILabel = UILabel()
        let userName : (NSString) = (singleArray.object(forKey: "username")  as! NSString) as String as String as (NSString)
        titleLbl.frame = CGRect(x: imgView.frame.maxX + 5.0, y: 5.0, width: 78.0 , height: 15.0)
        titleLbl.text = userName as String
        titleLbl.font = SMLGlobal.sharedInstance.fontSize(12)
        titleLbl.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        meetingBackView.addSubview(titleLbl)
        
        
       // titleLbl.backgroundColor = UIColor.redColor()
        let timeLbl : UILabel = UILabel()
        //println(nameLength.width)
        let timeStr : (NSString)  = SMLGlobal.sharedInstance.getTodayDate(singleArray.object(forKey: "comment_date") as! String as NSString)
        timeLbl.font = SMLGlobal.sharedInstance.fontSize(10)
        print(singleArray)
        print(timeStr)
        let timeLength : (CGSize) = timeStr.boundingRect(with: CGSize(width: lbl/2, height: 999), options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : timeLbl.font], context: nil).size
        timeLbl.frame = CGRect(x: 108, y: 5.0, width: timeLength.width + 5 , height: 15)
        
       
        timeLbl.text = SMLGlobal.sharedInstance.getTodayDate(singleArray.object(forKey: "comment_date") as! NSString) as String
     
        timeLbl.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        meetingBackView.addSubview(timeLbl)
        
        let commentLbl : UILabel = UILabel()
        commentLbl.numberOfLines = 0
        commentLbl.font = SMLGlobal.sharedInstance.fontSize(10)
      
        let commentHeight:CGFloat = Constants.myGlobalFunction.heightOfCommentRow(commentStr, font: SMLGlobal.sharedInstance.fontSize(10),height:commentTableView.frame.size.width - 65.0)
        
        commentLbl.frame = CGRect(x: imgView.frame.maxX + 5, y: timeLbl.frame.maxY + 2.0, width: commentTableView.frame.size.width - 65, height: commentHeight)
        
        commentLbl.text = singleArray.object(forKey: "comment")   as! NSString as String
        
        commentLbl.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        meetingBackView.addSubview(commentLbl)
        
        let deleteButton : (UIButton) = UIButton.init(type: UIButtonType.custom)
        deleteButton.setImage(UIImage(named: "cross1"), for: UIControlState())
        deleteButton.frame = CGRect(x: meetingBackView.frame.width - 21, y: (meetingBackView.frame.height/2.0)-10.0 , width: 20, height: 20)
        deleteButton.tag = (indexPath as NSIndexPath).row
        deleteButton .addTarget(self, action: #selector(publicPictureViewController.deleteData(_:)), for: UIControlEvents.touchUpInside)
        
        let user : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = user.userName
        //println(loginId)
       // println(userName)
        if userName == loginId
        {
            meetingBackView.addSubview(deleteButton)
        }
      
        
        
        
       
        
        
        let line = UIView()
        line.frame = CGRect(x: 0, y: meetingBackView.frame.size.height - 1, width: meetingBackView.frame.width, height: 1)
        line.backgroundColor = UIColor(red: 0 / 255 , green: 0 / 255, blue: 0 / 255, alpha: 0.1)
        meetingBackView.addSubview(line)
        cell!.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        
        
        // tableView.rowHeight = CGRectGetMaxY(line.frame) + 3
        
        //tableHeight = height
        return cell!
    }
    
       
    //MARK:- heightForRowAtIndexPath
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        let singleArray : (NSDictionary) = self.tableViewArray.object(at: (indexPath as NSIndexPath).row) as! (NSDictionary)
        let commentStr : (NSString) = (singleArray.object(forKey: "comment") as? String)! as (NSString)
        var height:CGFloat = Constants.myGlobalFunction.heightOfCommentRow(commentStr, font: SMLGlobal.sharedInstance.fontSize(10),height:commentTableView.frame.size.width - 65.0)
        height+=27.0
        if(height<=40.0)
        {
            return 40.0
        }
        return height
    }
     //MARK:- textFieldShouldReturn
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //var commentView = UIScrollView()
        if ScreenSize.height == 480
        {
        picView.contentOffset = CGPoint(x: 0, y: 70)
        // picView.contentSize = CGSizeMake(picView.frame.size.width, picView.frame.size.height+200)
        
        }
        textField.resignFirstResponder()
        descriptionText.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        let i = 0
        let tagValue : CGFloat =  CGFloat(textField.tag)
        if i == 0
        {
            if(ScreenSize.height == 667)
            {
                picView.contentOffset = CGPoint(x: 0,y: tagValue * 140);
            }
            else
            {
                
                picView.contentOffset = CGPoint(x: 0,y: tagValue * 210);
            }
            
          
            
            picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.frame.size.height+250)
            
            
            
            
            if ScreenSize.height == 480 {
                picView.contentOffset = CGPoint(x: 0,y: tagValue * 300);
                picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.frame.size.height+300)
            }

        }
        
        else
        {
            
        }
        return
    }
    
       func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        descriptionText.resignFirstResponder()
        
      
        
        if ScreenSize.height == 480
        {
            //picView.contentSize = CGSizeMake(ScreenSize.width, picView.frame.size.height-200)
        } else {
              picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height-250)
        }

        return true
    }
    func  touchesBegan(_ touches: Set<NSObject>, with event: UIEvent)
    {
        
        view.endEditing(true)
        super.touchesBegan(touches as! Set<UITouch>, with: event)
    }
    //MARK:- time stamp
    func printTimestamp() {
        timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
       // println(timestamp)
        
    }
    
    func addCommentAction(_ sender: UIButton)
    {
        
        
        comVal()
        //http://112.196.34.179/stepslocator/index.php/login/wsAddMotivationalImageComment?user_id=&comment=&image_id=
        if commentTextField.text == "" || firstBlnkValue == 1
        {
            let alertView : (UIAlertView) = UIAlertView(title: "", message: "Please enter comment", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            commentTextField.text = ""
        }
        else
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
           
            self.textFieldDidEndEditing(commentTextField)
            SVProgressHUD.show(withStatus: "Loading", maskType: SVProgressHUDMaskType.black)
            let user : (SMLAppUser) = SMLAppUser.getUser()
            let loginId : (NSString) = user.userId
            let imageId  : (NSString) = singleDict.object(forKey: "id") as! NSString
            let parameters : (NSDictionary) = ["user_id" : loginId,
                "comment" : commentTextField.text! as NSString,
                "image_id" : imageId]
            WebserviceManager.sharedInstance.addMotivationalImageComment(params: parameters) { (responseObject, error) in
                if responseObject != nil
                {
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                    if success == 0
                    {
                        //                var alertView = UIAlertView(title: "", message:message as NSString as String, delegate: nil, cancelButtonTitle: "Ok")
                        //                alertView.show()
                        SVProgressHUD .dismiss()
                    }
                    else if success == 1
                    {
                        let alertView = UIAlertView(title: "", message:message as NSString as String, delegate: self, cancelButtonTitle: "Ok")
                        alertView.show()
                        self.commentTextField.text = ""
                        self.picView.contentOffset = CGPoint(x: 0, y: 0)
                        self.listAllComments(0)
                        SVProgressHUD .dismiss()
                        
                    }
                    //self.imageTitleText.resignFirstResponder()
                    self.descriptionText.resignFirstResponder()
                    self.commentTextField.resignFirstResponder()
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
    
    
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if ScreenSize.height == 480 {
            picView.contentOffset = CGPoint(x: 0, y: 0)
             picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height-170)
        } else {
              picView.contentOffset = CGPoint(x: 0, y: 0)
        picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height-200)
        }
    }

    
    func deleteData(_ sender:UIButton)
    {
        let alertView = UIAlertView(title: "", message: "Do you want to delete this comment?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
        alertView.tag = sender.tag
        alertView.show()
    }
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
            self.textFieldDidEndEditing(commentTextField)
            SVProgressHUD.show(withStatus: "Loading")
            //http://112.196.34.179/stepslocator/index.php/login/wsDeleteComment?commentId=
            let dictValue  : (NSDictionary) = self.tableViewArray.object(at: alertView.tag) as! NSDictionary
            let commentId : (NSString) = (dictValue.object(forKey: "comment_id") as? String)! as (NSString)
            //var commentId  : (NSString) = imageDict.objectForKey("id") as! NSString
            let parameters : (NSDictionary) = ["commentId" : commentId,
            ]
            WebserviceManager.sharedInstance.displayCommentsList(params: parameters) { (responseObject, error) in
                if responseObject != nil
                {
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    let message : NSString = responseObject!.value(forKey: "message") as! NSString
                    if success == 0
                    {
                        SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                        SVProgressHUD .dismiss()
                    }
                    else if success == 1
                    {
                        SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                        alertView.show()
                        SVProgressHUD .dismiss()
                        
                        self.listAllComments(0)
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
//    func whiteSpaceCheck() ->Bool {
//        var textField = UITextField()
//        var val = 5
//        
//        var rawString: NSString = commentTextField.text
//
//        var whitespace: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()
//        var trimmed: NSString = rawString.stringByTrimmingCharactersInSet(whitespace)
//        val = trimmed.length
//        println(trimmed)
//        var numberOfSpaces = count(commentTextField.text.componentsSeparatedByString(" "))
//      
//        
//        println(numberOfSpaces)
//        if firstBlnkValue == 1 {
//            var alertView = UIAlertView (title: "", message: "Please enter comment", delegate: nil, cancelButtonTitle: "OK")
//            alertView.show();
//            commentTextField.text = ""
//            return false;
//            
//        } else {
//            return true;
//        }
//    }
    func listAllComments(_ lastId : Int)
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        SVProgressHUD.show(withStatus: "Loading")
        //http://104.236.197.214/index.php/login/wsListComments?image_id=42&limit=0
        
        let imageId  : (NSString) = singleDict.object(forKey: "id") as! NSString
        let parameters : (NSDictionary) = ["image_id" : imageId,
            "limit" : lastId]
        WebserviceManager.sharedInstance.displayCommentsList(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if success == 0
                {
                    self.noLabel  = UILabel()
                    self.noLabel.frame = CGRect(x: 0, y: 45 , width: ScreenSize.width, height: 50)
                    self.noLabel.text = "No Comments"
                    self.noLabel.font = SMLGlobal.sharedInstance.fontSize(12)
                    self.noLabel.textAlignment = NSTextAlignment.center
                    self.noLabel.textColor = UIColor.lightGray
                    self.commentView.addSubview(self.noLabel)
                    
                    let lineView : (UIView) = UIView()
                    lineView.frame = CGRect.zero
                    self.commentTableView.tableFooterView = lineView
                    self.tableViewArray = NSMutableArray()
                    self.commentTableView.reloadData()
                    SVProgressHUD .dismiss()
                }
                    
                else if success == 1
                {
                    self.noLabel.removeFromSuperview()
                    let jsonUnico : NSArray = responseObject?["data"] as! NSArray
                    
                        self.totalCount = responseObject?.value(forKey: "commentsCount") as! Int
//                        if(self.tableViewArray.count < 10)
//                        {
//                            self.tableViewArray = jsonUnico as! NSArray
//                        }
//                        else
//                        {
                            let newArray : (NSMutableArray) = self.tableViewArray.mutableCopy() as! NSMutableArray
                            for i in 0..<jsonUnico.count
                            {
                                print(jsonUnico)
                                let ids : (NSString) = (jsonUnico.object(at: i) as AnyObject).value(forKey: "comment_id") as! NSString
                                //var predicate : (NSPredicate) = NSPredicate(format: "%@", ids)
                                let predicate : (NSPredicate) = NSPredicate(format: "SELF.comment_id == %@", ids)
                                var arr : (NSArray) = jsonUnico as NSArray
                                arr = self.tableViewArray.filtered(using: predicate) as (NSArray)
                                if(arr.count == 0)
                                {
                                    print(self.tableViewArray)
                                    let val = jsonUnico.object(at: i)
                                    print(val)
                                    newArray.add(val)
                                }
                                print(self.tableViewArray)
                            //}
                        }
                        self.tableViewArray = newArray.mutableCopy() as! NSMutableArray
                        let descriptor = NSSortDescriptor(key: "comment_date", ascending: false)
                        let sortedArray = self.tableViewArray.sortedArray(using: [descriptor])
                        self.tableViewArray = (sortedArray as? NSMutableArray)!
                        //self.tableViewArray = responseObject.valueForKey("data") as! NSMutableArray
                        // println(self.tableViewArray.count)
                        self.commentTableView.reloadData()
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
    
    func comVal() {
        
        let str = commentTextField.text! as NSString
       
        let d = 32 as unichar
        if (commentTextField.text?.characters.count)! > 2 {
            
            if str == "" {
                firstBlnkValue = 0
                
                //println("Sk Rejabul")
            } else {
                let c:unichar = str.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    firstBlnkValue = 1
                    
                } else {
                    firstBlnkValue = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if commentTextField.text?.characters.count == 1 {
            
            let c:unichar = str.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue = 1
                
            } else {
                firstBlnkValue = 0
                
            }
        }
        
    }
}
