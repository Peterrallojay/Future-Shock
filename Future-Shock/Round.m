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


@implementation Round

@dynamic identifier;
@dynamic roundToChoices;
@dynamic roundToMessages;
@dynamic messages;
@dynamic message;
@dynamic choices;

- (instancetype)initWithJSONDictionary:(NSDictionary *)dictionary {
    self = [super init];
    [self loadJSONDictionary:dictionary];
    return self;
}

- (void)loadJSONDictionary:(NSDictionary *)dictionary {
    if(self) {
        
        self.identifier = dictionary[@"roundIdentifierKey"];
        self.messages = dictionary[@"messages"];
        self.message.text = dictionary[@"messageText"];
        self.message.distanceDelay = dictionary[@"messageDistanceDelay"];
        self.message.timeDelay = dictionary[@"messageTimeDelay"];
        self.choices.identifier = dictionary[@"choices"];
        self.choices.destination = dictionary[@"choicesDestination"];
        self.choices.identifier = dictionary[@"choicesIdentifier"];
        self.choices.text = dictionary[@"choicesTextKey"];
    }
}

@end
