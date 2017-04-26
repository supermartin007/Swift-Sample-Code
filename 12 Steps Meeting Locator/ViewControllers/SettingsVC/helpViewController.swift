//
//  helpViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 27/07/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class helpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        createUI()
        // Do any additional setup after loading the view.
    }
    func createUI()
    {
        
        self.view.backgroundColor = UIColor.white
        let navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 64)
        navigationView.backgroundColor = UIColor(red: 31.0/255.0, green:134/255, blue: 209.0/255.0, alpha: 1.0)
        self.view.addSubview(navigationView)
        
        let leftButton: UIButton = UIButton()
        leftButton.frame = CGRect(x: 16, y: 32, width: 20, height: 20)
        let img = UIImage(named: "back_errow")
        leftButton.setBackgroundImage(img, for: UIControlState())
        leftButton.addTarget(self, action: #selector(helpViewController.homeClick(_:)), for: UIControlEvents.touchUpInside)
        navigationView.addSubview(leftButton)
        
        let titleLabel = UILabel()
        titleLabel.frame=CGRect(x: 30, y: 27, width: navigationView.frame.size.width-50, height: 20)
        titleLabel.text = "Help"
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(14)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        navigationView.addSubview(titleLabel)
        
        let AboutUsDetail = UILabel()
        AboutUsDetail.numberOfLines = 0
        AboutUsDetail.frame=CGRect(x: 20, y: navigationView.frame.maxY+10, width: ScreenSize.width - 40, height: 300)
        AboutUsDetail.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
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
       // self.view.addSubview(detailLabel)
        
        

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func homeClick(_ sender : UIButton)
    {
     
            navigationController?.popViewController(animated: false)
        
    }

}
