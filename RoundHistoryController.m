//
//  RoundHistoryController.m
//  Future-Shock
//
//  Created by Daniel Dayley on 5/29/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "RoundHistoryController.h"

@implementation RoundHistoryController

+ (RoundHistoryController *)sharedInstance {
    
    static RoundHistoryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RoundHistoryController alloc] init];
    });
    return sharedInstance;
}

- (void)addChoicesMade

//method to add messages via choicesmade
- (NSArray *)persistedMessages:()



@end
