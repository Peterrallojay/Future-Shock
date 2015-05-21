//
//  Choice.h
//  Future-Shock
//
//  Created by Michael Sacks on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Choice : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * destination;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSManagedObject *choicesToRound;

@end
