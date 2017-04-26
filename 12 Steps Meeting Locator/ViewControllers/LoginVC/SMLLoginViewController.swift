//
//  SMLLoginViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iapp on 22/05/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit

class SMLLoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true);
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

   func createUI()
   {
    var backGroundScrollView = UIScrollView()
    backGroundScrollView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: ScreenSize.height);
    backGroundScrollView.backgroundColor = UIColor.gray;
    self.view.addSubview(backGroundScrollView);
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
