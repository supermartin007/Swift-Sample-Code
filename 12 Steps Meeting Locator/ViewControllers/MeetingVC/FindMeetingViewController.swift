//
//  FindMeetingViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 03/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class FindMeetingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI()

        // Do any additional setup after loading the view.
    }
    
    func createUI()
    {
      
        
        
//        self.navigationController!.navigationBar.barTintColor  = UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0)
//        
//        self.navigationItem.hidesBackButton = true
//        
//        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor() , NSFontAttributeName : SMLGlobal.sharedInstance.fontSize(15)]
//        
//        self.navigationItem.title = ""
//        
//        
//        self.view.backgroundColor = UIColor.whiteColor()
//        
//        var backImage =  UIImage(named: "back_errow")
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: backImage, landscapeImagePhone: nil, style: UIBarButtonItemStyle.Plain, target: self, action: "backBtnAction:")
//        
//        var sideImage =  UIImage(named: "back_errow")
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: sideImage, landscapeImagePhone: nil, style: UIBarButtonItemStyle.Plain, target: self, action: "backBtnAction:")
//        
//        
//        
//        
//        
//        var segmentControl = UISegmentedControl()
//        segmentControl.backgroundColor = UIColor.greenColor()
//        segmentControl.addTarget(self, action: "selectedSegment", forControlEvents: UIControlEvents.TouchUpInside)
//        self.navigationItem.titleView = segmentControl
        
        
        
        self.navigationController?.isNavigationBarHidden = true
        
        
        
        
        let navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 100)
        navigationView.backgroundColor = UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0)
        self.view.addSubview(navigationView)
        
        let backBtn = UIButton.init(type: UIButtonType.custom)
        let image = UIImage(named: "back_errow")
        
        backBtn.frame = CGRect(x: 10,y: 20, width: 20, height: 20)
        backBtn.setImage(image, for: UIControlState())
        navigationView.addSubview(backBtn)
        
        let editBtn = UIButton.init(type: UIButtonType.custom) 
        editBtn.frame = CGRect(x: navigationView.frame.size.width - 30, y: 20, width: 20, height: 20)
        let image1 = UIImage(named: "edit")
        editBtn.setImage(image1, for: UIControlState())
        navigationView.addSubview(editBtn)
        
        
        
        
        
//        var titleLabel = UILabel()
//        titleLabel.frame=CGRectMake(30, 20, navigationView.frame.size.width-50, 20)
//        titleLabel.text = "Add meeting"
//        titleLabel.font = SMLGlobal.sharedInstance.fontSize(15)
//        titleLabel.textAlignment = NSTextAlignment.Center
//        titleLabel.textColor = UIColor.whiteColor()
//        navigationView.addSubview(titleLabel)
        
        let segmentControl = UISegmentedControl()
        segmentControl.frame = CGRect(x: 30, y: 20,width: 200, height: 20)
        segmentControl.backgroundColor = UIColor.clear
        segmentControl.addTarget(self, action: Selector(("selectedSegment")), for: UIControlEvents.touchUpInside)
        navigationView.addSubview(segmentControl)
        
        
        
        
        
        
        
      
        
        
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
