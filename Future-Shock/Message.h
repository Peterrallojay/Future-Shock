//
//  Message.h
//  Future-Shock
//
//  Created by Michael Sacks on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * timeDelay;
@property (nonatomic, retain) NSNumber * distanceDelay;
@property (nonatomic, retain) NSManagedObject *messgeToRound;

@end
