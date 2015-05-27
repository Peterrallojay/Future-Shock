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
#import "RoundLoader.h"

@interface RoundServer : NSObject
@property (strong, nonatomic, readonly) NSArray *completedRounds;

@property (strong, nonatomic, readonly) NSArray *allRounds;

@property (strong, nonatomic) NSNumber *roundIdentifier;
@property (nonatomic, assign) NSNumber *choiceKey;

- (Round*) completedRound:(Round*)round withChoice:(Choice *)choice;

@end
