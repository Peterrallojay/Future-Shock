//
//  ChoiceCell.h
//  Future-Shock
//
//  Created by Michael Sacks on 5/27/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundLoader.h"
#import "Round.h"
#import "Message.h"
#import "Choice.h"


@protocol ChoiceButtonTableViewCellDelegate;

@interface ChoiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *rightChoiceButton;
@property (weak, nonatomic) IBOutlet UIButton *leftChoiceButton;
@property (weak, nonatomic) id<ChoiceButtonTableViewCellDelegate> delegate;
@property (assign, nonatomic) NSInteger choiceIdentifier;

- (void)updateWithRound:(Round *)round;

@end

@protocol ChoiceButtonTableViewCellDelegate <NSObject>
@required
- (void)buttonTappedWithIndex:(NSInteger)index andSender:(ChoiceCell *)cell;
@end