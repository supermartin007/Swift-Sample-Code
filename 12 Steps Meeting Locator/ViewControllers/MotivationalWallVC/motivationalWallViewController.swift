//
//  motivationalWallViewController.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 23/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
var valv = 0
class motivationalWallViewController: UIViewController, UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var meetingNavigationView: UIView = UIView()
    var meetingTableView :UITableView = UITableView()
    var textView : UITextField = UITextField()
    
     var myPic : UIButton!
    
    var publicMotivation : UIButton!
    var myPicTable: UITableView!
     var  appUser : (SMLAppUser) = SMLAppUser.getUser()
    var collectionview: UICollectionView!
    var reuseIdentifier = "CELL"
    var gridView : UIScrollView!
    var valArray = 20 / 4
    
    var privateTotalCount : (Int) = 0
    var publicTotalCount : (Int) = 0
    var privateArray : (NSMutableArray) = NSMutableArray()
    var publicArray : (NSMutableArray) = NSMutableArray()
    
    
    var showMoreBtn: (UIButton)!
    
    var tableViewArray : (NSMutableArray) = NSMutableArray()
    
    var tabValue : (Int) = 0
    
    var gridTable : UITableView!
    var gridIndex : (Int) = 0
    
    
    var addNewPic : UIButton!
    //var refreshManager : (MNMBottomPullToRefreshManager)!
    
    //var reloads : (NSUInteger)
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.white
        
        valv = 0
        gridIndex = 0
        tabValue = 1
      
        meetingNavigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 150)
        meetingNavigationView.backgroundColor = UIColor(red: 0 / 255.0, green:135.0 / 255, blue: 206.0 / 255, alpha: 1.0)
        self.view.addSubview(meetingNavigationView)
        
        var sgmentViewHeight = meetingNavigationView.frame.height
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        

        
        var meetingNodeTitel: UILabel = UILabel()
        meetingNodeTitel.text = "Motivational Wall"
        meetingNodeTitel.font = SMLGlobal.sharedInstance.fontSize(14)
        meetingNodeTitel.textColor = UIColor.white
        meetingNodeTitel.textAlignment = NSTextAlignment.center
        
        meetingNavigationView.addSubview(meetingNodeTitel)
        
        var leftHomeButton : UIButton = UIButton()
        var homeImage: UIImage = UIImage(named: "home")!
        leftHomeButton.setImage(homeImage, for: UIControlState())
        leftHomeButton.addTarget(self, action: #selector(motivationalWallViewController.homeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        
        meetingNavigationView.addSubview(leftHomeButton)
        
        /* Create Top Custom Right Button View */
        
        var addButton: UIButton = UIButton.init(type: UIButtonType.custom)
        
        addButton.addTarget(self, action: #selector(motivationalWallViewController.addButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //rightButton.backgroundColor = UIColor.whiteColor()
        var rightButtonImage: UIImage = UIImage(named: "blocks")!
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addButton.setImage(rightButtonImage, for: UIControlState())
        meetingNavigationView.addSubview(addButton)
        var mid = meetingNavigationView.frame.size.height
        
            meetingNodeTitel.frame = CGRect(x: 0, y: 30, width: ScreenSize.width, height: 30)
        

        addButton.frame = CGRect(x: ScreenSize.width - 44, y: 30, width: 24, height: 24)
        leftHomeButton.frame = CGRect(x: 16, y: 30 , width: 32 , height: 32)
        /* Create  Custom Search text Field */
        
        var value = meetingNavigationView.frame.height - 50
        
        var searchView: UIButton = UIButton()
        searchView.frame = CGRect(x: 20, y: meetingNodeTitel.frame.maxY + 10, width: ScreenSize.width - 40,  height: 20 * 1.35)
        searchView.backgroundColor = UIColor.white
        searchView.layer.cornerRadius = 0.04 * searchView.frame.width
        searchView.layer.borderColor = UIColor.clear.cgColor
        //searchBarView.showsBookmarkButton = true
        searchView.clipsToBounds = true
        meetingNavigationView.addSubview(searchView)
        
        
        textView.frame = CGRect(x: 30, y: 0, width: searchView.frame.width - 50,  height: 20 * 1.35)
        textView.delegate = self
        var placeholder1 = NSAttributedString(string: "Search by Keyword", attributes: [NSForegroundColorAttributeName : UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.6)])
        textView.attributedPlaceholder = placeholder1;
        textView.font = SMLGlobal.sharedInstance.fontSize(10)
        searchView.addSubview(textView)
        
        var UIImg : UIButton = UIButton()
        UIImg.frame = CGRect(x: searchView.frame.width - 27,y: (searchView.frame.size.height - 25)/2, width: 25, height: 25)
        var  butImg = UIImage(named: "search_arrow_icon")
        UIImg.setBackgroundImage(butImg, for: UIControlState())
        UIImg.addTarget(self, action: #selector(motivationalWallViewController.searchButt(_:)), for: UIControlEvents.touchUpInside)
        searchView.addSubview(UIImg)
        
        var searchIcon : UIImageView = UIImageView()
        searchIcon.frame = CGRect(x: 5, y: 3.5, width: 20, height: 20)
        searchIcon.image = UIImage(named: "search_icon")
        searchView.addSubview(searchIcon)
        
        var scrnWdth = ScreenSize.width - 305
        var scrnWdth1 = scrnWdth / 2
        
        myPic = UIButton.init(type: UIButtonType.custom)
        myPic.frame = CGRect(x: scrnWdth1, y: meetingNavigationView.frame.height - 30, width: 130, height: 30)
        myPic.setTitle("My Pictures", for: UIControlState())
        myPic.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
        myPic.addTarget(self, action: #selector(motivationalWallViewController.myPicture(_:)), for: UIControlEvents.touchUpInside)
        myPic.setTitleColor(UIColor(red: 60.0/255.0, green: 92.0/255.0, blue: 152.0/255.0, alpha: 1.0), for: UIControlState())
        myPic.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
        myPic.layer.borderWidth = 1
        myPic.layer.cornerRadius = 5
        myPic.layer.borderColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1).cgColor
        meetingNavigationView.addSubview(myPic)
        
        publicMotivation = UIButton.init(type: UIButtonType.custom)
        publicMotivation.frame = CGRect(x: myPic.frame.maxX + 5, y: meetingNavigationView.frame.height - 30, width: 130, height: 30)
        publicMotivation.setTitle("Public Motivation", for: UIControlState())
        publicMotivation.backgroundColor = UIColor.clear
        publicMotivation.addTarget(self, action: #selector(motivationalWallViewController.publicMotivations(_:)), for: UIControlEvents.touchUpInside)
        publicMotivation.setTitleColor(UIColor.white, for: UIControlState())
        publicMotivation.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(12)
        publicMotivation.layer.borderWidth = 1
        publicMotivation.layer.cornerRadius = 5
        publicMotivation.layer.borderColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1).cgColor
        meetingNavigationView.addSubview(publicMotivation)
        
        
        
        addNewPic = UIButton.init(type: UIButtonType.custom)
        addNewPic.addTarget(self, action: #selector(motivationalWallViewController.addNewPic(_:)), for: UIControlEvents.touchUpInside)
        //rightButton.backgroundColor = UIColor.whiteColor()
        var rightButtonImage1: UIImage = UIImage(named: "add_icon")!
        addNewPic.frame = CGRect(x: ScreenSize.width - 35, y: publicMotivation.frame.origin.y - 3, width: 31, height: 32)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addNewPic.setBackgroundImage(rightButtonImage1, for: UIControlState())
        meetingNavigationView.addSubview(addNewPic)
        
        
        
        var lbl : UILabel = UILabel()
        lbl.frame = CGRect(x: 0, y: meetingNavigationView.frame.height - 3, width: ScreenSize.width, height: 3)
        lbl.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
        meetingNavigationView.addSubview(lbl)
        myPicTable = UITableView()
        myPicTable.frame = CGRect(x: 0, y: meetingNavigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - meetingNavigationView.frame.height)
         self.view.addSubview(myPicTable)
        myPicTable.separatorStyle = UITableViewCellSeparatorStyle.none
        myPicTable.delegate = self
        myPicTable.dataSource = self
       
        var footerView : (UIView) = UIView()
        footerView.frame = CGRect.zero
        //footerView.frame = CGRectMake(0, 0, ScreenSize.width, 50)
        
        
//        showMoreBtn  = UIButton.buttonWithType(.Custom) as! (UIButton)
//        showMoreBtn.frame = CGRectMake(0, 0,ScreenSize.width , 50)
//        footerView.addSubview(showMoreBtn)
        
//        showMoreBtn.titleLabel?.font = SMLGlobal.sharedInstance.fontSize(14)
//        showMoreBtn.setTitle("Load More", forState: UIControlState.Normal)
//        showMoreBtn.addTarget(self, action: "showMoreBtn:", forControlEvents: .TouchUpInside)
//        showMoreBtn.setTitleColor(UIColor.grayColor(), forState: .Normal)
//        myPicTable.tableFooterView = footerView
//        myPicTable.tableFooterView?.hidden = true
        //self.getPrivateMotivationWebservice(0)
        
        
        gridView  = UIScrollView()
        gridView.frame = CGRect(x: 0, y: meetingNavigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - meetingNavigationView.frame.height)
        gridView.delegate = self
        gridView.isScrollEnabled = true
        gridView.isHidden = true
        gridView.backgroundColor = UIColor.white
       // self.view.addSubview(gridView)
        
        
        var refresh : (UIRefreshControl) = UIRefreshControl()
        refresh .addTarget(self, action: "testRefresh:", for: .valueChanged)
        gridView.addSubview(refresh)
        
        
        
        
        
        gridTable = UITableView()
        
        gridTable.frame = CGRect(x: 0, y: meetingNavigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - meetingNavigationView.frame.height)
        gridTable.isHidden = true
        gridTable.isScrollEnabled = true
        gridTable.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(gridTable)
        
        gridTable.delegate = self
        gridTable.dataSource = self
        
     
        
       
        
    }
    
    func addNewPic(_ sender:UIButton)
    {
        let addPic : (addNewPictureViewController) = addNewPictureViewController()
        self.navigationController?.pushViewController(addPic, animated: false)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let currentOffset : (CGFloat) = scrollView.contentOffset.y
        let maxOffset : (CGFloat) = scrollView.contentSize.height - scrollView.frame.size.height
        if (maxOffset - currentOffset <= 5.0)
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
       // var lastDict : (NSDictionary) = self.tableViewArray .objectAtIndex(self.tableViewArray.count - 1) as! (NSDictionary)
       // var lastId : (NSString) = lastDict.objectForKey("id") as! NSString
       // var lId : (Int) = lastId.integerValue
        if(tabValue == 1)
        {
            print(self.privateArray.count)
            print(self.privateTotalCount)
            if(self.privateArray.count<self.privateTotalCount)
            {
               self.getPrivateMotivationWebservice(self.privateArray.count)
            }
           
        }
        else
        {
            // println(self.publicArray.count)
           // println(self.publicTotalCount)
            if(self.publicArray.count<self.publicTotalCount)
            {
                self.getPublicMotivationWebservice(self.publicArray.count)
            }
        
        }
    }
    
    
//    - (void)scrollViewDidScroll: (UIScrollView *)scroll {
//    // UITableView only moves in one direction, y axis
//    CGFloat currentOffset = scroll.contentOffset.y;
//    CGFloat maximumOffset = scroll.contentSize.height - scroll.frame.size.height;
//    
//    // Change 10.0 to adjust the distance from bottom
//    if (maximumOffset - currentOffset <= 10.0) {
//    [self methodThatAddsDataAndReloadsTableView];
//    }
    
    
//    func testRefresh(refreshControl: UIRefreshControl)
//    {
//        
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if(tabValue == 1)
        {
        self.privateArray .removeAllObjects()
            self.publicArray.removeAllObjects()
         self.getPrivateMotivationWebservice(0)
        }
        else
        
        {
          self.getPublicMotivationWebservice(0)
        }
        
        
       
        
        myPicTable.reloadData()
        
        
    }
    
    func searchButt(_ sender:UIButton)
    {
        let predicate : (NSPredicate) = NSPredicate(format: "SELF.image_title contains [cd] %@", textView.text!)
       // private walls
        if(tabValue == 1)
        {
            var arr : (NSArray) = self.tableViewArray as NSArray
            arr = self.tableViewArray.filtered(using: predicate) as (NSArray)
            self.tableViewArray = arr.mutableCopy() as! (NSMutableArray)
            self.myPicTable.reloadData()
            textView.resignFirstResponder()
            
            if(self.tableViewArray.count == 0)
            {
                let alertView : (UIAlertView) = UIAlertView(title: "", message: "No result found", delegate: nil, cancelButtonTitle: "OK")
                
                alertView.show()
            }
            else
            {
              
            }
        }
        else
        {
            var arr : (NSArray) = self.tableViewArray
            arr = self.tableViewArray.filtered(using: predicate) as (NSArray)
            self.tableViewArray = arr.mutableCopy() as! (NSMutableArray)
            self.myPicTable.reloadData()
            textView.resignFirstResponder()
            if(self.tableViewArray.count == 0)
            {
                let alertView : (UIAlertView) = UIAlertView(title: "", message: "No result found", delegate: nil, cancelButtonTitle: "OK")
                
                alertView.show()
            }
            else
            {
               
            }
           
        }
        
    }
    
    func showMoreBtn(_ sender:UIButton)
    {
        let lastDict : (NSDictionary) = self.tableViewArray .object(at: self.tableViewArray.count - 1) as! (NSDictionary)
        let lastId : (NSString) = lastDict.object(forKey: "id") as! NSString
        let lId : (Int) = lastId.integerValue
        if(tabValue == 1)
        {
            self.getPrivateMotivationWebservice(lId)
        }
        else
        {
            self.getPublicMotivationWebservice(lId)
        }
        
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK :- TableView Delegete Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        
        var va = tableViewArray.count
        if valv == 0
        {
            va = tableViewArray.count
        }
        else
        {
            let mod = tableViewArray.count % 3
            var arrVal = tableViewArray.count / 3
            if mod != 0
            {
                arrVal = arrVal + 1
                va = arrVal
                //println(va)
            }
            else
            {
                va = arrVal
            }
           // println(va)
        }
        return va
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        if(valv == 0)
        {
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
        
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
           // cell!.textLabel?.textColor = UIColor.blackColor()
        }
        
       
        
        //var subviews = cell?.contentView.subviews
        
      
        var subviews = cell?.contentView.subviews
        for view in subviews!
        {
            view.removeFromSuperview()
        }
        
        var cellView : UIView = UIView()
        cellView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 80)
        cell?.contentView.addSubview(cellView)
        
        var disclosureIndicator: UIButton = UIButton()
        disclosureIndicator.frame = CGRect(x: ScreenSize.width - 25, y: (cellView.frame.height - 16) / 2, width: 9, height: 16)
        disclosureIndicator.backgroundColor = UIColor.clear
        //disclosureIndicator.setTitle(">", forState: .Normal)
        var imgIndicator = UIImage(named: "arrow1")
        disclosureIndicator.setBackgroundImage(imgIndicator, for: UIControlState())
        //disclosureIndicator.setTitleColor(UIColor.blackColor(), forState: .Normal)
        disclosureIndicator.tag = (indexPath as NSIndexPath).row
        cellView.addSubview(disclosureIndicator)
        
        //http://112.196.34.179/stepslocator/uploads/thumbs/thumb_
        let singleDict: (NSDictionary) = self.tableViewArray.object(at: (indexPath as NSIndexPath).row) as! (NSDictionary)
           // println(singleDict)
        
         let imageView : UIImageView = UIImageView()
        
       //http://112.196.34.179/stepslocator/uploads/thumbs/thumb_55a60515103d6.jpg
        let profileStr : (NSString) = singleDict.object(forKey: "img_names") as! NSString
//        if(profileStr == "http://104.236.197.214/profileImages/")
//        {
//            imageView.image = UIImage(named: "")
//        }
//            
//        else
//        {
            let urlString : (NSString) = NSString(format: "%@%@",motivationalImagesUrl,profileStr)
            let profileUrl : (URL) = URL(string: urlString as String)!
            imageView.sd_setImage(with: profileUrl)
        //}
        
       //imageView.image.imageRotatedByDegrees(90, flip: false)
        imageView.frame = CGRect(x: 10, y: 5, width: 70, height: 70)
          //  imageView.contentMode = UIViewContentMode.ScaleAspectFit
        //imageView.backgroundColor = UIColor.clearColor()
         cellView.addSubview(imageView)
        
        var titleLabel : UILabel = UILabel()
        titleLabel.frame = CGRect(x: imageView.frame.maxX + 10, y: 10, width: ScreenSize.width - imageView.frame.width - 63, height: 20)
        titleLabel.font = SMLGlobal.sharedInstance.fontSize(12)
        titleLabel.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        titleLabel.text = singleDict.object(forKey: "image_title")  as? String
        cellView.addSubview(titleLabel)
        
        let sep : UILabel = UILabel()
        sep.frame = CGRect(x: 0, y: titleLabel.frame.height - 1, width: titleLabel.frame.width - 20, height: 1)
        
        sep.backgroundColor  = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1)
        titleLabel.addSubview(sep)
        
        let subtitleLabel : UILabel = UILabel()
        subtitleLabel.frame = CGRect(x: imageView.frame.maxX + 10, y: titleLabel.frame.maxY - 5, width: titleLabel.frame.width - 20, height: 50)
        subtitleLabel.font = SMLGlobal.sharedInstance.fontSize(10)
        subtitleLabel.textColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.5)
        subtitleLabel.numberOfLines = 7
        subtitleLabel.text = singleDict.object(forKey: "image_description") as? String
        cellView.addSubview(subtitleLabel)
        
        
        
        if(tableViewArray.count >= 10)
        {
            //tableView.tableFooterView!.hidden = false
        }
        else
        {
          //tableView.tableFooterView!.hidden = true
        }
        
        if (indexPath as NSIndexPath).row % 2 != 0 {
            
         cellView.backgroundColor = UIColor.white
            
        } else
        {
           
            cellView.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
            
        }
            cell?.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        
        return cell!
        }
        else
        {
            var cell1 = tableView.dequeueReusableCell(withIdentifier: "CELL")
            
            
            if cell1 == nil
            {
                cell1 = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
                // cell!.textLabel?.textColor = UIColor.blackColor()
            }
            
           // println()se
            
            
            //var subviews = cell?.contentView.subviews
            
            
            var subviews = cell1!.contentView.subviews
            for view in subviews
            {
                view.removeFromSuperview()
            }
            
            var cellView : UIView = UIView()
            cellView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 110)
            cellView.backgroundColor = UIColor.clear
            cell1?.contentView.addSubview(cellView)
            
            
            var j = 0
           // println(self.tableViewArray.count)
            var mod = tableViewArray.count % 3
            //var tableCount = tableViewArray.count / 4
            var arrVal = tableViewArray.count / 3
            if mod != 0 {
                arrVal = arrVal + 1
                //println(mod)
            }
            
            //                        for var subView = 0; subView < arrVal; subView++ {
            //                            var valuef : CGFloat = CGFloat(subView)
           // NSLog("%d", gridIndex)
            var subViewFor: UIImageView = UIImageView()
            
            var count : (Int) = 0
            
