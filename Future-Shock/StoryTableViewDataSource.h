//
//  StoryTableViewController.h
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoundLoader.h"
#import "MessageCell.h"
#import "Round.h"
#import "Message.h"

@import UIKit;

@interface StoryTableViewDataSource : NSObject <UITableViewDataSource>
@property NSInteger totalNumberOfCells;

@property (strong, nonatomic) Round *round;

@end
