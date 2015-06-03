//
//  ChoiceHistory.h
//  Future-Shock
//
//  Created by Peter Woodrow on 6/1/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Choice, Round;

@interface ChoiceHistory : NSManagedObject

@property (nonatomic, retain) NSDate * choiceCreatedAt;
@property (nonatomic, retain) Round *round;
@property (nonatomic, retain) Choice *choiceMade;

@end
