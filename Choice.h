//
//  Choice.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/23/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Round;

@interface Choice : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) Round *round;
@property (nonatomic, retain) Round *destinationRound;

@end
