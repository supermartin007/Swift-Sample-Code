//
//  notes.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 10/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import CoreData
var meetingValue = [MeetingFinder]()
var new1 = NSManagedObject()
//var meetingItem = NSManagedObject()
var finalValue = [NSManagedObject]()
var valu = "nil"
var pass = 0
class notes: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, NSFetchedResultsControllerDelegate,UITextFieldDelegate {
    
    var meetingNavigationView: UIView = UIView()
    var meetingTableView :UITableView = UITableView()
    var textView : UITextField = UITextField()
    

  //let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
    //let managedObjectContext = (UIApplication.sharedApplication().delegatas as! AppDelegate).managedObjectContext
  
    
    
    
    let contentCellIdentifier = "Cell"
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
       
        meetingNavigationView.frame = CGRect(x: 0, y: 0, width: ScreenSize.width, height: 100)
        meetingNavigationView.backgroundColor = UIColor(red: 0 / 255.0, green:135.0 / 255, blue: 206.0 / 255, alpha: 1.0)
        self.view.addSubview(meetingNavigationView)
        
         let sgmentViewHeight = meetingNavigationView.frame.height
        /* Hide Navigation Bar */
        self.navigationController!.isNavigationBarHidden = true
        /* Hide Navigation Back Button */
        self.navigationItem.hidesBackButton = true
        
        
        
        meetingTableView.frame = CGRect(x: 0, y: meetingNavigationView.frame.maxY, width: ScreenSize.width, height: ScreenSize.height - meetingNavigationView.frame.maxY)
        self.view.addSubview(meetingTableView)
        
        meetingTableView.register(UINib(nibName: "notesCell", bundle: nil), forCellReuseIdentifier: contentCellIdentifier)
        meetingTableView.delegate = self
        meetingTableView.dataSource = self
        meetingTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        let meetingNodeTitel: UILabel = UILabel()
        meetingNodeTitel.text = "Notes"
        meetingNodeTitel.font = SMLGlobal.sharedInstance.fontSize(14)
        meetingNodeTitel.textColor = UIColor.white
        
        meetingNavigationView.addSubview(meetingNodeTitel)
        
