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

+ (RoundLoader *)sharedInstance;

- (void)loadJSONDictionary:(NSDictionary *)dictionary;

- (Round *)createRoundWithDictionary:(NSDictionary *)dictionary;

- (Round *)roundFromRoundIdentifier:(NSInteger)identifier;



@end
