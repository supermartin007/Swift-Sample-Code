//
//  CoreDataHelper.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 16/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import UIKit
import CoreData

private let singletonClass = CoreDataHelper()
class CoreDataHelper: NSObject {
    
    
    
    
    class var sharedInstance: CoreDataHelper {
        return singletonClass
    }
    
    //1
//    let appDelegate =
//    UIApplication.sharedApplication().delegate as! AppDelegate
//    
//    let managedContext = appDelegate.managedObjectContext!
//    
//    //2
//    let fetchRequest = NSFetchRequest(entityName:"Person")
//    
//    //3
//    var error: NSError?
//    
//    let fetchedResults =
//    managedContext.executeFetchRequest(fetchRequest,
//        error: &error) as? [NSManagedObject]
//    
//    if let results = fetchedResults {
//        people = results
//    } else {
//    println("Could not fetch \(error), \(error!.userInfo)")
//    }

    
    func saveData(_ dict:NSDictionary)
    {
        let userValue: AnyObject? = UserDefaults.standard.object(forKey: "MeetingDetail") as AnyObject?
        if ((userValue) != nil)
        {
          
        }
        
    
        
       
    }
    
    func getData()
    {
        
    }
    
    func editData()
    {
        
    }
    
    
    
    
   
}
