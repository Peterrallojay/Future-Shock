//
//  Round_Model.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Choices_Model, Message_Model;

@interface Round_Model : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSOrderedSet *roundToChoices;
@property (nonatomic, retain) NSOrderedSet *roundToMessage;
@end

@interface Round_Model (CoreDataGeneratedAccessors)

- (void)insertObject:(Choices_Model *)value inRoundToChoicesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRoundToChoicesAtIndex:(NSUInteger)idx;
- (void)insertRoundToChoices:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRoundToChoicesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRoundToChoicesAtIndex:(NSUInteger)idx withObject:(Choices_Model *)value;
- (void)replaceRoundToChoicesAtIndexes:(NSIndexSet *)indexes withRoundToChoices:(NSArray *)values;
- (void)addRoundToChoicesObject:(Choices_Model *)value;
- (void)removeRoundToChoicesObject:(Choices_Model *)value;
- (void)addRoundToChoices:(NSOrderedSet *)values;
- (void)removeRoundToChoices:(NSOrderedSet *)values;
- (void)insertObject:(Message_Model *)value inRoundToMessageAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRoundToMessageAtIndex:(NSUInteger)idx;
- (void)insertRoundToMessage:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRoundToMessageAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRoundToMessageAtIndex:(NSUInteger)idx withObject:(Message_Model *)value;
- (void)replaceRoundToMessageAtIndexes:(NSIndexSet *)indexes withRoundToMessage:(NSArray *)values;
- (void)addRoundToMessageObject:(Message_Model *)value;
- (void)removeRoundToMessageObject:(Message_Model *)value;
- (void)addRoundToMessage:(NSOrderedSet *)values;
- (void)removeRoundToMessage:(NSOrderedSet *)values;
@end