        let leftHomeButton : UIButton = UIButton()
        let homeImage: UIImage = UIImage(named: "home")!
        leftHomeButton.setBackgroundImage(homeImage, for: UIControlState())
        leftHomeButton.addTarget(self, action: #selector(notes.homeButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
       
        meetingNavigationView.addSubview(leftHomeButton)
        
        /* Create Top Custom Right Button View */
        
        let addButton: UIButton = UIButton()
        
         addButton.addTarget(self, action: #selector(notes.addButtonClick(_:)), for: UIControlEvents.touchUpInside)
        //rightButton.backgroundColor = UIColor.whiteColor()
        let rightButtonImage: UIImage = UIImage(named: "add_icon")!
        //homeImage.contentMode = UIViewContentMode.ScaleAspectFit
        addButton.setBackgroundImage(rightButtonImage, for: UIControlState())
        meetingNavigationView.addSubview(addButton)
        
        
        
       
     
      
       
      
        
        
        let screenMid = ScreenSize.width / 2
        
        if (self.view.frame.height >= 667.0) {
            
            
            
            meetingNodeTitel.frame = CGRect(x: screenMid - 20, y: sgmentViewHeight / 4, width: 100, height: 30)
           
         
            
             //addButton.frame = CGRectMake(ScreenSize.width - 44, sgmentViewHeight / 4, 30, 30)
            

            
        } else {
             meetingNodeTitel.frame = CGRect(x: screenMid - 20 , y: sgmentViewHeight / 4, width: 100, height: 30)
            //leftHomeButton.frame = CGRectMake(16, sgmentViewHeight / 3.8, 25, 25)
           

        }
        addButton.frame = CGRect(x: ScreenSize.width - 44, y: sgmentViewHeight / 3.8, width: 31, height: 32)
        leftHomeButton.frame = CGRect(x: 16, y: 25, width: 30 , height: 30)
  /* Create  Custom Search text Field */
        
        let value = meetingNavigationView.frame.height - 50
        
        let searchView: UIButton = UIButton()
        searchView.frame = CGRect(x: 20, y: value + 13, width: ScreenSize.width - 40,  height: 20 * 1.35)
        searchView.backgroundColor = UIColor.white
        searchView.layer.cornerRadius = 0.04 * searchView.frame.width
        searchView.layer.borderColor = UIColor.clear.cgColor
        //searchBarView.showsBookmarkButton = true
        searchView.clipsToBounds = true
        meetingNavigationView.addSubview(searchView)
        
        
         textView.frame = CGRect(x: 30, y: 0, width: searchView.frame.width - 50,  height: 20 * 1.35)
        textView.delegate = self
        let placeholder1 = NSAttributedString(string: "Search by title", attributes: [NSForegroundColorAttributeName : UIColor(red: 0.0 / 255, green: 0.0 / 255, blue: 0.0 / 255, alpha: 0.6)])
        textView.attributedPlaceholder = placeholder1;
        textView.font = SMLGlobal.sharedInstance.fontSize(10)
        searchView.addSubview(textView)
        
                let UIImg : UIButton = UIButton()
                 UIImg.frame = CGRect(x: searchView.frame.width - 27,y: (searchView.frame.size.height - 25)/2, width: 25, height: 25)
              let  butImg = UIImage(named: "search_arrow_icon")
        UIImg.setBackgroundImage(butImg, for: UIControlState())
        UIImg.addTarget(self, action: #selector(notes.searchButt(_:)), for: UIControlEvents.touchUpInside)
                searchView.addSubview(UIImg)
        
        let searchIcon : UIImageView = UIImageView()
      searchIcon.frame = CGRect(x: 5, y: 3.5, width: 20, height: 20)
        searchIcon.image = UIImage(named: "search_icon")
        searchView.addSubview(searchIcon)
        
        
     
      

        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         //println(meetingValue.count)
         meetingLogCall()
        meetingTableView.reloadData()
        self.navigationController?.isNavigationBarHidden = true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  println(fetchedResultController.section)
       // var numberofRows = fetchedResultController.sections?.count
        
        return finalValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//                var contentCell : notesCell = tableView.dequeueReusableCellWithIdentifier(contentCellIdentifier, forIndexPath: indexPath) as! notesCell
//        //let task = fetchedResultController.objectAtIndexPath(indexPath) as! MeetingFinder
//        contentCell.editButton1 .addTarget(notesCell(), action: "EditBtnAction:", forControlEvents: UIControlEvents.TouchUpOutside)
//       
     
//        
//        //
//        
//
         var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as UITableViewCell!
        
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CELL")
            cell?.textLabel?.textColor = UIColor.black
        }
        
         cell!.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        
        let subviews = cell!.contentView.subviews
        for view in subviews
        {
            view.removeFromSuperview()
        }

        let meetingBackView = UIView()
        meetingBackView.backgroundColor = UIColor.red
        meetingBackView.frame = CGRect(x: 10, y: 10, width: self.view.frame.size.width - 20, height: 80 - 20)
       
        meetingBackView.backgroundColor = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
        cell?.contentView.addSubview(meetingBackView)
        
 
        let meetingItem  = finalValue[(indexPath as NSIndexPath).row]
        //contentCell.meetingLabel.text = meetingItem.valueForKey("meetingName") as? String
        //contentCell.dateLabel.text = meetingItem.valueForKey("meetingDate") as? String
        
        let meetingName = UILabel()
        meetingName.text =  meetingItem.value(forKey: "meetingName") as? String
        meetingName.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        meetingName.font = SMLGlobal.sharedInstance.fontSize(12)
        meetingName.frame = CGRect(x: 10, y: 10, width: meetingBackView.frame.size.width - 90, height: 15)
        meetingBackView.addSubview(meetingName)
        
        let meetingDate = UILabel()
        meetingDate.text =  meetingItem.value(forKey: "meetingDate") as? String
        meetingDate.frame = CGRect(x: 10, y: meetingName.frame.maxY + 10, width: 100, height: 20)
        meetingDate.font = SMLGlobal.sharedInstance.fontSize(12)
        meetingDate.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        meetingBackView.addSubview(meetingDate)
        
        let deleteButton : (UIButton) = UIButton.init(type: UIButtonType.custom)
        deleteButton.setImage(UIImage(named: "delet_icon"), for: UIControlState())
        deleteButton.frame = CGRect(x: meetingBackView.frame.size.width - 40, y: (60 - 25)/2, width: 25, height: 25)
        deleteButton.tag = indexPath.row
        deleteButton .addTarget(self, action: #selector(notes.deleteData(_:)), for: UIControlEvents.touchUpInside)
        meetingBackView.addSubview(deleteButton)
        
        let linesep: UIView = UIView()
        linesep.frame =  CGRect(x: meetingBackView.frame.size.width - 43, y: (60 - 15)/2, width: 1, height: 15)
        linesep.backgroundColor = UIColor(red: 200 / 255, green: 200 / 255, blue: 200 / 255, alpha: 1)
        meetingBackView.addSubview(linesep)
        let editButton : (UIButton) = UIButton.init(type: UIButtonType.custom)
        editButton.setImage(UIImage(named: "edit_icon"), for: UIControlState())
       
        editButton.addTarget(self, action: #selector(notes.editButton(_:)), for: UIControlEvents.touchUpInside)
        editButton.frame = CGRect(x: meetingBackView.frame.size.width - 70, y: (60 - 25)/2, width: 25, height: 25)
        meetingBackView.addSubview(editButton)
        
        
        let str = meetingItem.value(forKey: "uniqueID") as? String
        if str == nil {
            //meetingTableView.reloadData()
        } else {
            let tagValuef : (Int) = Int(str!)!
             deleteButton.tag = tagValuef
             editButton.tag = tagValuef
        }

        return cell!
        
                     // return contentCell
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        //meetingTableView.reloadData()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        pass = 0
         let meetingItem  = finalValue[(indexPath as NSIndexPath).row]
        //println(meetingItem)
        meetingNamemeetingNotes.text = meetingItem.value(forKey: "meetingName") as? String
        meetingDatemeetingNotes.text = meetingItem.value(forKey: "meetingDate") as? String
        meetingDescriptionmeetingNotes.text = meetingItem.value(forKey: "meetingDescription") as? String
        valu = (meetingItem.value(forKey: "uniqueID") as? String)!
          meetingTableView.reloadData()
         let meeting : meetingNotes = meetingNotes()
        self.navigationController?.pushViewController(meeting, animated: false)
        
        
    }
    
    func editButton(_ sender: UIButton)
    {
        pass = 1
        let intValue = sender.tag
        print(intValue)
      //  let editData  = finalValue[intValue] as NSManagedObject

        let Strng = "\(intValue)"
        valu = Strng
         //println(sender.tag)
       // println("Value: \(valu)")
        let appDel:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        var context : NSManagedObjectContext!
        if #available(iOS 10.0, *) {
            context = appDel.managedObjectContext!
        } else {
            // Fallback on earlier versions
        }
        //var addNotes = NSEntityDescription.insertNewObjectForEntityForName("MeetingFinder",inManagedObjectContext: context) as! NSManagedObject
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"MeetingFinder")
        if let fetchResults = try? context!.fetch(fetchRequest)
        {
            print(fetchResults)
        
//        var request = NSFetchRequest<NSFetchRequestResult>(entityName:"MeetingFinder")
        //request .predicate = NSPredicate("")
        fetchRequest.returnsObjectsAsFaults = false
//        var results = context.executeFetchRequest(request, error: nil)
        if (fetchResults.count > 0)
        {
//            meetingNamemeetingNotes.text = editData.value(forKey: "meetingName") as? String
//            meetingNamemeetingNotes.text = editData.value(forKey: "meetingName") as? String
//            meetingDatemeetingNotes.text = editData.value(forKey: "meetingDate") as? String
//            meetingDescriptionmeetingNotes.text = editData.value(forKey: "meetingDescription") as? String
//            valu = "0"
//           // valu  = (editData.value(forKey: "uniqueID") as? String)!
//            let meeting : meetingNotes = meetingNotes()
//            self.navigationController?.pushViewController(meeting, animated: false)

            for result in fetchResults {
                if let user = (result as AnyObject).value(forKey:"uniqueID") as? String {
                  //  println("\(results) uniqueID")
                    if user == Strng {
                      //  println("\(results) equal")
                        meetingNamemeetingNotes.text = (result as AnyObject).value(forKey: "meetingName") as? String
                        meetingDatemeetingNotes.text = (result as AnyObject).value(forKey:"meetingDate") as? String
                        meetingDescriptionmeetingNotes.text = (result as AnyObject).value(forKey:"meetingDescription") as? String
                        valu  = ((result as AnyObject).value(forKey:"uniqueID") as? String)!

                        let meeting : meetingNotes = meetingNotes()
                        self.navigationController?.pushViewController(meeting, animated: false)
                    }
                    
                }
            }
        }
    }
    }
    
    
    
    func homeButtonClick(_ sender: UIButton) {
        self.navigationController!.isNavigationBarHidden = false
        self.navigationController?.popViewController(animated: false)
    }
    
    
    func addButtonClick(_ sender: UIButton)
    {
        let addNote : (addnewNote) = addnewNote()
        self.navigationController?.pushViewController(addNote, animated: false)
        //
        //println(meetingValue.count)
    }
    
    

    
    func meetingLogCall() {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var managedContext : (NSManagedObjectContext)!
        if #available(iOS 10.0, *) {
            managedContext = appDelegate.managedObjectContext!
        } else {
            // Fallback on earlier versions
        }
        print(managedContext)
        
        //2
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"MeetingFinder")
        let sortDescriptor = NSSortDescriptor(key: "uniqueID", ascending: false, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        fetchRequest.sortDescriptors = [sortDescriptor]
        //3
        //var error: NSError?
        
//        let fetchedResults =
//        managedObjectContext.executeFetchRequest(fetchRequest,
//            error: &error) as? [NSManagedObject]
//        var array = NSArray()
        
        
        if let fetchResults = try? managedContext!.fetch(fetchRequest)
        {
            finalValue = fetchResults as! [NSManagedObject]
            
            if(finalValue.count == 0)
            {
                let alertView = UIAlertView(title: "", message:"No Notes Saved", delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
            }
           
        } else
        {
            //println("Could not fetch \(error), \(error!.userInfo)")
        }
        
    }
    
    func deleteData(_ sender:UIButton) {
        
        print(finalValue)
        let intValue = sender.tag
        let Strng = "\(intValue)"
        var managedObjectContext : (NSManagedObjectContext)!
        if #available(iOS 10.0, *) {
                           managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
                        } else {
                            // Fallback on earlier versions
                        }
//        if finalValue.count == 0 {
////            print("Data Not Found")
////        } else {
//            if #available(iOS 10.0, *) {
//               managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
//            } else {
//                // Fallback on earlier versions
//            }
//       
//        managedObjectContext.delete(finalValue[0] as NSManagedObject)
//        finalValue.remove(at: 0)
//            do {
//                try managedObjectContext!.save()
//            } catch {
//                let nserror = error as NSError
//                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
//                abort()
//                meetingTableView.reloadData()
//        }
//        }
////        if finalValue.count == 0
////        {
////        }
//        else {
        //var addNotes = NSEntityDescription.insertNewObjectForEntityForName("MeetingFinder",inManagedObjectContext: context) as! NSManagedObject
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"MeetingFinder")
        //request .predicate = NSPredicate("")
        request.returnsObjectsAsFaults = false
        do {
            let results = try managedObjectContext.fetch(request)
            for result in results
            {
                let ids = (result as AnyObject).value(forKey: "uniqueID") as! String
                print(ids)
                print(Strng)
                if ids == Strng {
                    managedObjectContext.delete(result as! NSManagedObject)
                }
            }
        

                        //                        if context.hasChanges {
                        do {
                            try managedObjectContext.save()
                        } catch {
                            // Replace this implementation with code to handle the error appropriately.
                            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                            let nserror = error as NSError
                            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                        }
        }
        catch
        {
            
        }
            

                        
//                    }
                   // }
                //}
            //}
        
//        var results = managedObjectContext.executeFetchRequest(request)
//        if (results?.count > 0) {
//            for result: AnyObject in results! {
//                if let user = result.valueForKey("uniqueID") as? String {
//                    if user == Strng {
//                        context.deleteObject(result as! NSManagedObject)
//                    } else if user == "nil" {
//                        context.deleteObject(result as! NSManagedObject)
//                    }
//                }
//                context.save(nil)
//                
//            }
//        }
        
            self.meetingLogCall()
            
     meetingTableView.reloadData()
    }
    //}
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField .resignFirstResponder()
        
        return true
    }
    func searchButt(_ sender: UIButton) {
        
        textView.resignFirstResponder()
        //println("Delete All")
        
        let txt = textView.text! as NSString
        print(txt)
        let appDel:AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        var context : NSManagedObjectContext!
        if #available(iOS 10.0, *) {
            context = appDel.managedObjectContext!
        } else {
            // Fallback on earlier versions
        }
        let request = NSFetchRequest<NSFetchRequestResult>(entityName:"MeetingFinder")
        request.returnsObjectsAsFaults = false
        request.predicate = NSPredicate(format: "meetingName MATCHES[cd] '(\(txt)).*'")
        do {
        let results = try context.fetch(request)
        if(results.count == 0)
        {
           UIAlertView(title: "", message: "No Result Found", delegate: nil, cancelButtonTitle: "OK").show()
        }
        else
        {
        }
            finalValue = results as! [NSManagedObject]
            meetingTableView.reloadData()
        }
        catch
        {
            
        }
        
       
      
        
    }
    
     func touchesBegan(_ touches: Set<NSObject>, with event: UIEvent) {
        meetingTableView.reloadData()
    }
    
}
