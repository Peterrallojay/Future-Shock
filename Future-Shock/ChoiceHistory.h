//
//  ChoiceHistory.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/29/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Round;

@interface ChoiceHistory : NSManagedObject

@property (nonatomic, retain) NSNumber * choiceMade;
@property (nonatomic, retain) Round *round;

@end
