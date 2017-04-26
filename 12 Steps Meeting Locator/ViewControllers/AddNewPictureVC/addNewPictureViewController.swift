	//
//  addNewPictureViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 24/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class addNewPictureViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate ,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,UIAlertViewDelegate{
    var addPictureNav: UIView!
    var picView : UIScrollView!
    var picImageView : UIImageView!
    
    var imageTitleText : UITextField!
    var descriptionText : UITextView!
      var updateButton: UIButton = UIButton()
    var firstBlnkValue = 0
    var textViewVal = 0
    var desVal = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPictureNav = UIView()
        addPictureNav.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 60)
        addPictureNav.backgroundColor = UIColor(red: 0 / 255.0, green:135.0 / 255, blue: 206.0 / 255, alpha: 1.0)
        self.view.addSubview(addPictureNav)
        
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        
        let meetingNodeTitel: UILabel = UILabel()
        meetingNodeTitel.text = "Add New Picture"
        meetingNodeTitel.textAlignment = NSTextAlignment.center
        meetingNodeTitel.font = SMLGlobal.sharedInstance.fontSize(14)
        meetingNodeTitel.textColor = UIColor.white
        
        addPictureNav.addSubview(meetingNodeTitel)
        
        let leftHomeButton : UIButton = UIButton()
        let homeImage: UIImage = UIImage(named: "back_errow")!
        leftHomeButton.setBackgroundImage(homeImage, for: UIControlState())
        leftHomeButton.addTarget(self, action: #selector(addNewPictureViewController.homeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addPictureNav.addSubview(leftHomeButton)
        
       _ = ScreenSize.width / 2
        meetingNodeTitel.frame = CGRect(x: 0 , y: 30, width: ScreenSize.width, height: 20)
        
       leftHomeButton.frame = CGRect(x: 16, y: 32, width: 20 , height: 20)
        
        picView = UIScrollView()
        picView.isScrollEnabled = true
        picView.isUserInteractionEnabled = true
        picView.frame = CGRect(x: 0, y: addPictureNav.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - 60)
        picView.backgroundColor = UIColor.white
        
        self.view.addSubview(picView)
        
        picImageView = UIImageView()
        picImageView.isUserInteractionEnabled = true
        picImageView.image = UIImage(named: "background")
        picImageView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: (ScreenSize.height / 4) + 5)
        if(picImageView.image == UIImage(named: "background"))
        {
          
        }
        else
        {
         
        }
       
        picView.addSubview(picImageView)
        
        
