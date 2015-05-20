//
//  Choices_Model.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Choices_Model : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * destination;
@property (nonatomic, retain) NSNumber * triggerTime;
@property (nonatomic, retain) NSString * triggerLongitude;
@property (nonatomic, retain) NSNumber * triggerLatitude;
@property (nonatomic, retain) NSString * triggerCurrentLocationLatitude;
@property (nonatomic, retain) NSString * triggerCurrentLocationLongitude;
@property (nonatomic, retain) NSString * triggerDistanceFromOrigin;
@property (nonatomic, retain) NSManagedObject *choicesToRound;

@end
