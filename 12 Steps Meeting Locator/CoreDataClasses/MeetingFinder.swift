//
//  MeetingFinder.swift
//  12 Steps Meeting Locator
//
//  Created by iApp on 16/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

import Foundation
import CoreData

class MeetingFinder: NSManagedObject {

    @NSManaged var meetingDescription: String
    @NSManaged var meetingDate: String
    @NSManaged var meetingName: String
    @NSManaged var uniqueID: String

}
