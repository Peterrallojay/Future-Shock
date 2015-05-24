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
@property (nonatomic, strong) Choice *choice;
@property (nonatomic, strong) Choice *sourceChoice;

@property (nonatomic, strong) NSOrderedSet *choicesArray;
@property (nonatomic, strong) NSOrderedSet *messagesArray;

+ (RoundLoader *)sharedInstance;

- (Round *)getNewRound:(NSDictionary *)dict WithIdentifier:(NSInteger)identifier;

- (void)loadJSONDictionary:(NSDictionary *)dictionary;

// initial attempt at loadJSON method. PW to discuss with Caleb Monday.
//- (void)loadJSONDictionary:(NSDictionary *)dictionary choicesOrderedSet:(NSOrderedSet *)choicesOrderedSet messagesOrderedSet:(NSOrderedSet *)messageOrderedSet sourceChoice:(Choice *)sourceChoice;

@end
