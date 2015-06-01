//
//  RoundHistoryController.m
//  Future-Shock
//
//  Created by Daniel Dayley on 5/29/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "RoundHistoryController.h"
#import "RoundLoader.h"
#import "Choice.h"
#import "Stack.h"

@implementation RoundHistoryController

+ (RoundHistoryController *)sharedInstance {
    
    static RoundHistoryController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RoundHistoryController alloc] init];
    });
    return sharedInstance;
}

-(NSArray *)choiceHistory {
    // create fetch request
    //executed by managed object. go to the stack for the choiceHistory
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ChoiceHistory"];
    
    NSArray *allChoices = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    NSMutableArray *allChoicesMutable = [allChoices mutableCopy];
    
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]initWithKey:@"dateCreatedAt" ascending:YES];
    
    [allChoicesMutable sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    allChoices = allChoicesMutable;
    
    return allChoices;
    
}

- (void)addChoicesMade:(Choice *)choicemade withRound:(Round *)round {
    //record how many choices were made by user
    
    ChoiceHistory *choiceHistoryObj = [NSEntityDescription insertNewObjectForEntityForName:@"ChoiceHistory" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    choiceHistoryObj.choiceMade = choicemade;
    choiceHistoryObj.round = round;
    
    [self save];
}

- (void)save
{
    [[Stack sharedInstance].managedObjectContext save:nil];
}

//method to add messages via choicesmade

@end