//            if(tableViewArray.count<3)
//            {
//                
//            
//            }
//            else
//            {
            
//                var leftIndex : (NSInteger) = indexPath.row * 3
//                var middleIndex : (NSInteger) =  leftIndex + 1
//                var rightIndex : (NSInteger) = middleIndex + 1
             var size = (ScreenSize.width - 30)/3
            var imageFrame : (CGRect) = CGRect(x: 10, y: 10, width: size, height: size)
            
                for ij in (indexPath as NSIndexPath).row * 3  ..< (indexPath as NSIndexPath).row * 3 + 3
                {
            
//                for (ij, in (indexPath as NSIndexPath).row * 3  ..< (indexPath as NSIndexPath).row * 3 + 3)
//                {
//                    
                
                    if (ij < self.tableViewArray.count)
                    {
                        subViewFor = UIImageView()
                        let singleDict: (NSDictionary) = self.tableViewArray.object(at: ij) as! (NSDictionary)
                        let profileStr : (NSString) = singleDict.object(forKey: "img_names") as! NSString
//                        if(profileStr == "http://srv.iapptechnologies.com/12steplocator/uploads/thumbs/thumb_")
//                        {
//                            subViewFor.image = UIImage(named: "")
//                            
//                        }
//                        else
//                        {
                            let profileUrl : (URL) = URL(string: NSString(format: "%@%@", motivationalImagesUrl,profileStr) as String)!
                            subViewFor.sd_setImage(with: profileUrl)
                        //}
                        var vv = ScreenSize.width / 3 - 10
                        var valuex : CGFloat = CGFloat(count)
                        subViewFor.tag = ij
                      //  println(ij)
                        subViewFor.frame = imageFrame
                        imageFrame.origin.x = subViewFor.frame.maxX+5
                        //subViewFor.backgroundColor = UIColor.blackColor()
                        subViewFor.isUserInteractionEnabled = true
                        //subViewFor.contentMode = UIViewContentMode.ScaleAspectFit
                        cell1!.contentView.addSubview(subViewFor)
                        
                        var tapGesture : (UITapGestureRecognizer) = UITapGestureRecognizer(target: self, action: #selector(motivationalWallViewController.ImageGesture(_:)))
                        subViewFor.addGestureRecognizer(tapGesture)
                        count = count + 1
                    }
                }
            /*for  j = 0; j<3; j++
            {
                if( j == 0)
                {
                    count = indexPath.row * 3
                }
                else
                {
                  count =  count + 1
                }
//                var leftIndex : (NSInteger) = indexPath.row * 3
//                var middleIndex : (NSInteger) =  leftIndex + 1
//                var rightIndex : (NSInteger) = middleIndex + 1
                
                
//                if tableViewArray.count == gridIndex
//                {
//                    
//                }
//                else
//                    
//                {
                
                    subViewFor = UIImageView()
                    var singleDict: (NSDictionary) = self.tableViewArray.objectAtIndex(count) as! (NSDictionary)
                    
                    // println(singleDict)
                    
                    
                    var profileStr : (NSString) = singleDict.objectForKey("img_names") as! NSString
                    if(profileStr == "http://112.196.34.179/stepslocator/uploads/")
                    {
                        subViewFor.image = UIImage(named: "")
                        
                    }
                    else
                    {
                        var profileUrl : (NSURL) = NSURL(string: NSString(format: "http://112.196.34.179/stepslocator/uploads/%@", profileStr) as String)!
                        subViewFor.sd_setImageWithURL(profileUrl)
                    }
                    
                    
                    var vv = ScreenSize.width / 3 - 10
                    var valuex : CGFloat = CGFloat(j)
                    subViewFor.tag = count
                    subViewFor.frame = CGRectMake((valuex*vv ) + 30 , 10 , 90, 90)
                    subViewFor.backgroundColor = UIColor.blackColor()
                    
                    cell1!.addSubview(subViewFor)
                    
                    var tapGesture : (UITapGestureRecognizer) = UITapGestureRecognizer(target: self, action: "ImageGesture:")
                    subViewFor.addGestureRecognizer(tapGesture)
                    count = count + 1
                    //gridIndex = gridIndex + 1
                    
                //}
            }*/
            //}
            
            cell1!.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
            
            return cell1!
            
            
        }
        
        
}

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if(valv == 0)
        {
         return 80
        }
        else
        {
         return 120
        }
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(tabValue == 1)
        {
            let imageDesc : (imageTitleViewController) = imageTitleViewController()
            
            let singleDict : (NSDictionary) = self.tableViewArray.object(at: (indexPath as NSIndexPath).row) as! (NSDictionary)
            imageDesc.imageDict = singleDict
            self.navigationController?.pushViewController(imageDesc, animated: false)
        }
        else
        {
            let publicPicture : publicPictureViewController = publicPictureViewController()
            let singleDict : (NSDictionary) = self.tableViewArray.object(at: (indexPath as NSIndexPath).row) as! (NSDictionary)
            publicPicture.singleDict = singleDict
            self.navigationController?.pushViewController(publicPicture, animated: false)
        }
    }
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder();
        return true
    }
    
    func ImageGesture(_ gesture:UITapGestureRecognizer)
    {
        let index = gesture.view?.tag
        if(tabValue == 1)
        {
            let imageDesc : (imageTitleViewController) = imageTitleViewController()
            
            let singleDict : (NSDictionary) = self.tableViewArray.object(at: index!) as! (NSDictionary)
            imageDesc.imageDict = singleDict
            self.navigationController?.pushViewController(imageDesc, animated: false)
        }
        else
        {
            let publicPicture : publicPictureViewController = publicPictureViewController()
            
            let singleDict : (NSDictionary) = self.tableViewArray.object(at: index!) as! (NSDictionary)
            publicPicture.singleDict = singleDict
            self.navigationController?.pushViewController(publicPicture, animated: false)
            
        }

    }
     
    //MARK:- Action Methods
    
    func addButtonClick(_ sender: UIButton) {
      
        
        let menuBtn : (UIButton) = sender
        
        
        
        if valv == 0 {
            
            
            //println("Menu Call")
            menuBtn .setImage(UIImage(named: "menu"), for: UIControlState())
            myPicTable.isHidden = true
            gridTable.isHidden = false
            valv = 1
           
            
            if(tabValue == 1)
            {
               self.tableViewArray = self.privateArray
            }
            else
            {
               self.tableViewArray = self.publicArray
            }
             gridTable.reloadData()
            myPicTable.reloadData()
            // myPicTable.removeFromSuperview()
            
           

           
        
        
        } else if valv == 1
        {
            
            menuBtn .setImage(UIImage(named: "blocks"), for: UIControlState())
            gridTable.isHidden = true
            myPicTable.isHidden = false
            valv = 0
            if(tabValue == 1)
            {
                self.tableViewArray = self.privateArray
            }
            else
            {
                self.tableViewArray = self.publicArray
            }
            gridTable.reloadData()
            myPicTable.reloadData()
        }
    }
    
    
    
    
    func myPicture(_ sender: UIButton)
    {
        
        if(self.privateArray.count == 0)
        {
           self.getPrivateMotivationWebservice(0)
        }
        else
        {
            self.tableViewArray = self.privateArray
            if(valv == 0)
            {
            self.myPicTable.reloadData()
            }
            else
            {
            self.gridTable.reloadData()
            }
            //myPicTable.reloadData()
           // gridTable.reloadData()
        }
        
      
       
        addNewPic.isHidden = false
        tabValue  = 1
       // self.tableViewArray = self.privateArray
        if(self.tableViewArray.count>10)
        {
          self.myPicTable.tableFooterView?.isHidden = false
        }
        else
        {
          self.myPicTable.tableFooterView?.isHidden = true
        }
        
         //self.tableViewArray = self.privateArray
//        if(self.tableViewArray.count == 0)
//        {
//            let alertView = UIAlertView(title: "", message:"No Result found", delegate: nil, cancelButtonTitle: "Ok")
//            alertView.show()
//            self.myPicTable.isHidden = true
//        }
//        else
//        {
//          self.myPicTable.isHidden = false
//        }
        
        
        //self.myPicTable.reloadData()
       
        myPic.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
        publicMotivation.backgroundColor = UIColor.clear
        myPic.setTitleColor(UIColor(red: 60.0/255.0, green: 92.0/255.0, blue: 152.0/255.0, alpha: 1.0), for: UIControlState())
        publicMotivation.setTitleColor(UIColor.white, for: UIControlState())
    }
    
    func publicMotivations(_ sender: UIButton)
    {
       
        if(self.publicArray.count == 0)
        {
           self.getPublicMotivationWebservice(0)
        }
        else
        {
            self.tableViewArray = self.publicArray
            if(valv == 0)
            {
                self.myPicTable.reloadData()
            }
            else
            {
                self.gridTable.reloadData()
            }
            //myPicTable.reloadData()
            //gridTable.reloadData()
        }
        
       
       // println(self.tableViewArray)
       
        addNewPic.isHidden = true
        
        self.myPicTable.isHidden = false
        tabValue  = 2
        if(self.publicArray.count > 0)
        {
        self.tableViewArray = self.publicArray
       
        }
        else
        {
          
        }
        
        
        
        
        
//        if(textView.text != "")
//        {
//            var predicate : (NSPredicate) = NSPredicate(format: "SELF.image_title == %@", textView.text)
//            var arr : (NSArray) = self.tableViewArray as NSArray
//            arr = self.tableViewArray.filteredArrayUsingPredicate(predicate)
//            self.tableViewArray = arr.mutableCopy() as! (NSMutableArray)
//        }
       // self.myPicTable.reloadData()
        
        
        
        
        //Grid Display
//        if(valv == 1)
//        {
//            self.gridCall()
//        }
//        else
//        {
//           self.myPicTable.reloadData()
//        }
        
       
        
        
        if(self.tableViewArray.count>10)
        {
            self.myPicTable.tableFooterView?.isHidden = false
        }
        else
        {
            self.myPicTable.tableFooterView?.isHidden = true
        }
        
        
//        if(self.publicArray.count == 0)
//        {
//            var alertView = UIAlertView(title: "", message:"No Result found", delegate: nil, cancelButtonTitle: "Ok")
//            alertView.show()
//        }
      
        myPic.backgroundColor = UIColor.clear
        publicMotivation.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
        publicMotivation.setTitleColor(UIColor(red: 60.0/255.0, green: 92.0/255.0, blue: 152.0/255.0, alpha: 1.0), for: UIControlState())
        myPic.setTitleColor(UIColor.white, for: UIControlState())
    }

    func homeButtonClick(_ sender: UIButton) {
        navigationController!.isNavigationBarHidden = false
        // println("Hello Reja")
        var delegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
        var view = FirstViewController(nibName: nil, bundle: nil)
        delegate.callMethod(view)

    }
    
    
     //MARK:- Webservice Methods
    
    func getPrivateMotivationWebservice(_ lastId : Int)
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
        //SVProgressHUD.showWithStatus("Loading")
        SVProgressHUD.show(withStatus: "Please Wait...", maskType: SVProgressHUDMaskType.black)
        //http://112.196.34.179/stepslocator/index.php/login/wsprivateMotivationalImages?user_id=2&limit=0
        let user : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = user.userId
        let parameters : (NSDictionary) = ["user_id" : loginId,
                                            "limit" : lastId]
        WebserviceManager .sharedInstance.getPrivateMotivationalImages(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                if success == 0
                {
                    let message : NSString = responseObject!.value(forKey: "message") as! NSString
                    SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                    SVProgressHUD .dismiss()
                    self.tableViewArray = NSMutableArray()
                    self.privateArray = NSMutableArray()
                    self.myPicTable.reloadData()
                    self.gridTable.reloadData()
                    // self.navigationController?.popViewControllerAnimated(false)
                }

                else if success == 1
                {
                    self.tableViewArray = NSMutableArray()
                    // self.privateArray = responseObject.valueForKey("data") as! NSMutableArray
                    var arr1  = NSArray()
                    arr1 = responseObject?.object(forKey: "data") as! NSArray
                    print(arr1)
                    self.privateTotalCount = responseObject?.value(forKey: "totalImages") as! Int
                    let jsonUnico : NSArray = responseObject?["data"] as! NSArray
                        print(jsonUnico)
                        for i in 0 ..< jsonUnico.count
                        {
                            let ids : (NSString) = (jsonUnico.object(at: i) as AnyObject).value(forKey: "id") as! NSString
                            //var predicate : (NSPredicate) = NSPredicate(format: "%@", ids)
                            let predicate : (NSPredicate) = NSPredicate(format: "SELF.id == %@", ids)
                            var arr : (NSArray) = NSArray()
                            arr = self.privateArray.filtered(using: predicate) as (NSArray)
                            //IF private Array does not exist current data
                            if(arr.count == 0)
                            {
                            self.privateArray.add(jsonUnico.object(at: i))
                            }
                            //self.tableViewArray = arr.mutableCopy() as! (NSMutableArray)
                        }
                        print("Private Array" ,self.privateArray)
                        self.tableViewArray = self.privateArray
                    //}
                    //But since you’re already doing an as above it, you may as well combine them:
 
                    if(self.tableViewArray.count >= 10)
                    {
                        self.myPicTable.tableFooterView?.isHidden = false
                    }
                    else
                    {
                        self.myPicTable.tableFooterView?.isHidden = true
                    }
                    
                    if(valv == 0)
                    {
                        self.myPicTable.reloadData()
                    }
                    else
                    {
                        self.gridTable.reloadData()
                    }
                    //var arr : (NSArray) = self.tableViewArray
                    // self.myPicTable.reloadData()
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
    
    func getPublicMotivationWebservice(_ lastId : Int)
    {
        if WebserviceManager.sharedInstance.checkNetworkStatus()
        {
        
        SVProgressHUD.show(withStatus: "Loading")
        //http://112.196.34.179/stepslocator/index.php/login/wsPublicMotivationalImages?limit=0&user_id=
        let user : (SMLAppUser) = SMLAppUser.getUser()
        let loginId : (NSString) = user.userId
        let parameters : (NSDictionary) = ["user_id" : loginId,
            "limit" : lastId]
        WebserviceManager .sharedInstance.getPublicMotivationalImages(params: parameters) { (responseObject, error) in
            if responseObject != nil
            {
                let success:NSInteger  = responseObject!.value(forKey: "success")as! NSInteger
                print(responseObject)
                print(success)
                if success == 0
                {
                    let message : (NSString) = responseObject!.value(forKey:"message") as! NSString

                    SMLGlobal.sharedInstance.displayAlertMessage(self, message, title: "")
                    SVProgressHUD .dismiss()
                    self.tableViewArray .removeAllObjects()
                    // self.navigationController?.popViewControllerAnimated(false)
                }
                    
                    
                else if success == 1
                {
                    self.tableViewArray = NSMutableArray()
                    // self.publicArray  = responseObject.valueForKey("data") as! NSMutableArray
                    self.publicTotalCount = responseObject?.value(forKey: "total_images") as! Int
                    let jsonUnico : (NSArray) = responseObject?["data"] as! NSArray
                        
                        //                    if(jsonUnico.count<=10)
                        //                    {
                        //                        self.publicArray = jsonUnico
                        //                        self.tableViewArray = jsonUnico
                        //                    }
                        //                    else
                        //                    {
                        
                        
                        for i in 0 ..< jsonUnico.count
                        {
                            var ids : (NSString) = (jsonUnico.object(at: i) as AnyObject).value(forKey: "id") as! NSString
                            //var predicate : (NSPredicate) = NSPredicate(format: "%@", ids)
                            var predicate : (NSPredicate) = NSPredicate(format: "SELF.id == %@", ids)
                            var arr : (NSArray) = jsonUnico as NSArray
                            arr = self.publicArray.filtered(using: predicate) as (NSArray)
                            if(arr.count == 0)
                            {
                                self.publicArray.add(jsonUnico.object(at: i))
                            }
                        }
                        self.tableViewArray = self.publicArray
                    }
                   
                    
                    //                var alertView = UIAlertView(title: "", message:message as NSString as String, delegate: self, cancelButtonTitle: "Ok")
                    //                alertView.show()
                    SVProgressHUD .dismiss()
               // }
                if(valv == 0)
                {
                    self.myPicTable.reloadData()
                }
                else
                {
                    self.gridTable.reloadData()
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
    
    
    
    
    //MARK:- Collection Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? UICollectionViewCell
        let imageView : UIImageView = UIImageView()
        
        
        let profileStr : (NSString) = appUser.profilePic
        if(profileStr == "http://104.236.197.214/profileImages/")
        {
            imageView.image = UIImage(named: "")
            
        }
        else
        {
            let profileUrl : (URL) = URL(string: profileStr as String)!
            imageView.sd_setImage(with: profileUrl)
        }
       
       // println("Hello")
        return cell1!
 
    }
    
    func gridCall()
    {

        
        var subviews = gridView.subviews
        for v in subviews
        {
            v.removeFromSuperview()
        }
      
        
        if ScreenSize.width == 320
        {
            
            var i = 0
            var j = 0
            
            var mod = tableViewArray.count % 3
            //var tableCount = tableViewArray.count / 4
            var arrVal = tableViewArray.count / 3
            if mod != 0 {
                arrVal = arrVal + 1
               // println(mod)
            }
            
            for subView in 0 ..< arrVal {
                var valuef : CGFloat = CGFloat(subView)
                
                  var subViewFor: UIImageView = UIImageView()
                for j in 0..<3
//                for  j = 0; j<3; j += 1 
                {
                    if tableViewArray.count == i {
                        
                    } else
                    
                    {
                        subViewFor = UIImageView()
                        var singleDict: (NSDictionary) = self.tableViewArray.object(at: i) as! (NSDictionary)
                        
                       // println(singleDict)
                        
                        
                        var profileStr : (NSString) = singleDict.object(forKey: "img_names") as! NSString
//                        if(profileStr == "http://srv.iapptechnologies.com/12steplocator/uploads/")
//                        {
//                            subViewFor.image = UIImage(named: "")
//                            
//                        }
//                        else
//                        {
                            var profileUrl : (URL) = URL(string: NSString(format: "%@%@",motivationalImagesUrl, profileStr) as String)!
                            subViewFor.sd_setImage(with: profileUrl)
                       // }
                        
                        
                        var vv = ScreenSize.width / 3 - 10
                        var valuex : CGFloat = CGFloat(j)
                        subViewFor.tag = i
                        subViewFor.frame = CGRect(x: (valuex*vv ) + 20 , y: (valuef*vv) + 15 , width: 90, height: 90)
                        subViewFor.backgroundColor = UIColor.black
                        gridView.addSubview(subViewFor)
                        i = i + 1
                        
                        
                        
                    }
                    
                    
                    
                    
                }
                
                gridView.contentSize = CGSize(width: gridView.frame.size.width, height: subViewFor.frame.maxY + 10)
                
            }
            
        } else {
            var i = 0
            var j = 0
            
            var mod = tableViewArray.count % 4
            //var tableCount = tableViewArray.count / 4
            var arrVal = tableViewArray.count / 4
            if mod != 0 {
                arrVal = arrVal + 1
               // println(mod)
            }
            
            
            var subViewFor : (UIImageView) = UIImageView()
            
            for subView in 0 ..< arrVal {
                var valuef : CGFloat = CGFloat(subView)
                
                
                for i in 0..<4
                {
                    if tableViewArray.count == i {
                        
                    } else {
                       // var subViewFor: UIImageView = UIImageView()
                        
                         subViewFor = UIImageView()
                        var singleDict: (NSDictionary) = self.tableViewArray.object(at: i) as! (NSDictionary)
                        
                       // println(singleDict)
                        
                        
                        var profileStr : (NSString) = singleDict.object(forKey: "img_names") as! NSString
//                        if(profileStr == "http://104.236.197.214/profileImages/")
//                        {
//                            subViewFor.image = UIImage(named: "")
//                            
//                        }
//                        else
//                        {
                            var profileUrl : (URL) = URL(string: NSString(format: "%@%@", motivationalImagesUrl,profileStr) as String)!
                            subViewFor.sd_setImage(with: profileUrl)
                        //}
                        var vv = ScreenSize.width / 4
                        var valuex : CGFloat = CGFloat(j)
                        subViewFor.tag = i
                        subViewFor.frame = CGRect(x: (valuex*vv ) + 7 , y: (valuef*vv) + 10 , width: 80, height: 80)
                        subViewFor.backgroundColor = UIColor.black
                        gridView.addSubview(subViewFor)
                    }
                    
                }
            }
             gridView.contentSize = CGSize(width: gridView.frame.size.width, height: subViewFor.frame.maxY+10)
        }
        
        
        
       
}
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
    }
}
