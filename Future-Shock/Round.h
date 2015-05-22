//
//  Round.h
//  Future-Shock
//
//  Created by Michael Sacks on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Choice, Message;

@interface Round : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSOrderedSet *roundToChoices;
@property (nonatomic, retain) NSOrderedSet *roundToMessages;

@property (nonatomic, strong) NSArray *choices;
@property (nonatomic, strong) NSArray *messages;

@end

@interface Round (CoreDataGeneratedAccessors)

- (void)insertObject:(Choice *)value inRoundToChoicesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRoundToChoicesAtIndex:(NSUInteger)idx;
- (void)insertRoundToChoices:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRoundToChoicesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRoundToChoicesAtIndex:(NSUInteger)idx withObject:(Choice *)value;
- (void)replaceRoundToChoicesAtIndexes:(NSIndexSet *)indexes withRoundToChoices:(NSArray *)values;
- (void)addRoundToChoicesObject:(Choice *)value;
- (void)removeRoundToChoicesObject:(Choice *)value;
- (void)addRoundToChoices:(NSOrderedSet *)values;
- (void)removeRoundToChoices:(NSOrderedSet *)values;
- (void)insertObject:(Message *)value inRoundToMessagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRoundToMessagesAtIndex:(NSUInteger)idx;
- (void)insertRoundToMessages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRoundToMessagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRoundToMessagesAtIndex:(NSUInteger)idx withObject:(Message *)value;
- (void)replaceRoundToMessagesAtIndexes:(NSIndexSet *)indexes withRoundToMessages:(NSArray *)values;
- (void)addRoundToMessagesObject:(Message *)value;
- (void)removeRoundToMessagesObject:(Message *)value;
- (void)addRoundToMessages:(NSOrderedSet *)values;
- (void)removeRoundToMessages:(NSOrderedSet *)values;

- (instancetype)initWithJSONRoundDictionary:(NSDictionary *)dictionary;

@end
