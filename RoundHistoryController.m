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
        sharedInstance.roundsUserTraversed = [sharedInstance loadFirstRoundIfNeeded];
        
    });
    return sharedInstance;
}

-(NSArray *)choiceHistory {
    // create fetch request
    //executed by managed object. go to the stack for the choiceHistory
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Choice"];
    
    NSArray *allChoices = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    return allChoices;
    
}

- (NSArray *)loadFirstRoundIfNeeded {
    NSMutableArray *mutableRoundsUserTraversed = [self.roundsUserTraversed mutableCopy];
    
    [mutableRoundsUserTraversed addObject:[[RoundLoader sharedInstance] roundFromRoundIdentifier:0]];
    
    for (ChoiceHistory *choiceHistory in self.choiceHistory) {
        
        int choiceMadeIndex = [choiceHistory.choiceMade intValue];
        
        Choice *choiceMade = [choiceHistory.round.choices objectAtIndex:choiceMadeIndex];
        
        [mutableRoundsUserTraversed addObject:choiceMade.destinationRound];
    }
    
    self.roundsUserTraversed = [mutableRoundsUserTraversed copy];
    
    return self.roundsUserTraversed;
}


- (void)addChoicesMade:(NSNumber *)choicemade withRound:(Round *)round {
    //record how many choices were made by user
    
    ChoiceHistory *choiceHistoryObj = [ChoiceHistory new];
    
    choiceHistoryObj.choiceMade = choicemade;
    choiceHistoryObj.round = round;
    
    NSMutableArray *mutablechoiceHistoryArray = [self.choiceHistory mutableCopy];
    
    [mutablechoiceHistoryArray addObject:choiceHistoryObj];
    
    self.choiceHistory = mutablechoiceHistoryArray;
    [self save];
    
}

- (void)save
{
    [[Stack sharedInstance].managedObjectContext save:nil];
}

//method to add messages via choicesmade

@end
