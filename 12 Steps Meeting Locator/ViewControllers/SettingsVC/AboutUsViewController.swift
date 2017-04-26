//
//  AboutUsViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 17/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        
        self.navigationController?.isNavigationBarHidden = true
        super.viewDidLoad()
        
        self.createUI()

        // Do any additional setup after loading the view.
    }
    
    func createUI()
    {
        
        self.view.backgroundColor = UIColor.white
        let navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        navigationView.backgroundColor = UIColor(red: 31.0/255.0, green:134/255, blue: 209.0/255.0, alpha: 1.0)
        self.view.addSubview(navigationView)
        
        let backBtn = UIButton.init(type: UIButtonType.custom) 
        let image = UIImage(named: "home")
        backBtn.addTarget(self, action: #selector(AboutUsViewController.backBtnAction(_:)), for: UIControlEvents.touchUpInside)
        
        backBtn.frame = CGRect(x: 10,y: 25, width: 30, height: 30)
        backBtn.setImage(image, for: UIControlState())
        navigationView.addSubview(backBtn)
        
        
        let titleLabel = UILabel()
        titleLabel.frame=CGRect(x: 30, y: 27, width: navigationView.frame.size.width-50, height: 20)
        titleLabel.text = "About Us"
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        navigationView.addSubview(titleLabel)
        
        
        
        let AboutUsDetail = UILabel()
        AboutUsDetail.numberOfLines = 0
        AboutUsDetail.frame=CGRect(x: 20, y: navigationView.frame.maxY+10, width: ScreenSize.width - 40, height: 180)
        AboutUsDetail.text = "Recovery Meeting Locator was developed by Tony Jordan in hopes this application would help thousands around the World. After suffering from countless loss, and going through divorce and losing his family, Mr Jordan decided he would do all he could to get sober, stay sober and help others do the same."
        
       // "This application is dedicated to my loved ones" - Tony Jordan"
        AboutUsDetail.font = SMLGlobal.sharedInstance.fontSize(14)
        AboutUsDetail.textAlignment = NSTextAlignment.left
        AboutUsDetail.textColor = UIColor.gray
        self.view.addSubview(AboutUsDetail)
        
        let detailLabel = UILabel()
        detailLabel.numberOfLines = 0
        detailLabel.frame=CGRect(x: 20, y: AboutUsDetail.frame.maxY+5, width: navigationView.frame.size.width-60, height: 50)
        detailLabel.text = "This application is dedicated to my loved ones - Tony Jordan"
        detailLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        detailLabel.textAlignment = NSTextAlignment.left
        detailLabel.textColor = UIColor.gray
        self.view.addSubview(detailLabel)
        
        
        
        
        
        
        
        
        
        
    }
    
    
    
    func backBtnAction(_ sender : UIButton)
    {
        let delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)
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
