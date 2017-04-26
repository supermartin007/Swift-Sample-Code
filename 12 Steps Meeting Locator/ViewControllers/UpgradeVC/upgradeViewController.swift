//
//  upgradeViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 10/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import StoreKit



class upgradeViewController: UIViewController,inAppProductsDelegate , SKPaymentTransactionObserver , SKProductsRequestDelegate,UIAlertViewDelegate
{
    
    
    
    var productArray : (NSMutableArray) = NSMutableArray()
    var productIdentifier :  (NSString) = NSString()
    var isRestore :(Bool) = false
    var inAppProducts : (inAppClass)!
    //inAppClass *inAppProducts;

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       inAppProducts = inAppClass.sharedInstance()
       // inAppProducts = inAppClass.sharedInstance()
        inAppProducts.delegate = self
        
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        
        
        let navigation: UIView = UIView()
        navigation.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        navigation.backgroundColor = UIColor(red: 0 / 255.0, green:135.0 / 255, blue: 206.0 / 255, alpha: 1.0)
        self.view.addSubview(navigation)
        
        let leftHomeButton : UIButton = UIButton()
        let homeImage: UIImage = UIImage(named: "home")!
        leftHomeButton.setBackgroundImage(homeImage, for: UIControlState())
        leftHomeButton.addTarget(self, action: #selector(upgradeViewController.homeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        navigation.addSubview(leftHomeButton)
        
        let upgradeTitle: UILabel = UILabel()
        upgradeTitle.text = "Upgrade To Premium"
        upgradeTitle.textColor = UIColor.white
        upgradeTitle.font = SMLGlobal.sharedInstance.fontSize(12)
        navigation.addSubview(upgradeTitle)
        
        let screenMid = ScreenSize.width / 2
        
        if (self.view.frame.height >= 667.0) {
            upgradeTitle.frame = CGRect(x: screenMid - 50, y: 27, width: 200, height: 30)
            leftHomeButton.frame = CGRect(x: 16, y: 27, width: 30, height: 30)
            //addButton.frame = CGRectMake(ScreenSize.width - 40, sgmentViewHeight / 4, 30, 30)
            
            
        } else {
            upgradeTitle.frame = CGRect(x: screenMid - 50 , y: 25, width: 200, height: 30)
            leftHomeButton.frame = CGRect(x: 16, y: 25, width: 30, height: 30)
            //addButton.frame = CGRectMake(ScreenSize.width - 40, sgmentViewHeight / 3.8, 25, 25)
            
        }

        
        let backGroundView: UIView = UIView()
        backGroundView.frame = CGRect(x: 0, y: navigation.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - navigation.frame.maxY)
        backGroundView.backgroundColor = UIColor.white
        self.view.addSubview(backGroundView)
        
        let upgradeHeader: UILabel = UILabel()
        upgradeHeader.frame = CGRect(x: 30, y: 20, width: 250, height: 20)
        upgradeHeader.text = "Upgrade to our Paid Version and receive:"
        upgradeHeader.font = SMLGlobal.sharedInstance.fontSize(12)
        upgradeHeader.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
         backGroundView.addSubview(upgradeHeader)
        
        let lineBar: UILabel = UILabel()
        lineBar.frame = CGRect(x: 30, y: upgradeHeader.frame.maxY + 5, width: ScreenSize.width - 60, height: 1)
        lineBar.backgroundColor = UIColor(red: 218 / 255, green: 218 / 255, blue: 218 / 255, alpha: 1)
        backGroundView.addSubview(lineBar)
        
        let upgradeText: UITextView = UITextView()
        upgradeText.frame = CGRect(x: 30, y: lineBar.frame.maxY + 10, width: 250, height: 120)
        upgradeText.text = "-   GPS Check-In Feature\n \n-   Track your success online and on your phone\n \n-   Receive Push Notifications When new meetings \n     are added in your area\n \n-   All Ads are removed in paid version"
        upgradeText.font = SMLGlobal.sharedInstance.fontSize(10)
        upgradeText.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        backGroundView.addSubview(upgradeText)
        
        let upgradeButton : UIButton = UIButton()
        upgradeButton.frame = CGRect(x: screenMid - 116, y: upgradeText.frame.maxY + 20, width: 111, height: 37)
        
        if (self.isRestore == true)
        {
            var  upgradeImage = UIImage(named: "restore_button")
            upgradeButton.setBackgroundImage(upgradeImage, for: UIControlState())
            upgradeButton.addTarget(self, action: #selector(upgradeViewController.restoreBtnAction(_:)), for: UIControlEvents.touchUpInside)
            upgradeImage = nil

        }
        else
        {
            var  upgradeImage = UIImage(named: "upgrad_button")
            upgradeButton.setBackgroundImage(upgradeImage, for: UIControlState())
            upgradeButton.addTarget(self, action: #selector(upgradeViewController.upgradeBtnAction(_:)), for: UIControlEvents.touchUpInside)
            upgradeImage = nil
        }
        
                backGroundView.addSubview(upgradeButton)
        
        
        
        
        
        let cancleButton : UIButton = UIButton()
        cancleButton.frame = CGRect(x: screenMid + 5, y: upgradeText.frame.maxY + 20, width: 111, height: 37)
        let  cancleButtonImage = UIImage(named: "popupcancel")
        cancleButton.setBackgroundImage(cancleButtonImage, for: UIControlState())
        cancleButton.addTarget(self, action: #selector(upgradeViewController.cancelBtnAction(_:)), for: .touchUpInside)
        backGroundView.addSubview(cancleButton)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func homeButtonClick(_ sender: UIButton) {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
    }
    
    
    
    
    //MARK:- In app Purchase Methods
    
    func upgradeBtnAction(_ sender:UIButton)
    {
        let user : (SMLAppUser) = SMLAppUser.getUser()
        let upgrade : (NSString) = user.upgrade
        if(upgrade == "0")
        {
            let alertView :(UIAlertView) = UIAlertView(title: "", message: "Do you want to upgrade this for $5.99", delegate: self, cancelButtonTitle: "Cancel", otherButtonTitles: "Ok")
            alertView.show()
        }
        else
        {
            UIAlertView(title: "", message: "You already upgrade this premium", delegate: nil, cancelButtonTitle: "OK").show()
        }
        
    }
    func restoreBtnAction(_ sender:UIButton)
    {
        restoreWithProductId(PRODUCTID as NSString)
        
    }
    func cancelBtnAction(_ sender:UIButton)
    {
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        let firstView : FirstViewController = FirstViewController()
        
        delegate.callMethod(firstView)
    }
    
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        
        if(buttonIndex == 0)
        {
            
        }
        else
        {
           purchaseWithId(PRODUCTID as NSString)
        }
    }

    // MARK:- In App Purchase Maethods
    
    func purchaseWithId(_ productId:NSString)
    {
        self.productArray = NSMutableArray()
        
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        self.productArray = delegate.productArray
        self.productIdentifier = productId
        SVProgressHUD.show(withStatus: "Loading...", maskType: SVProgressHUDMaskType.black)
        self.perform(#selector(upgradeViewController.working), with: nil, afterDelay: 0.1);
    }
    func restoreWithProductId(_ productId:NSString)
    {
        
        
        self.productArray = NSMutableArray()
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        self.productArray = delegate.productArray
        SVProgressHUD.show(withStatus: "Loading...", maskType: SVProgressHUDMaskType.black)
        self.perform(#selector(upgradeViewController.startRestore), with: nil, afterDelay: 0.1);
        
    }
    
    //MARK:- In-App-Purchase
    
    func working()
    {

            if(self.productArray.count != 0)
            {
                let product : (SKProduct) = self.productArray[0] as! (SKProduct)
                self.inAppProducts .buyProduct(product)
            }
            else
            {
                UIAlertView(title: "Alert", message: "Please wait while load Products", delegate: nil, cancelButtonTitle: "OK").show()
            }
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
    
    func didFinish(with transaction: SKPaymentTransaction)
    {
    //  if(inAppClass .sharedInstance().productIsAlreadyPurchased(PRODUCTID))
    //  {
        let user : (SMLAppUser) = SMLAppUser.getUser()
        user.upgrade = "1"
        SMLAppUser.saveUser(user)
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        delegate.upgradeRole()
        SVProgressHUD.dismiss()
     // }
    }
    
    
    func didFailWithError(_ error: NSError!, transaction: SKPaymentTransaction)
    {
        SVProgressHUD.dismiss()

    }
    
    //MARK :- Restore methods
    
    
    
    func startRestore()
    {
        
        if(self.productArray.count != 0)
        {
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().restoreCompletedTransactions()
        }
        else
        {
            UIAlertView(title: "Alert", message: "Please wait while load Products", delegate: nil, cancelButtonTitle: "OK").show()
            SVProgressHUD.dismiss()
        }

        
       
  
      //  SVProgressHUD.dismiss()

    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: NSError!)
    {
        SVProgressHUD.dismiss()

    }

    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue)
    {
      if(queue.transactions.count == 0)
      {
         UIAlertView(title: "Restore", message: "There is no products purchased by you", delegate: nil, cancelButtonTitle: "OK").show()
      }
      else
      {
        UIAlertView(title: "Restore", message: "Product Restored Successfully", delegate: nil, cancelButtonTitle: "OK").show()
        
        let user : (SMLAppUser) = SMLAppUser.getUser()
        user.upgrade = "1"
        SMLAppUser.saveUser(user)
        let delegate : (AppDelegate) = UIApplication.shared.delegate as! AppDelegate
        delegate.upgradeRole()
        SVProgressHUD.dismiss()
        
        let userDefault : (UserDefaults) = UserDefaults.standard
        userDefault.set(true, forKey: "Upgrade")
        userDefault.synchronize()
        
      }
    }
    
    //MARK :- Request For products
    func productsRequest(_ request: SKProductsRequest!, didReceive response: SKProductsResponse!) {
    
    }
    
    func request(_ request: SKRequest!, didFailWithError error: Error) {
        
    }
    
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
    }
    
    
    
    
    
    
    
  


}
