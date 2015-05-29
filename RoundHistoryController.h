//
//  RoundHistoryController.h
//  Future-Shock
//
//  Created by Daniel Dayley on 5/29/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChoiceHistory.h"

@interface RoundHistoryController : NSObject

@property (strong, nonatomic) NSArray *choiceHistory;
@property (strong, nonatomic) NSArray *roundsUserTraversed;

@end
