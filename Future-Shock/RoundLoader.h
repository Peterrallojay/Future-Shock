//
//  RoundController.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Round.h"
#import "Message.h"
#import "Choice.h"

@interface RoundLoader : NSObject

@property (nonatomic) NSInteger *identifier;
@property (nonatomic, strong) Round *round;
@property (nonatomic, strong) Message *message;
@property (nonatomic, strong) Choice *choices;

@property (nonatomic, strong, readonly) NSArray *messages;

+ (RoundLoader *)sharedInstance;
- (Round *)getNewRound:(NSArray *)arr WithIdentifier:(NSInteger)identifier;

@end
