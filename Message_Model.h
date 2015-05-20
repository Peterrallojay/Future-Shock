//
//  Message_Model.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSManagedObject;

@interface Message_Model : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSManagedObject *messageToRound;

@end