//        var tapGetsure = UITapGestureRecognizer(target: self, action: "profileTapGesture:")
//        picImageView.addGestureRecognizer(tapGetsure)
        
        
        let uilbl = UIView()
        uilbl.frame = CGRect(x: picImageView.frame.width - 30, y: picImageView.frame.height - 27, width: 25, height: 22)
        uilbl.layer.borderWidth = 1
        uilbl.layer.cornerRadius = 5
        uilbl.layer.borderColor = UIColor.clear.cgColor
        
        uilbl.backgroundColor = UIColor(red: 87 / 255, green:  87 / 255, blue:  87 / 255, alpha: 1)
        picImageView.addSubview(uilbl)
        
        let imgButton = UIButton()
        imgButton.frame = CGRect(x: 2, y: 2, width: 20.5, height: 18)
        let cam1 = UIImage(named: "cam_icon")
        imgButton.addTarget(self, action: #selector(addNewPictureViewController.CameraClick(_:)), for: .touchUpInside)
        //        imgButton.layer.borderWidth = 1
        //        imgButton.layer.cornerRadius = 5
        imgButton.setBackgroundImage(cam1, for: UIControlState())
        uilbl.addSubview(imgButton)
        
        
        let imageTitleLabel : UILabel = UILabel()
        imageTitleLabel.frame = CGRect(x: 30, y: picImageView.frame.maxY + 10, width: 100, height: 20)
        imageTitleLabel.text = "Image Title"
        imageTitleLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        imageTitleLabel.textColor = UIColor(red: 0.0 / 255, green:  0.0 / 255, blue:  0.0 / 255, alpha: 0.5)
        
        picView.addSubview(imageTitleLabel)
        
        imageTitleText = UITextField()
        imageTitleText.frame = CGRect(x: 30, y: imageTitleLabel.frame.maxY + 3, width: ScreenSize.width - 60, height: 25)
        //meetingTitleText.placeholder = " Lorem Ipsum"
        imageTitleText.textColor = UIColor.black
        imageTitleText.font = SMLGlobal.sharedInstance.fontSize(12)
        //meetingTitleText.returnKeyType=UIReturnKeyType.Next
        imageTitleText.layer.borderWidth = 1
        imageTitleText.tag = 1;
        imageTitleText.delegate = self
        imageTitleText.layer.cornerRadius = imageTitleText.frame.width * 0.015
        imageTitleText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        picView.addSubview(imageTitleText)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        imageTitleText.leftView = leftView
        imageTitleText.leftViewMode = .always
        
        let descriptionLabel : UILabel = UILabel()
        descriptionLabel.frame = CGRect(x: 30, y: imageTitleText.frame.maxY + 10, width: 100, height: 20)
        descriptionLabel.text = "Description"
        descriptionLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        descriptionLabel.textColor = UIColor(red: 0.0 / 255, green:  0.0 / 255, blue:  0.0 / 255, alpha: 0.5)
        
        picView.addSubview(descriptionLabel)
        
        descriptionText  = UITextView()
        descriptionText.frame = CGRect(x: 30, y: descriptionLabel.frame.maxY + 3, width: ScreenSize.width - 60, height: 60)
        //meetingTitleText.placeholder = " Lorem Ipsum"
        descriptionText.textColor = UIColor.black
        descriptionText.font = SMLGlobal.sharedInstance.fontSize(12)
        //meetingTitleText.returnKeyType=UIReturnKeyType.Next
        descriptionText.layer.borderWidth = 1
        descriptionText.tag = 1;
        descriptionText.delegate = self
        descriptionText.layer.cornerRadius = descriptionText.frame.width * 0.015
        descriptionText.layer.borderColor = UIColor(red: 227.0 / 255, green: 227.0 / 255, blue: 227.0 / 255, alpha: 1).cgColor
        picView.addSubview(descriptionText)
        
        
        var btn = CGFloat(90)
        if ScreenSize.height == 667 {
            btn = 111
        }
        btn = (ScreenSize.width - 40)/3
      
        updateButton.frame = CGRect(x: 15, y: descriptionText.frame.maxY + 30, width: btn, height: 35)
        updateButton.layer.cornerRadius = 2.0
        updateButton.setTitle("ADD", for: UIControlState())
        updateButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        updateButton.setTitleColor(UIColor.white, for: UIControlState())
        updateButton.backgroundColor = UIColor(red: 0/255.0, green: 136.0/255.0, blue: 206.0/255.0, alpha: 1.0)
        //var img2 = UIImage(named: "add_button")
        //updateButton.setBackgroundImage(img2, forState: .Normal)
        updateButton.addTarget(self, action: #selector(addNewPictureViewController.addAction(_:)), for: UIControlEvents.touchUpInside)
        picView.addSubview(updateButton)
        //var b = CGRectGetMaxY(commentView.frame.height) as CGFloat
       // println(ScreenSize.height - 50)
       // println(butWidt)
        
        
        let deleteButton: UIButton = UIButton()
        deleteButton.frame = CGRect(x: updateButton.frame.maxX + 5 , y: descriptionText.frame.maxY + 30, width: btn, height: 35)
        deleteButton.layer.cornerRadius = 2.0
        deleteButton.setTitle("Delete", for: UIControlState())
        deleteButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        deleteButton.setTitleColor(UIColor.white, for: UIControlState())
        deleteButton.backgroundColor = ButtonRedColor
       // var img3 = UIImage(named: "delete")
       // deleteButton.setBackgroundImage(img3, forState: .Normal)
        deleteButton.addTarget(self, action: #selector(addNewPictureViewController.deleteAction(_:)), for: UIControlEvents.touchUpInside)
        picView.addSubview(deleteButton)
        
        let cancleButton: UIButton = UIButton()
        cancleButton.frame = CGRect(x: deleteButton.frame.maxX + 5, y: descriptionText.frame.maxY + 30, width: btn, height: 35)
        cancleButton.layer.cornerRadius = 2.0
        cancleButton.setTitle("Cancel", for: UIControlState())
        cancleButton.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
        cancleButton.setTitleColor(UIColor.white, for: UIControlState())
        cancleButton.backgroundColor = ButtonBlueColor
       // var img1 = UIImage(named: "cancel")
        //cancleButton.setBackgroundImage(img1, forState: .Normal)
        cancleButton.addTarget(self, action: #selector(addNewPictureViewController.cancleAction(_:)), for: UIControlEvents.touchUpInside)
        picView.addSubview(cancleButton)
        
        
        picView.contentSize = CGSize(width: picView.frame.size.width, height: cancleButton.frame.maxY)
//             NSNotificationCenter.defaultCenter().addObserver(self, selector: "deleteText", name: UITextFieldTextDidChangeNotification, object: imageTitleText)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "deltextView", name: UITextViewTextDidChangeNotification, object: descriptionText)

    }
     //MARK:-  Action Methods
    func addAction(_ sender : UIButton)
    {
         print("After")
         updateButton.isEnabled = false
         SVProgressHUD.show(withStatus: "Please Wait", maskType: SVProgressHUDMaskType.black)
         comValidation()
        if(self.checkAllTextFields())
        {
            if WebserviceManager.sharedInstance.checkNetworkStatus()
            {
            
        let PImage = picImageView.image!
        let imageData = UIImageJPEGRepresentation(PImage, 1.0)
        let base64String : (NSString) = (imageData?.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters))! as String as NSString
        let user : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = user.userId
      
        let parameters : (NSDictionary) = ["user_id" : loginId,
            "image_title" : imageTitleText.text! as NSString,
            "image_description" : descriptionText.text! as NSString,
            "image" : base64String]
            
            WebserviceManager .sharedInstance.uploadMotivationalImages(params: parameters, withCompletionBlock: { (responseObject, error) in
                if responseObject != nil
                {
                    let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                    let message : (NSString) = responseObject!.value(forKey: "message") as! NSString
                    if success == 0
                    {
                      SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                        SVProgressHUD .dismiss()
                        self.updateButton.isEnabled = true
                        // self.navigationController?.popViewControllerAnimated(false)
                    }
                    else if success == 1
                    {
                        let alertView = UIAlertView(title: "", message: message as String, delegate: self, cancelButtonTitle: "OK")
                        alertView.show()
                        SVProgressHUD .dismiss()
                        self.updateButton.isEnabled = true
                    }
                  }
                else
                {
                     SMLGlobal.sharedInstance.displayAlertMessage(self, (error?.localizedDescription)! as String as NSString, title: "")
                    SVProgressHUD .dismiss()
                    self.updateButton.isEnabled = true
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
            SVProgressHUD.dismiss()
            self.updateButton.isEnabled = true
        }
    }
   
    
    func checkAllTextFields() -> Bool
    {
        if(picImageView.image == UIImage(named: "background"))
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please choose Image", title: "")
            return false
        }
        else if(imageTitleText.text == "" || firstBlnkValue == 1 )
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please enter Image Title", title: "")
            imageTitleText.text = ""
            return false
        }
        else if(descriptionText.text == "" ||  desVal == 1)
        {
            SMLGlobal.sharedInstance.displayAlertMessage(self, "Please enter Image Description", title: "")
            descriptionText.text = ""
            return false
        }
        else
        {
        return true
        }
        
    }
    
    func deleteAction(_ sender : UIButton)
    {
        
    }
    
    func cancleAction(_ sender : UIButton)
    {
       self.navigationController?.popViewController(animated: false)
    }
    
    
    
    
    //MARK - : Delegate Methods
    
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        self.navigationController?.popViewController(animated: false)
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int) {
        
        let imagePicker = UIImagePickerController()
        //Open Camera
        if(buttonIndex == 0)
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                
                
                
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
                imagePicker.allowsEditing = true
               // println("Camera")
                
                self.present(imagePicker, animated: false, completion: nil)
                
            }
            else
            {
                UIAlertView(title: "", message: "Camera not available", delegate: nil, cancelButtonTitle: "Ok", otherButtonTitles:"").show()
            }
            
           // println("0")
        }
            //Cancel
        else if (buttonIndex == 1)
        {
           // println("1")
        }
            //Gallery
        else if(buttonIndex == 2)
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum)
            {
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
                imagePicker.allowsEditing = true
                
                self.present(imagePicker, animated: false, completion: nil)
               // println("1")
            }
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [AnyHashable: Any]!) {
        
       //var imageData = UIImageJPEGRepresentation(image, 1.0)
        picImageView.image=image
        
        
        picImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        self.dismiss(animated: true, completion:nil)
            

        
    }
