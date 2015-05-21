//
//  RoundController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "RoundController.h"
#import "Stack.h"

static NSString * const AllMessagesKey = @"AllMessages";

//these are the keys for using the dictionary to access JSON story parts

static NSString const *messageKey = @"message";
static NSString const *choicesKey = @"choices";
static NSString const *timestampKey = @"timeStamp";

@interface RoundController ()

@property (nonatomic, strong) NSArray *messages;

@end

@implementation RoundController

+ (RoundController *)sharedInstance
{
    static RoundController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RoundController new];
        
        [self importIfNeeded];
    });

    return sharedInstance;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary
{
    self = [super init];

    
    //MIKE START HERE:
//    if(self)
//    {
//        self.round.identifier = dictionary
//        
//        self.choices.identifier
//    }
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


- (NSArray *)messages
{
    //fetch request (load data)
    NSFetchRequest *fetchMessages = [[NSFetchRequest alloc] initWithEntityName:@"Message_Model"];
    
    //add error handling as needed
    NSArray *allMessages = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchMessages error:nil];
    
    return allMessages;
    
}

- (void)save
{
    [[Stack sharedInstance].managedObjectContext save:nil];
}





@end
