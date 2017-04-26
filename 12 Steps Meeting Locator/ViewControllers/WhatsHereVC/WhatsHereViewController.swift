//
//  WhatsHereViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 01/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class WhatsHereViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func createUI()
    {
        let navigationView = UIView()
        navigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 44)
        navigationView.backgroundColor = UIColor(red: 31.0/255.0, green:134/255, blue: 209.255, alpha: 1.0)
        self.view.addSubview(navigationView)
        
        let backBtn = UIButton.init(type: UIButtonType.custom)
        let image = UIImage(named: "back_errow")
        backBtn.frame = CGRect(x: 10,y: 20, width: 20, height: 20)
        backBtn.setImage(image, for: UIControlState())
        backBtn.addTarget(self, action: #selector(WhatsHereViewController.SideMenu(_:)), for: UIControlEvents.touchUpInside)
        navigationView.addSubview(backBtn)
        
        let editBtn = UIButton.init(type: UIButtonType.custom) 
        editBtn.frame = CGRect(x: navigationView.frame.size.width - 30, y: 20, width: 20, height: 20)
        let image1 = UIImage(named: "edit")
        editBtn.setImage(image1, for: UIControlState())
        navigationView.addSubview(editBtn)
        
        
        let titleLabel = UILabel()
        titleLabel.frame=CGRect(x: 30, y: 20, width: navigationView.frame.size.width-50, height: 20)
        titleLabel.text = "What's Here"
        
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(15)
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.textColor = UIColor.white
        navigationView.addSubview(titleLabel)
        
        
        
    }
    
    
    func SideMenu(_ sender : UIButton)
    {
        let sidePanel : JASidePanelController = JASidePanelController()
        sidePanel.shouldDelegateAutorotateToVisiblePanel = false;
       // self.navigationController?.pushViewController(sidePanel, animated: true)
        sidePanel.leftPanel = SideMenuViewController()
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
