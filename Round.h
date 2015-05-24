//
//  Round.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/23/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Choice, Message;

@interface Round : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSOrderedSet *choices;
@property (nonatomic, retain) NSOrderedSet *messages;
@property (nonatomic, retain) Choice *sourceChoice;
@end

@interface Round (CoreDataGeneratedAccessors)

- (void)insertObject:(Choice *)value inChoicesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromChoicesAtIndex:(NSUInteger)idx;
- (void)insertChoices:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeChoicesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInChoicesAtIndex:(NSUInteger)idx withObject:(Choice *)value;
- (void)replaceChoicesAtIndexes:(NSIndexSet *)indexes withChoices:(NSArray *)values;
- (void)addChoicesObject:(Choice *)value;
- (void)removeChoicesObject:(Choice *)value;
- (void)addChoices:(NSOrderedSet *)values;
- (void)removeChoices:(NSOrderedSet *)values;
- (void)insertObject:(Message *)value inMessagesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMessagesAtIndex:(NSUInteger)idx;
- (void)insertMessages:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMessagesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMessagesAtIndex:(NSUInteger)idx withObject:(Message *)value;
- (void)replaceMessagesAtIndexes:(NSIndexSet *)indexes withMessages:(NSArray *)values;
- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSOrderedSet *)values;
- (void)removeMessages:(NSOrderedSet *)values;
@end
