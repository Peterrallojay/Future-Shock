//
//  RoundController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "RoundLoader.h"
#import "Stack.h"

static NSString * const AllMessagesKey = @"AllMessages";

//these are the keys for using the dictionary to access JSON story parts

//NEED CLARIFICATION Ask Caleb - do we use messagesKey to iterate through message array for each individual message?
static NSString const *messagesKey = @"messages";

//NEED CLARIFICATION use this to set static delay based on user local time (if(nighttime){set delay of 8 hours})
static NSString const *timestampKey = @"timeStamp";

static NSString const *roundIdentifierKey = @"roundIdentifierKey";
static NSString const *messageKey = @"message";
static NSString const *messageTextKey = @"messageText";
static NSString const *messageDistanceDelayKey = @"messageDistanceDelay";
static NSString const *messageTimeDelayKey = @"messageTimeDelay";
static NSString const *choicesKey = @"choices";
static NSString const *choicesDestinationKey = @"choicesDestination";
static NSString const *choicesIdentifierKey = @"choicesIdentifier";
static NSString const *choicesTextKey = @"choicesText";

@interface RoundLoader ()

@property (nonatomic, strong) NSArray *messages;

@end

@implementation RoundLoader

+ (RoundLoader *)sharedInstance {
    static RoundLoader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RoundLoader new];
        [self importIfNeeded];
    });
    return sharedInstance;
}


- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary {
    self = [super init];
    [self loadJSONDictionary:dictionary];
    return self;
}

- (void)loadJSONDictionary:(NSDictionary *)dictionary {
    if(self) {
        self.round.identifier = dictionary[roundIdentifierKey];
        
        self.message.text = dictionary[messageTextKey];
        self.message.distanceDelay = dictionary[messageDistanceDelayKey];
        self.message.timeDelay = dictionary[messageTimeDelayKey];
        
        self.choices.destination = dictionary[choicesDestinationKey];
        self.choices.identifier = dictionary[choicesIdentifierKey];
        self.choices.text = dictionary[choicesTextKey];
        
        self.messages = dictionary[messagesKey];
    }
}

+ (void)importIfNeeded {
    BOOL hasLaunched = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunched"];
    if (!hasLaunched) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"story" withExtension:@"json"];
        [self importJSONDataAtURL:url];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunched"];
    }
}

+ (void)importJSONDataAtURL:(NSURL *)url {
    
    NSError *error;
    
    NSArray *allRounds = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"%@", error.description);
    
    for (NSDictionary *dictionary in allRounds) {
        
        // convert rounds to core data objects and save the managed object context
        
        NSLog(@"%@", dictionary);
    }

}

- (Round *)getNewRound:(NSArray *)arr WithIdentifier:(NSInteger)identifier {
    NSDictionary *individualRound = [arr objectAtIndex:identifier];
    Round *newRound = [[Round alloc] initWithJSONRoundDictionary:individualRound];
    
    return newRound;
}


- (void)save
{
    [[Stack sharedInstance].managedObjectContext save:nil];
}


@end
