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
    if (sender == self.leftChoiceButton) {
        [self.delegate leftButtonTapped:self];
    }
    else if (sender == self.rightChoiceButton){
        [self.delegate rightButtonTapped:self];
    }
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
