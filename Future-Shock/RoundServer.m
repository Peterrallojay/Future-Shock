//
//  RoundServer.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/22/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "RoundServer.h"

@interface RoundServer ()
@property (strong, nonatomic) NSArray *completedRounds;

@end

@implementation RoundServer

- (BOOL)isRoundComplete:(Round *)round
{
    NSNumber *completedRoundKey;
    
    //PW: NEED logic here to define how to use completed round key.
    
    if (round.identifier == completedRoundKey) {
        
        //first safely adds the round to completedRounds array
        NSMutableArray *mutablecompletedRounds = [self.completedRounds mutableCopy];
        [mutablecompletedRounds addObject:round];
        
        self.completedRounds = mutablecompletedRounds;
        
        //then returns yes
        return  YES;
    }
    
    
    return NO;
}
//gives next round based on completed choice
- (Round*) completedRound:(Round*)round withChoice:(Choice *)choice {
    
    
    if ([self isRoundComplete:round]) {
        if (choice == ) {
            <#statements#>
        }
    }
}

@end
