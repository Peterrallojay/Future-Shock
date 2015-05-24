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


//NEED CLARIFICATION use this to set static delay based on user local time (if(nighttime){set delay of 8 hours})
static NSString const *timestampKey = @"timeStamp";

static NSString const *roundIdentifierKey = @"roundIdentifierKey";
static NSString const *messagesKey = @"messages";
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

//creates shared instance of roundLoader
+ (RoundLoader *)sharedInstance {
    static RoundLoader *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RoundLoader new];
        //FIX[self importIfNeeded];
    });
    return sharedInstance;
}

//loads JSON dictionary to self
- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary {
    self = [super init];
    [self loadJSONDictionary:dictionary];
    return self;
}

//only loads the first time the app is launched and if app is not in background
- (void)importIfNeeded {
    BOOL hasLaunched = [[NSUserDefaults standardUserDefaults] boolForKey:@"hasLaunched"];
    if (!hasLaunched) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"story" withExtension:@"json"];
        [self importJSONDataAtURL:url];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasLaunched"];
    }
}

- (void)importJSONDataAtURL:(NSURL *)url {
    
    NSError *error;
    
    NSArray *allRounds = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:url] options:NSJSONReadingAllowFragments error:&error];
    
    NSLog(@"%@", error.description);
    
    for (NSDictionary *dictionary in allRounds) {
        [self loadJSONDictionary:dictionary];
        NSLog(@"%@", dictionary);
    }
    
}

//assigns model object properties based on JSON dictionary
- (void)loadJSONDictionary:(NSDictionary *)dictionary {
    if(self) {
        
        //sets the values of the round keys to roundLoader array properties. Note same string values as messages/choices key declared as statics
        [dictionary setValue:self.choicesArray forKey:@"choices"];
        [dictionary setValue:self.messagesArray forKey:@"messages"];
        
        //sets up round + properties
        self.round = [NSEntityDescription insertNewObjectForEntityForName:@"Round" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
        
        self.round.identifier = dictionary[roundIdentifierKey];
        self.round.choices = dictionary[choicesKey];
        self.round.messages = dictionary[messagesKey];
        self.round.sourceChoice = self.sourceChoice;
        
        //sets up choices for round
        for (NSDictionary *choicesDictionary in self.round.choices) {
            self.choice = [NSEntityDescription insertNewObjectForEntityForName:@"Choice" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
            self.choice.identifier = choicesDictionary[choicesIdentifierKey];
            self.choice.text = choicesDictionary[choicesTextKey];
            
            //this sets an instance of round that the choice will point to.
            self.choice.destinationRound = choicesDictionary[choicesDestinationKey];
            
            //this sets which round the choice lives in.
            self.choice.round = self.round;
        }
        
        //sets up messages for round
        for (NSDictionary *messagesDictionary in self.round.messages) {
            self.message = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
            self.message.text = messagesDictionary[messageTextKey];
            self.message.distanceDelay = messagesDictionary[messageDistanceDelayKey];
            self.message.timeDelay = messagesDictionary[messageTimeDelayKey];
            self.message.round = self.round;
        }
    }
}

//PW5.25.15 - REST OF IMPLEMENTATION NEEDED
- (Round *)getNewRound:(NSDictionary *)dict WithIdentifier:(NSInteger)identifier {
    Round *newRound = [NSEntityDescription insertNewObjectForEntityForName:@"Round" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
}



- (void)save
{
    [[Stack sharedInstance].managedObjectContext save:nil];
}


@end
