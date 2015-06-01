//
//  RoundServer.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/22/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "RoundServer.h"
#import "Stack.h"

@interface RoundServer ()
@property (strong, nonatomic) NSArray *completedRounds;

@end

@implementation RoundServer

@synthesize currentRound = _currentRound;

+ (RoundServer *)sharedInstance {
    
    static RoundServer *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[RoundServer alloc] init];
        
    });
    return sharedInstance;
}

-(int)currentRound {
    NSNumber *returnedNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentRound"];
    _currentRound = [returnedNumber intValue];
    return _currentRound;
}

-(void)addNewRound {
    self.currentRound++;
    NSNumber *conversionNumber = [[NSNumber alloc]initWithInt:self.currentRound];
    [[NSUserDefaults standardUserDefaults] setObject:conversionNumber forKey:@"currentRound"];
}

+ (NSArray *)allRounds {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Round"];
    NSArray *arrayOfRounds = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    NSArray *sortedArray = [[RoundServer sharedInstance] sortThisArray:arrayOfRounds];
    
//    NSLog(@"%@", arrayOfRounds);
    return sortedArray;
}

-(NSArray *)sortThisArray:(NSArray *)array
{
    //possible problem = fetch takes too long.
//    NSLog(@"%@",array);
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"identifier" ascending:YES];
    NSArray *sortedArray = [array sortedArrayUsingDescriptors:@[descriptor]];
    return sortedArray;
}

//+ (NSArray *)allmessagesForRound:(Round *)round {
//    NSMutableArray *messages = [NSMutableArray new];
//    
//    for (Message *message in round.messages) {
//        [messages addObject:message];
//    }
//    NSArray *finalMessages = messages;
//    
//    return finalMessages;
//    
//}

- (BOOL)isRoundComplete:(Round *)round
{
    NSNumber *completedRoundKey;
    
    //PW: NEED logic here to define how to use completed round key.
    
    if (round.identifier == completedRoundKey) {
        
        //first safely adds the round to completedRounds array
        NSMutableArray *mutablecompletedRounds = [self.completedRounds mutableCopy];
        [mutablecompletedRounds addObject:round];
        
        self.completedRounds = mutablecompletedRounds;
        
        //then returns yes
        return  YES;
    }
    
    
    return NO;
}
//gives next round based on completed choice
- (Round *) completedRound:(Round*)round withChoice:(Choice *)choice {
   
    [[RoundHistoryController sharedInstance] addChoicesMade:choice withRound:choice.destinationRound];
    
    return [[RoundLoader sharedInstance] roundFromRoundIdentifier:[choice.identifier integerValue]];
    
}

@end