//    func whiteSpaceCheck() ->Bool {
//   
//        
//        var numberOfSpaces = count(imageTitleText.text.componentsSeparatedByString(" "))
//        var numberOfSpaces1 = count(descriptionText.text.componentsSeparatedByString(" "))
//       
//        
//        
//        println(numberOfSpaces)
//        if firstBlnkValue == 1  {
//            var alertView = UIAlertView(title: "", message: "Please enter Image Title", delegate: nil, cancelButtonTitle: "OK")
//            alertView.show()
//            imageTitleText.text = ""
//            return false
//        }
//        else if textViewVal == 1
//        {
//            var alertView = UIAlertView(title: "", message: "Please enter Image Description", delegate: nil, cancelButtonTitle: "OK")
//            alertView.show()
//            descriptionText.text = ""
//            return false
//        } else if numberOfSpaces > 10  {
//            var alertView = UIAlertView(title: "", message: "Please enter Image Title", delegate: nil, cancelButtonTitle: "OK")
//            alertView.show()
//            imageTitleText.text = ""
//            return false
//        }
//       
//        else {
//            return true;
//        }
//        
//    }
    func CameraClick(_ sender:UIButton)
    {
        let actionSheet = UIActionSheet(title: "", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: "Open Camera", otherButtonTitles: "Gallery")
        actionSheet.show(in: self.view)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height+250)
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height-250)
        return true
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        picView.contentOffset = CGPoint(x: 0, y: 100)
        picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height+250)
        
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        picView.contentSize = CGSize(width: picView.frame.size.width, height: picView.contentSize.height-250)
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        textField .resignFirstResponder()
        
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        imageTitleText.resignFirstResponder()
       
            //textViewVal = 0
            if(text == "\n")
            {
                textView.resignFirstResponder()
                return false
            }
        return true
    }
    
    //MARK:-  Webservice Methods
    func addImageWebservices()
    {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func homeButtonClick(_ sender: UIButton) {
        navigationItem.hidesBackButton = true
        navigationController?.popViewController(animated: true)
    }
    
    //func
    
    func comValidation() {
        
        let str = imageTitleText.text! as NSString
        let str1 = descriptionText.text as NSString
        
//        var firstBlnkValue = 0
//        var textViewVal = 0
//        var desVal = 0
        
        let d = 32 as unichar
     
        
        if (imageTitleText.text?.characters.count)! > 2 {
            
            if str == "" {
                firstBlnkValue = 0
                
                //println("Sk Rejabul")
            } else {
                //var value = str.substring(with: NSRange(location: 0, length: 1))
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
        
        if imageTitleText.text?.characters.count == 1 {
            
            let c:unichar = str.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                firstBlnkValue = 1
                
            } else {
                firstBlnkValue = 0
                
            }
        }
        if descriptionText.text.characters.count > 2 {
            
            if str1 == "" {
                desVal = 0
                
                //println("Sk Rejabul")
            } else {
              //  var value = str1.substring(with: NSRange(location: 0, length: 1))
                let c:unichar = str1.character(at: 0);
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
            
            let c:unichar = str1.character(at: 0);
            //            if (NSCharacterSet.decimalDigitCharacterSet.characterIsMember(c)) {
            if c == d {
                desVal = 1
                
            } else {
                desVal = 0
                
            }
        }
        
        
    }

  

}
