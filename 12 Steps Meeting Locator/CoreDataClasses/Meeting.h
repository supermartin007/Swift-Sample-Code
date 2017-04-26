//
//  Meeting.h
//  12 Steps Meeting Locator
//
//  Created by iApp on 16/06/15.
//  Copyright (c) 2015 iapp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Meeting : NSManagedObject

@property (nonatomic, retain) NSString * meetingName;
@property (nonatomic, retain) NSString * meetingDate;
@property (nonatomic, retain) NSString * meetingDesc;

@end



