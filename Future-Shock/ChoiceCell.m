//
//  ChoiceCell.m
//  Future-Shock
//
//  Created by Michael Sacks on 5/27/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "ChoiceCell.h"

static NSString * const choiceCellID = @"choiceCellID";

@interface ChoiceCell ()

@end

@implementation ChoiceCell

- (IBAction)buttonTapped:(UIButton *)sender {
    [self.delegate buttonTappedWithIndex:self.tag andSender:self];
}

- (void)updateWithRound:(Round *)round {
    
    Choice *firstChoice = round.choices[0];
    Choice *secondChoice = round.choices[1];
    
    [self.leftChoiceButton setTitle:firstChoice.text forState:UIControlStateNormal];
    [self.rightChoiceButton setTitle:secondChoice.text forState:UIControlStateNormal];
}

- (void)awakeFromNib {
    // Initialization code
    
    [self.leftChoiceButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.rightChoiceButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
