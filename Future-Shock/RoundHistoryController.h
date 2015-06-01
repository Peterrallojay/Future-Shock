//
//  RoundHistoryController.h
//  Future-Shock
//
//  Created by Daniel Dayley on 5/29/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChoiceHistory.h"
#import "Round.h"


@interface RoundHistoryController : NSObject

@property (strong, nonatomic, readonly) NSArray *choiceHistory;

- (void)addChoicesMade:(Choice *)choicemade withRound:(Round *)round;

+ (RoundHistoryController *)sharedInstance; //DD added

@end
