//
//  MessageCellView.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/18/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "MessageCell.h"

static NSString * const messageCellID = @"messageCellID";

@interface MessageCell ()

@end

@implementation MessageCell

- (void)updateWithMessage:(Message *)message {
    self.messageLabel.text = message.text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
