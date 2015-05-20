//
//  RoundController.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Round_Model.h"
#import "Choices_Model.h"
#import "Message_Model.h"

@interface RoundController : NSObject

@property (nonatomic, strong, readonly) NSArray *messages;

+ (RoundController *)sharedInstance;




@end
