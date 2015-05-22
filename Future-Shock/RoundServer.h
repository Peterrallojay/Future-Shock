//
//  RoundServer.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/22/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Round.h"
#import "Choice.h"

@interface RoundServer : NSObject

@property (strong, nonatomic) NSArray *completedRounds;

- (Round*) completedRound:(Round*)round withChoice:(Choice *)choice;

@end
