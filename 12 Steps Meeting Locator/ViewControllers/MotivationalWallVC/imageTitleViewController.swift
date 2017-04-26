//
//  imageTitleViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 25/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class imageTitleViewController: UIViewController,  UITextFieldDelegate, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate,UINavigationControllerDelegate, UIActionSheetDelegate,UIAlertViewDelegate  {
    
    var uilbl = UIView()
    var addPictureNav: UIView!
    var picView : UIScrollView!
    var picImageView : UIImageView!
     var commentView = UIScrollView()
     var commentTabView = UIScrollView()
    var  appUser : (SMLAppUser) = SMLAppUser.getUser()
      var descriptionText : UITextView = UITextView()
    var imageTitleText : UITextField = UITextField()
    var timestamp: String!
    var firstBlnkValue = 0
    var noLabel : (UILabel) = UILabel()
    var textViewVal = 0
    var totalCount : (Int) = 0
    var updateButton: UIButton = UIButton()
    var imgButton : (UIButton)!
    var  comVal = 0
    var  comVal1 = 0
    var  desVal = 0
    var imageTitleTextString : (NSMutableString)!
    
    
    
    
    var commentTextField : UITextField!
    
    
    var imageDict  : (NSDictionary)!
    
    var tableViewArray = NSMutableArray()
    
    
    var uiView : UIButton!
    var commentTableView :UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        
        self.listAllComments(0)
        self.createUI()
    }
    
    func createUI()
    {
        addPictureNav = UIView()
        addPictureNav.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 60)
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
        leftHomeButton.addTarget(self, action: #selector(imageTitleViewController.homeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addPictureNav.addSubview(leftHomeButton)
        
        let meetingNodeTitel: UILabel = UILabel()
        meetingNodeTitel.text = imageDict.object(forKey: "image_title") as! String?
        meetingNodeTitel.font = SMLGlobal.sharedInstance.fontSize(14)
        meetingNodeTitel.textAlignment = .center
        meetingNodeTitel.frame = CGRect(x: (ScreenSize.width - 200) / 2, y: 32, width: 200, height: 20)
        meetingNodeTitel.textColor = UIColor.white
        
        addPictureNav.addSubview(meetingNodeTitel)
        
        
        
        let addButton: UIButton = UIButton()
        
        addButton.addTarget(self, action: #selector(imageTitleViewController.addButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //rightButton.backgroundColor = UIColor.whiteColor()
        let rightButtonImage: UIImage = UIImage(named: "add_icon")!
        addButton.frame = CGRect(x: ScreenSize.width - 44, y: 25, width: 31, height: 32)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addButton.setBackgroundImage(rightButtonImage, for: UIControlState())
        addPictureNav.addSubview(addButton)
        
        
        //        var screenMid = ScreenSize.width / 2
        //        meetingNodeTitel.frame = CGRectMake((ScreenSize.width - 130) / 2, sgmentViewHeight / 4, 130, 30)
        
        
        picView = UIScrollView()
        picView.frame = CGRect(x: 0, y: addPictureNav.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - 60)
        picView.backgroundColor = UIColor.white
        picView.isScrollEnabled = true
        picView.bounces = false
        self.view.addSubview(picView)
        
        
        
        
        picImageView = UIImageView()
        picImageView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: (ScreenSize.height / 4) - 15)
        
        let picImageStr : (NSString)  = imageDict.object(forKey: "img_names") as! NSString
        if picImageStr == ""
        {
            
        }
        else
        {
            let picUrl : (URL)  = URL(string: NSString(format: "%@%@", motivationalImagesUrl,picImageStr) as String)!
            picImageView.sd_setImage(with: picUrl, placeholderImage: UIImage(named: ""))
            
        }
        
         picImageView.contentMode = UIViewContentMode.scaleAspectFit
        picImageView.isUserInteractionEnabled = false
        //picImageView.image = UIImage(named: "camera")
        picImageView.backgroundColor = UIColor(red: 54 / 255, green: 54 / 255, blue: 54 / 255, alpha: 1)
        picView.addSubview(picImageView)
        
        uiView = UIButton()
        uiView.frame = CGRect(x: (picImageView.frame.width - 150) / 2, y: (picImageView.frame.height - 100) / 2, width: 150, height: 100)
        // uiView.setImage(cam, forState: .Normal)
        picImageView.addSubview(uiView)
        
        
        uilbl.frame = CGRect(x: picImageView.frame.width - 30, y: picImageView.frame.height - 27, width: 25, height: 22)
        uilbl.layer.borderWidth = 1
        uilbl.layer.cornerRadius = 5
        uilbl.layer.borderColor = UIColor.clear.cgColor
        uilbl.isUserInteractionEnabled = true
        uilbl.backgroundColor = UIColor(red: 87 / 255, green:  87 / 255, blue:  87 / 255, alpha: 1)
        picView.addSubview(uilbl)
        
        
        
        imgButton = UIButton()
        imgButton.frame = CGRect(x: 2, y: 2, width: 20.5, height: 18)
        let cam1 = UIImage(named: "cam_icon")
        imgButton.isUserInteractionEnabled = false
        //        imgButton.layer.borderWidth = 1
        //        imgButton.layer.cornerRadius = 5
        imgButton.setBackgroundImage(cam1, for: UIControlState())
        imgButton.addTarget(self, action: #selector(imageTitleViewController.imgClick(_:)), for: UIControlEvents.touchUpInside)
        uilbl.addSubview(imgButton)
        //        var tapGesture = UITapGestureRecognizer(target: self, action: "profileGesture:")
        //        uilbl.addGestureRecognizer(tapGesture)
        
        let imageTitleLabel : UILabel = UILabel()
        imageTitleLabel.frame = CGRect(x: 30, y: picImageView.frame.maxY + 5 , width: 100, height: 20)
        imageTitleLabel.text = "Image Title"
        imageTitleLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        imageTitleLabel.textColor = UIColor(red: 0.0 / 255, green:  0.0 / 255, blue:  0.0 / 255, alpha: 0.5)
        
        picView.addSubview(imageTitleLabel)
        
        
        imageTitleText.frame = CGRect(x: 30, y: imageTitleLabel.frame.maxY , width: ScreenSize.width - 60, height: 25)
        //meetingTitleText.placeholder = " Lorem Ipsum"
        imageTitleText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        imageTitleText.font = SMLGlobal.sharedInstance.fontSize(10)
        //meetingTitleText.returnKeyType=UIReturnKeyType.Next
        imageTitleText.layer.borderWidth = 1
        imageTitleText.tag = 0;
        imageTitleText.delegate = self
        imageTitleText.isEnabled = false
        imageTitleText.layer.cornerRadius = imageTitleText.frame.width * 0.015
        imageTitleText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        
        let imageTitle : (NSString) = imageDict.object(forKey: "image_title") as! NSString
        imageTitleText.text = imageTitle as String
        picView.addSubview(imageTitleText)
        
        let leftView : UIView = UIView()
        leftView.frame = CGRect(x: 5, y: 0, width: 5, height: 25)
        imageTitleText.leftView = leftView
        imageTitleText.leftViewMode = UITextFieldViewMode.always;
        
        let descriptionLabel : UILabel = UILabel()
        descriptionLabel.frame = CGRect(x: 30, y: imageTitleText.frame.maxY + 3, width: 100, height: 20)
        descriptionLabel.text = "Description"
        descriptionLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        descriptionLabel.textColor = UIColor(red: 0.0 / 255, green:  0.0 / 255, blue:  0.0 / 255, alpha: 0.5)
        
        picView.addSubview(descriptionLabel)
        
        
        descriptionText.frame = CGRect(x: 30, y: descriptionLabel.frame.maxY , width: ScreenSize.width - 60, height: 51)
        //meetingTitleText.placeholder = " Lorem Ipsum"
        descriptionText.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        descriptionText.font = SMLGlobal.sharedInstance.fontSize(10)
        //meetingTitleText.returnKeyType=UIReturnKeyType.Next
        descriptionText.layer.borderWidth = 1
        descriptionText.tag = 0;
        descriptionText.isEditable = false
        descriptionText.delegate = self
        descriptionText.layer.cornerRadius = descriptionText.frame.width * 0.015
        descriptionText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        let imageDesc : (NSString) = imageDict.object(forKey: "image_description") as! NSString
        descriptionText.text = imageDesc as String
        picView.addSubview(descriptionText)
        
        let leftView1 : UIView = UIView()
        leftView1.frame = CGRect(x: 0, y: 0, width: 5, height: 51)
        descriptionText.addSubview(leftView1)
        
        
        commentView.frame = CGRect(x: 0, y: descriptionText.frame.maxY + 10 , width: ScreenSize.width, height: 210)
        // commentView.backgroundColor = UIColor.lightGrayColor()
        picView.addSubview(commentView)
        
        
        let commentLabel : UILabel = UILabel()
        commentLabel.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 20)
        commentLabel.text  = "\t Comments"
        commentLabel.backgroundColor = UIColor(red: 0 / 255, green: 136 / 255, blue: 206 / 255, alpha: 1)
        commentLabel.textColor = UIColor.white
        commentLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        commentView.addSubview(commentLabel)
        
        //commentTabView.frame = CGRectMake(30, CGRectGetMaxY(commentLabel.frame) , ScreenSize.width - 30, 169)
        //commentTabView.backgroundColor = UIColor.redColor()
        //commentView.addSubview(commentTabView)
        
        
        
        uilbl.isHidden = true
        
        commentTableView = UITableView()
        
//        if(self.tableViewArray.count <= 3)
//        {
//            
//            var count : (Int) = self.tableViewArray.count * 50
//            var f : (CGFloat) = CGFloat(count)
//            //  var count : (Int) = (self.tableViewArray.count * 50 as? Int)!
//            self.commentTableView.frame = CGRectMake(30,CGRectGetMaxY(commentLabel.frame), ScreenSize.width - 30, f)
//        }
//        else
//        {
//            self.commentTableView.frame = CGRectMake(30, CGRectGetMaxY(commentLabel.frame), ScreenSize.width - 30, 140)
//        }
        
        
        commentTableView.frame = CGRect(x: 30, y: commentLabel.frame.maxY, width: ScreenSize.width - 60,height: 140)
        commentTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        //commentView.addSubview(commentTableView)
        commentTableView.bounces = false
        commentTableView.delegate = self
        commentTableView.dataSource = self
        commentView.addSubview(commentTableView)
        
        
        let footerView : (UIView) = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 50)
        
        
        let showMoreBtn  : (UIButton) = UIButton.init(type: UIButtonType.custom)
        showMoreBtn.frame = CGRect(x: 0, y: 0,width: ScreenSize.width , height: 50)
        footerView.addSubview(showMoreBtn)
        showMoreBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(10)
        showMoreBtn.setTitle("Show More Results", for: UIControlState())
        showMoreBtn.addTarget(self, action: #selector(imageTitleViewController.showMoreBtn(_:)), for: .touchUpInside)
        showMoreBtn.setTitleColor(UIColor.red, for: UIControlState())
        //commentTableView.tableFooterView = footerView
        
        
        if self.tableViewArray.count >= 10
        {
            commentTableView.tableFooterView?.isHidden = false
        }
        else
        {
            commentTableView.tableFooterView?.isHidden = true
        }
        
        let commentSearchBar = UIView()
        commentSearchBar.frame = CGRect(x: 40, y: commentTableView.frame.maxY + 10, width: ScreenSize.width - 80, height: 30)
        commentSearchBar.backgroundColor = UIColor(red: 206 / 255, green: 206 / 255, blue: 206 / 255, alpha: 1)
        commentView.addSubview(commentSearchBar)
        
        commentTextField  = UITextField()
        commentTextField.frame = CGRect(x: 3, y: 5, width: commentSearchBar.frame.width - 50, height: 20)
        commentTextField.placeholder = "\t Add Comment...."
        
        commentTextField.backgroundColor = UIColor.white
        commentTextField.font = SMLGlobal.sharedInstance.fontSize(10)
        commentTextField.layer.borderWidth = 1
        commentTextField.layer.cornerRadius = 5
        commentTextField.tag = 1
        commentTextField.layer.borderColor = UIColor.clear.cgColor
        commentSearchBar.addSubview(commentTextField)
        
        
        
        let leftViewText = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        commentTextField.leftView = leftViewText
        commentTextField.leftViewMode  = UITextFieldViewMode.always
        
        commentTextField.delegate = self
        
        
        let addComment: UIButton = UIButton()
        addComment.frame = CGRect(x: commentTextField.frame.maxX + 5, y: 5, width: 35, height: 20)
        let commAddImage = UIImage(named: "button_add")
        addComment.setImage(commAddImage, for: UIControlState())
        addComment.addTarget(self, action: #selector(imageTitleViewController.addCommentAction(_:)), for: UIControlEvents.touchUpInside)
        commentSearchBar.addSubview(addComment)
        //picView.backgroundColor = UIColor.redColor()
        
        //var yPoint = picView.frame.height - 30
        var yPoint = commentView.frame.maxY + 10
        var btn = CGFloat(90)
        if ScreenSize.height == 667
        {
            yPoint = picView.frame.height - 100
            btn = 111
        }
        
        
        btn = (ScreenSize.width - 50)/3
        
        updateButton.frame = CGRect(x: 20, y: yPoint, width: btn, height: 35)
        updateButton.setTitle("Edit", for: UIControlState())
        updateButton.setTitleColor(UIColor.white, for: UIControlState())
        updateButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        updateButton.layer.cornerRadius = 2.0
        updateButton.backgroundColor = NavigationColor
        //var img2 = UIImage(named: "send")
        //updateButton.setBackgroundImage(img2, forState: .Normal)
        updateButton.addTarget(self, action: #selector(imageTitleViewController.saveAction(_:)), for: UIControlEvents.touchUpInside)
        picView.addSubview(updateButton)
        //var b = CGRectGetMaxY(commentView.frame.height) as CGFloat
       // println(ScreenSize.height - 50)
       // println(butWidt)
        
        
        let deleteButton: UIButton = UIButton()
        deleteButton.frame = CGRect(x: updateButton.frame.maxX + 5 , y: yPoint, width: btn, height: 35)
        deleteButton.setTitle("Delete", for: UIControlState())
        deleteButton.setTitleColor(UIColor.white, for: UIControlState())
        deleteButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        deleteButton.layer.cornerRadius = 2.0
        deleteButton.backgroundColor = ButtonRedColor
        //var img3 = UIImage(named: "delete")
        //deleteButton.setBackgroundImage(img3, forState: .Normal)
        deleteButton.addTarget(self, action: #selector(imageTitleViewController.deleteBtnAction(_:)), for: UIControlEvents.touchUpInside)
        picView.addSubview(deleteButton)
        
        let cancleButton: UIButton = UIButton()
        cancleButton.frame = CGRect(x: deleteButton.frame.maxX + 5, y: yPoint, width: btn, height: 35)
        cancleButton.setTitle("Cancel", for: UIControlState())
        cancleButton.setTitleColor(UIColor.white, for: UIControlState())
        cancleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        cancleButton.layer.cornerRadius = 2.0
        cancleButton.backgroundColor = ButtonBlueColor
        // var img1 = UIImage(named: "cancel")
        //cancleButton.setBackgroundImage(img1, forState: .Normal)
        cancleButton.addTarget(self, action: #selector(imageTitleViewController.cancleAction(_:)), for: UIControlEvents.touchUpInside)
        picView.addSubview(cancleButton)
        
        picView.contentSize = CGSize(width: ScreenSize.width, height: cancleButton.frame.maxY+20)
        
        
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(imageTitleViewController.deleteText), name: NSNotification.Name.UITextFieldTextDidChange, object: imageTitleText)
        NotificationCenter.default.addObserver(self, selector: #selector(imageTitleViewController.deltextView), name: NSNotification.Name.UITextViewTextDidChange, object: descriptionText)
        
    }
    func deleteText() {
        if imageTitleText.text?.characters.count == 0 {
            firstBlnkValue = 0
            imageTitleText.text = ""
            
        }
    }
    func deltextView() {
        
        if descriptionText.text.characters.count == 0 {
            textViewVal = 0
            descriptionText.text = ""
            
        }
        print(descriptionText.text)
        
    }
    func showMoreBtn(_ sender:UIButton)
    {
        
    }
    
    func deleteBtnAction(_ sender:UIButton)
    {
        
        let alertView = UIAlertView(title: "", message: "Do you want to delete this image?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
        alertView.tag = 100
        alertView.show()
       //http://112.196.34.179/stepslocator/index.php/login/wsDeleteMotivationalImage?imageId=
    }
    
    func saveImageData()
    {
      SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
      comValidation()
        
        //http://112.196.34.179/stepslocator/index.php/login/wsUpdateMotivationalImage?image_id=&image_title=&image_description=&image=
        if(self.checkAllTextFields())
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
           
        let picImageStr : (NSString)  = imageDict.object(forKey: "img_names") as! NSString
        let picUrl : (URL)  = URL(string: NSString(format: "%@%@",motivationalImagesThumbUrl, picImageStr) as String)!
        ///picImageView.sd_setImageWithURL(picUrl, placeholderImage: UIImage(named: ""))
        let previousImage : (UIImageView) = UIImageView()
        previousImage.sd_setImage(with: picUrl)
        var imageStr : (NSString)!
        if(picImageView.image == previousImage.image)
        {
            imageStr = ""
        }
        else
        {
            let PImage = picImageView.image!
            let imageData = UIImagePNGRepresentation(PImage)
            let base64String : (NSString) = (imageData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters))! as String as NSString
            imageStr = base64String
        }
        let imageId  : (NSString) = imageDict.object(forKey: "id") as! NSString
        let parameters : (NSDictionary) = ["image_id" : imageId,
            "image_description" : descriptionText.text! as NSString,
            "image_title" : imageTitleText.text! as NSString,
            "image" : imageStr]
            
            WebserviceManager.sharedInstance.updateMotivationalImage(params: parameters, withCompletionBlock: { (responseObject, error) in
                
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
                        SVProgressHUD .dismiss()
                    }
                }
                else
                {
                    SVProgressHUD .dismiss()
                }
            })
            }
            else
            {
                SMLGlobal.sharedInstance.NOINTERNETALERT(self)
            }
        }
        else
        {
             SVProgressHUD .dismiss()
            if(updateButton.title(for: UIControlState()) == "Edit")
            {
                updateButton.setTitle("Save", for: UIControlState())
                uilbl.isHidden = false
                imageTitleText.isEnabled = true
                descriptionText.isEditable = true
                picImageView.isUserInteractionEnabled = true
                imgButton.isUserInteractionEnabled = true
            }
        }
        SVProgressHUD .dismiss()
    }
    
    
    func checkAllTextFields() -> Bool
    {
        if(picImageView.image == UIImage(named: "background"))
        {
            let alertView = UIAlertView(title: "", message: "Please choose Image", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            return false
        }
        else if(imageTitleText.text == "" || comVal1 == 1)
        {
            let alertView = UIAlertView(title: "", message: "Please enter Image Title", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            imageTitleText.text = ""
            return false
        }
        else if(descriptionText.text == "" || desVal == 1)
        {
            let alertView = UIAlertView(title: "", message: "Please enter Image Description", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            descriptionText.text = ""
            return false
        }
        else
        {
            return true
        }
        
    }

    func saveAction(_ sender:UIButton)
    {
        
        let btn : (UIButton) = sender
        if(btn.title(for: UIControlState()) == "Edit")
        {
            btn.setTitle("Save", for: UIControlState())
            uilbl.isHidden = false
            imageTitleText.isEnabled = true
            descriptionText.isEditable = true
            picImageView.isUserInteractionEnabled = true
            imgButton.isUserInteractionEnabled = true
            
        }
        else
        {
            btn.setTitle("Edit", for: UIControlState())
            imageTitleText.isEnabled = false
            uilbl.isHidden = true
            descriptionText.isEditable = false
            picImageView.isUserInteractionEnabled = false
            imgButton.isUserInteractionEnabled = false
            self.saveImageData()
        }

    }
    
    
    func cancleAction(_ sender:UIButton)
    {
        self.navigationController?.popViewController(animated: false)
    }
    
    
    // MARK:- Webervice Methods
    
    
    func listAllComments(_ lastId : Int)
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
       // SVProgressHUD.showWithStatus("Loading")
        SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        //http://112.196.34.179/stepslocator/index.php/login/wsListComments?image_id=&limit=0
        let imageId  : (NSString) = imageDict.object(forKey: "id") as! NSString
        let parameters : (NSDictionary) = ["image_id" : imageId,
            "limit" : lastId]
        
        WebserviceManager.sharedInstance.displayCommentsList(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if success == 0
                {
                    self.noLabel  = UILabel()
                    //commentTableView.frame = CGRectMake(0, 0, commentTabView.frame.size.width,140)
                    self.noLabel.frame = CGRect(x: 0, y: 45 , width: ScreenSize.width, height: 50)
                    self.noLabel.text = "No Comments"
                    self.noLabel.font = SMLGlobal.sharedInstance.fontSize(12)
                    self.noLabel.textAlignment = NSTextAlignment.center
                    self.noLabel.textColor = UIColor.lightGray
                    //self.commentTableView.hidden = true
                    self.commentView.addSubview(self.noLabel)
                    self.tableViewArray = NSMutableArray()
                    let lineView : (UIView) = UIView()
                    lineView.frame = CGRect.zero
                    self.commentTableView.tableFooterView = lineView
                    self.commentTableView.reloadData()
                    SVProgressHUD .dismiss()

                }
                else if success == 1
                {
                    self.noLabel.removeFromSuperview()
                    self.commentTableView.tableFooterView?.frame = CGRect(x: 0, y: 0, width: self.commentTableView.frame.size.width, height: 50)
                    let jsonUnico : (NSArray) = responseObject?["data"] as! NSArray
                        self.totalCount = responseObject?.value(forKey: "commentsCount") as! Int
//                        if(self.tableViewArray.count <= 10)
//                        {
////                            self.tableViewArray = jsonUnico
//                        }
//                        else
//                        {
                            let newArray : (NSMutableArray) = self.tableViewArray.mutableCopy() as! NSMutableArray
                            for i in 0..<jsonUnico.count
                            {
                                let ids : (NSString) = (jsonUnico.object(at: i) as AnyObject).value(forKey: "comment_id") as! NSString
                                //var predicate : (NSPredicate) = NSPredicate(format: "%@", ids)
                                let predicate : (NSPredicate) = NSPredicate(format: "SELF.comment_id == %@", ids)
                                var arr : (NSArray) = jsonUnico as NSArray
                                arr = self.tableViewArray.filtered(using: predicate) as (NSArray)
                                if(arr.count == 0)
                                {
                                    newArray.add(jsonUnico.object(at: i))
                                }
                                //self.tableViewArray = arr.mutableCopy() as! (NSMutableArray)
                            }
                        self.tableViewArray = newArray.mutableCopy() as! NSMutableArray
                    
                        //}
                    let descriptor = NSSortDescriptor(key: "comment_date", ascending: false)
                    let sortedArr  = self.tableViewArray.sortedArray(using: [descriptor])
                    self.tableViewArray  = sortedArr as! NSMutableArray                    // println(self.tableViewArray.count)
                    self.commentTableView.reloadData()
                    
                    //                if(self.tableViewArray.count > 10)
                    //                {
                    //                    self.commentTableView.tableFooterView?.hidden = false
                    //                }
                    //                else
                    //                {
                    //                    self.commentTableView.tableFooterView?.hidden = true
                    //                }
                    //self.commentTableView.reloadData()
                    
                    //                var alertView = UIAlertView(title: "", message:message as NSString as String, delegate: self, cancelButtonTitle: "Ok")
                    //                alertView.show()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func homeButtonClick(_ sender: UIButton) {
        navigationItem.hidesBackButton = true
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
        
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
        let timeStr : (NSString)  = SMLGlobal.sharedInstance.getTodayDate((singleArray.object(forKey: "comment_date") as? String)! as NSString)
        let timeLength : (CGSize) = timeStr.boundingRect(with: CGSize(width: lbl/2, height: 999), options:NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : timeLbl.font], context: nil).size
        timeLbl.frame = CGRect(x: 108, y: 5.0, width: timeLength.width + 5 , height: 15)
        
        
        timeLbl.text = SMLGlobal.sharedInstance.getTodayDate(singleArray.object(forKey: "comment_date") as! NSString) as String
        
        timeLbl.font = SMLGlobal.sharedInstance.fontSize(10)
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
        deleteButton .addTarget(self, action: #selector(imageTitleViewController.deleteData(_:)), for: UIControlEvents.touchUpInside)
        
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
       // println(self.tableViewArray)
        if(self.tableViewArray.count<self.totalCount)
        {
        self.listAllComments(self.tableViewArray.count)
        }
        
   
    }
    

    
  
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       print(self.tableViewArray)
        if self.tableViewArray.count > 0
        {
            
            let singleArray : (NSDictionary) = self.tableViewArray.object(at: indexPath.row) as! (NSDictionary)
//            var singleArray : (NSDictionary) = self.tableViewArray.object(at: (indexPath as NSIndexPath).row) as! (NSDictionary)
            let commentStr : (NSString) = (singleArray.object(forKey: "comment") as? String)! as (NSString)
            var height:CGFloat = Constants.myGlobalFunction.heightOfCommentRow(commentStr, font: SMLGlobal.sharedInstance.fontSize(10),height:commentTableView.frame.size.width - 65.0)
            height+=27.0
            if(height<=40.0)
            {
                return 40.0
            }
            return height
        }
        else
        {
            return 44.0;
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
         //var commentView = UIScrollView()
       // picView.contentOffset = CGPointMake(0, 0)
        descriptionText.resignFirstResponder()
        //commentTabView.contentOffset = CGPointMake(0, 0)
        
        textField.resignFirstResponder()
       
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
                //commentTabView.contentOffset = CGPointMake(0, 140);
            }
            picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height+200)
            
            if ScreenSize.height == 480 {
                picView.contentOffset = CGPoint(x: 0,y: tagValue * 300);
                picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height+300)
            }

            
        }
        
        
    
        
        return
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height-200)
        
        if ScreenSize.height == 480 {
            
            picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height-300)
        }
    }
    
    func printTimestamp() {
        timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        //println(timestamp)
        
    }
    
    
    func addButtonClick(_ sender:UIButton)
    {
        let addPic : (addNewPictureViewController) = addNewPictureViewController()
        self.navigationController?.pushViewController(addPic, animated: false)
    }
    
    func addCommentAction(_ sender: UIButton)
    {
         comval()
        //http://112.196.34.179/stepslocator/index.php/login/wsAddMotivationalImageComment?user_id=&comment=&image_id=
        print(firstBlnkValue)
        
        if commentTextField.text == "" || comVal == 1
        {
            let alertView : (UIAlertView) = UIAlertView(title: "", message: "Please enter comment", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            commentTextField.text = ""
            firstBlnkValue = 0
        }
        else
        {
           
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
           
      //self.textFieldDidEndEditing(commentTextField)
        //SVProgressHUD.showWithStatus("Loading")
            SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        let user : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = user.userId
        
        let imageId  : (NSString) = imageDict.object(forKey: "id") as! NSString
        let parameters : (NSDictionary) = ["user_id" : loginId,
            "comment" : commentTextField.text! as NSString,
            "image_id" : imageId]
        print(parameters)
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
                        // var arr : (NSArray) = responseObject.valueForKey("data") as! NSArray
                        //                if(self.tableViewArray.count>0)
                        //                {
                        //
                        //                    //self.tableViewArray = self.tableViewArray.addObjectsFromArray(arr as [AnyObject])
                        //                }
                        //                else
                        //
                        //                {
                        //                    self.tableViewArray = arr.mutableCopy() as! NSMutableArray
                        //                }
                        let alertView = UIAlertView(title: "", message:message as NSString as String, delegate: self, cancelButtonTitle: "Ok")
                        alertView.show()
                        self.commentTextField.text = ""
                        // self.picView.contentOffset = CGPointMake(0, 0)
                        
                        self.listAllComments(0)
                        //self.commentTableView.reloadData()
                        SVProgressHUD .dismiss()
                        
                    }
                    self.imageTitleText.resignFirstResponder()
                    self.descriptionText.resignFirstResponder()
                    self.commentTextField.resignFirstResponder()
                }
                else
                {
                    SVProgressHUD .dismiss()
   
                }
            //backgroundScrollView.contentSize = CGSizeMake(backgroundScrollView.frame.size.width, back)
        }
            }
            else
            {
                SMLGlobal.sharedInstance.NOINTERNETALERT(self)
            }
    }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         textField.resignFirstResponder()
        
        return true
    }
    func  touchesBegan(_ touches: Set<NSObject>, with event: UIEvent)
    {
        
        view.endEditing(true)
        super.touchesBegan(touches as! Set<UITouch>, with: event)
    }
    
       func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        
        let imagePicker = UIImagePickerController()
        //Open Camera
        if(buttonIndex == 0)
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                
                
                
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = false
               // println("Camera")
                
                self.present(imagePicker, animated: true, completion: nil)
                
            }
            else
            {
                UIAlertView(title: "", message: "Camera not available", delegate: nil, cancelButtonTitle: "Ok", otherButtonTitles:"").show()
            }
            
          
        }
            //Cancel
        else if (buttonIndex == 1)
        {
           
        }
            //Gallery
        else if(buttonIndex == 2)
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum)
            {
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
                imagePicker.allowsEditing = false
                
                self.present(imagePicker, animated: true, completion: nil)
                
            }
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        
        
        self.dismiss(animated: true, completion: { () -> Void in
            
        })
        
        
        
        picImageView.image = image
        picImageView.contentMode = UIViewContentMode.scaleAspectFit
       
        //picImageView.setImage(image, forState: .Normal)
        
        
        
    }
    
    func imgClick(_ sender: UIButton) {
        //println("Call")
        let actionSheet = UIActionSheet(title: "", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Open Camera", otherButtonTitles: "Gallery")
        actionSheet.delegate = self
        actionSheet.show(in: self.view)
    }
    func deleteData(_ sender: UIButton)
    {
        let alertView = UIAlertView(title: "", message: "Do you want to delete this comment?", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
        alertView.tag = sender.tag
        alertView.show()
        
        
    }
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int)
    {
        if(alertView.tag == 100)
        {
           if(buttonIndex == 0)
           {
            
           }
           else
           {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
            
           // SVProgressHUD.showWithStatus("Loading")
            SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
            let imageId  : (NSString) = imageDict.object(forKey: "id") as! NSString
            let parameters : (NSDictionary) = ["imageId" : imageId]
            WebserviceManager.sharedInstance.deleteMotivationalImage(params: parameters) { (responseObject, error) in
                if responseObject != nil
                {
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    let message : NSString = responseObject!.value(forKey: "message") as! NSString
                    if success == 0
                    {
                        let alertView = UIAlertView(title: "", message:message as NSString as String, delegate: nil, cancelButtonTitle: "Ok")
                        alertView.show()
                        SVProgressHUD .dismiss()
                    }
                    else if success == 1
                    {
                        let alertView = UIAlertView(title: "", message:message as NSString as String, delegate: self, cancelButtonTitle: "Ok")
                        alertView.tag = 200
                        alertView.show()
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
        else if(alertView.tag == 200)
        {
           self.navigationController?.popViewController(animated: false)
        }
        else
        {
        if(buttonIndex == 0)
        {
            
        }
        else
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
           
            //self.textFieldDidEndEditing(commentTextField)
           // SVProgressHUD.showWithStatus("Loading")
            SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
            //http://112.196.34.179/stepslocator/index.php/login/wsDeleteComment?commentId=
            
            
            
            let dictValue  : (NSDictionary) = self.tableViewArray.object(at: alertView.tag) as! NSDictionary
            let commentId : (NSString) = (dictValue.object(forKey: "comment_id") as? String)! as (NSString)
            
            
            
            
            //var commentId  : (NSString) = imageDict.objectForKey("id") as! NSString
            let parameters : (NSDictionary) = ["commentId" : commentId,
            ]
            
            WebserviceManager.sharedInstance.deleteImageComment(params: parameters) { (responseObject, error) in
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
        
    }
    func whiteSpaceCheck() ->Bool {
        let rawString: NSString = commentTextField.text! as NSString
        
        let whitespace: CharacterSet = CharacterSet.whitespacesAndNewlines
        let trimmed: NSString = rawString.trimmingCharacters(in: whitespace) as NSString
        print(trimmed)
        
        let numberOfSpaces      = imageTitleText.text?.characters.filter{$0 == " "}.count
        let numberOfSpaces2     =  commentTextField.text?.characters.filter{$0 == " "}.count
//        
//        
//        println(numberOfSpaces)
        if firstBlnkValue == 1  {
            let alertView = UIAlertView(title: "", message: "Please enter Image Title", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            imageTitleText.text = ""
            return false
        }
        else if textViewVal == 1
        {
            let alertView = UIAlertView(title: "", message: "Please enter Image Description", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            descriptionText.text = ""
            return false
        } else if firstBlnkValue == 2 {
            let alertView = UIAlertView (title: "", message: "Please enter comment", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            commentTextField.text = ""
            return false;
            
        } else if numberOfSpaces! > 10  {
            let alertView = UIAlertView(title: "", message: "Please enter Image Title", delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
            imageTitleText.text = ""
            return false
        }
         else if numberOfSpaces2! > 10 {
            let alertView = UIAlertView (title: "", message: "Please enter comment", delegate: nil, cancelButtonTitle: "OK")
            alertView.show();
            commentTextField.text = ""
            return false;
            
        }
        else {
            return true;
        }

    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n")
        {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func comval() {
        let d = 32 as unichar
        let str = commentTextField.text! as NSString
        if (commentTextField.text?.characters.count)! > 2 {
            
            if str == "" {
                comVal = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    comVal = 1
                    
                } else {
                    comVal = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if commentTextField.text?.characters.count == 1 {
            
            let c:unichar = str.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                comVal = 1
                
            } else {
                comVal = 0
                
            }
        }

    }
    
    func comValidation() {
        
          let d = 32 as unichar
        let str1 = imageTitleText.text! as NSString
        let str2 = descriptionText.text! as NSString
        
        
        if (imageTitleText.text?.characters.count)! > 2 {
            
            if str1 == "" {
                comVal1 = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str1.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str1.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    comVal1 = 1
                    
                } else {
                    comVal1 = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if imageTitleText.text?.characters.count == 1 {
            
            let c:unichar = str1.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                comVal1 = 1
                
            } else {
                comVal1 = 0
                
            }
        }
        if descriptionText.text.characters.count > 2 {
            
            if str2 == "" {
                desVal = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str2.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str2.character(at: 0);
                //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
                if c == d {
                    desVal = 1
                    
                } else {
                    desVal = 0
                }
                
                // println("Sk Rejabul")
            }
        }
        
        if descriptionText.text.characters.count == 1 {
            
            let c:unichar = str2.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                desVal = 1
                
            } else {
                desVal = 0
                
            }
        }

        
    }
    


}
