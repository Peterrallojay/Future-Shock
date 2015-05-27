//
//  RoundController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "RoundLoader.h"
#import "Stack.h"

//NEED CLARIFICATION use this to set static delay based on user local time (if(nighttime){set delay of 8 hours})
static NSString const *timestampKey = @"timeStamp";

static NSString const *roundIdentifierKey = @"identifier";
static NSString const *messagesKey = @"messages";
static NSString const *distanceDelayKey = @"distanceDelay";
static NSString const *timeDelayKey = @"timeDelay";
static NSString const *choicesKey = @"choices";
static NSString const *choicesDestinationKey = @"destination";
static NSString const *choicesIdentifierKey = @"identifier";
static NSString const *textKey = @"text";

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
        [sharedInstance importIfNeeded];
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
    
    for (NSDictionary *dictionary in allRounds.reverseObjectEnumerator) {
        [self createRoundWithDictionary:dictionary];
        [self save];
    }
}

//assigns model object properties based on JSON dictionary
- (Round *)createRoundWithDictionary:(NSDictionary *)dictionary {
    
    Round *round = [NSEntityDescription insertNewObjectForEntityForName:@"Round" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    round.identifier = dictionary[@"indentifier"];
    
    // set up messages
    
    NSArray *messageDictionaries = dictionary[@"messages"];
    
    for (NSDictionary *messageDictionary in messageDictionaries) {
        Message *message = [NSEntityDescription insertNewObjectForEntityForName:@"Message" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
        
        message.text = messageDictionary[@"text"];
        
        if (messageDictionary[@"timeDelay"] != [NSNull null]) {
            message.timeDelay = messageDictionary[@"timeDelay"];
        }
        
        if (messageDictionary[@"distanceDelay"] != [NSNull null]) {
            message.distanceDelay = messageDictionary[@"distanceDelay"];
        }
        
        message.round = round;
    }
    
    // set up choices
    
    NSArray *choiceDictionaries = dictionary[@"choices"];
    
    for (NSDictionary *choiceDictionary in choiceDictionaries) {
        Choice *choice = [NSEntityDescription insertNewObjectForEntityForName:@"Choice" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];

        choice.text = choiceDictionary[@"text"];
        choice.identifier = choiceDictionary[@"identifier"];
        
        choice.round = round;
        
        NSInteger destinationRoundIdentifier = [choiceDictionary[@"identifier"] integerValue];
        
        choice.destinationRound = [self roundFromRoundIdentifier:destinationRoundIdentifier];
    }
    
    return round;
}

- (Round *)roundFromRoundIdentifier:(NSInteger)identifier {
    
    NSError *error;
        
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Round"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier == %@", [NSNumber numberWithInteger:identifier]];
    fetchRequest.predicate = predicate;
    
    NSArray *array = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (array.firstObject) {
        return array.firstObject;
    } else {
        return nil;
    }
}


- (void)save
{
    [[Stack sharedInstance].managedObjectContext save:nil];
}


@end
