//
//  RoundHistoryController.m
//  Future-Shock
//
//  Created by Daniel Dayley on 5/29/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "RoundHistoryController.h"
#import "RoundLoader.h"
#import "RoundServer.h"
#import "Choice.h"
#import "Stack.h"
#import "Round.h"

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
    // executed by managed object. go to the stack for the choiceHistory
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"ChoiceHistory"];
    
    NSArray *allChoices = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    NSMutableArray *allChoicesMutable = [allChoices mutableCopy];
    if (allChoicesMutable.count == 0) {
        ChoiceHistory *firstChoiceHistory = [NSEntityDescription insertNewObjectForEntityForName:@"ChoiceHistory" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
        firstChoiceHistory.round = [[RoundServer allRounds] firstObject];
        NSLog(@"RHC: First history object: %@",firstChoiceHistory.round);
        firstChoiceHistory.choiceCreatedAt = [NSDate date];
        [allChoicesMutable addObject:firstChoiceHistory];
        NSLog(@"RHC: Added first choice: %@", allChoicesMutable[0]);
    }
    
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
    NSLog(@"RHC: Created new history object: %@",choiceHistoryObj);
    
    [self save];
}

- (void)save
{
    [[Stack sharedInstance].managedObjectContext save:nil];
}

//method to add messages via choicesmade

@end
