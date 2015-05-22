//
//  Round.m
//  Future-Shock
//
//  Created by Michael Sacks on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "Round.h"
#import "Choice.h"
#import "Message.h"

static NSString const *messagesKey = @"messages";
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


@implementation Round

@dynamic identifier;
@dynamic roundToChoices;
@dynamic roundToMessages;
@dynamic messages;
@dynamic choices;

- (instancetype)initWithJSONRoundDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.identifier = dictionary[roundIdentifierKey];
    [self loadMessagesFromArray:dictionary[messagesKey]];
    [self loadChoicesFromArray:dictionary[choicesKey]];
    return self;
}

- (void)loadMessagesFromArray:(NSArray *)array {
    if(self) {
        for (NSDictionary *messageDictionary in array) {
            Message *message = [[Message alloc] init];
            message.text = messageDictionary[messageTextKey];
            message.timeDelay = messageDictionary[messageTimeDelayKey];
            message.distanceDelay = messageDictionary[messageDistanceDelayKey];
            message.messgeToRound = self;
            [self addRoundToMessagesObject:message];
        }
    }
}
- (void)loadChoicesFromArray:(NSArray *)array {
    if(self) {
        for (NSDictionary *choiceDictionary in array) {
            Choice *choice = [[Choice alloc] init];
            choice.identifier = choiceDictionary[choicesIdentifierKey];
            choice.text = choiceDictionary[choicesTextKey];
            choice.destination = choiceDictionary[choicesDestinationKey];
            [self addRoundToChoicesObject:choice];
        }
    }
}

@end
