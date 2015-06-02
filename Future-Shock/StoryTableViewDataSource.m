//
//  StoryTableViewController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

/*
                                                :::
                                            :: :::.
                      \/,                    .:::::
          \),          \`-._                 :::888
          /\            \   `-.             ::88888
         /  \            | .(                ::88
        /,.  \           ; ( `              .:8888
           ), \         / ;``               :::888
          /_   \     __/_(_                  :88
            `. ,`..-'      `-._    \  /      :8
              )__ `.           `._ .\/.
             /   `. `             `-._______m         _,
            ,-=====-.-;'                 ,  ___________/ _,-_,'"`/__,-.
 C   =--   ;                   `.`._    V V V       -=-'"#==-._
 :,  \     ,|      UuUu _,......__   `-.__A_A_ -. ._ ,--._ ",`` `-
 ||  |`---' :    uUuUu,'          `'--...____/   `" `".   `
 |`  :       \   UuUu:
 :  /         \   UuUu`-._
 \(_          `._  uUuUu `-.
 (_3             `._  uUu   `._
                   ``-._      `.
                        `-._    `.
                            `.    \
                              )   ;
                             /   /
              `.        |\ ,'   /
                ",_A_/\-| `   ,'
                  `--..,_|_,-'\
                         |     \
                         |      \__
 Trogdor the Burninator  |__
 */
#import "StoryTableViewDataSource.h"
#import "RoundHistoryController.h"
#import "MessageCell.h"
#import "Round.h"
#import "Choice.h"
@import UIKit;

static NSString * const messageCellID = @"messageCellID";
static NSString * const choiceCellID = @"choiceCellID";

@interface StoryTableViewDataSource () <ChoiceButtonTableViewCellDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation StoryTableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [RoundHistoryController sharedInstance].choiceHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *choiceHistoryArray = [RoundHistoryController sharedInstance].choiceHistory;
    UITableViewCell *cell;
    ChoiceHistory *currentHistory =(ChoiceHistory *)choiceHistoryArray[indexPath.section];
    Round *currentRound = currentHistory.round;
    if ([currentRound messages].count > indexPath.row) {
        Message *message = [currentRound messages][indexPath.row];
        cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
        UIImageView *borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlackBorder.png"]];
        ((MessageCell *)cell).messageTextBorder = borderImageView;
        ((MessageCell *)cell).messageLabel.text = message.text;
//        NSLog(@"Created Message");
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:choiceCellID];
        [((ChoiceCell *)cell).leftChoiceButton setTitle:[[currentRound choices][0] text] forState:UIControlStateNormal];
        [((ChoiceCell *)cell).rightChoiceButton setTitle:[[currentRound choices][1] text] forState:UIControlStateNormal];
        ((ChoiceCell *)cell).delegate = self;
//        NSLog(@"Created Choice");

    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ChoiceHistory *history = [[RoundHistoryController sharedInstance].choiceHistory objectAtIndex:section];
    return history.round.messages.count + 1;
}


//- (void)registerTableView:(UITableView *)tableView {
//    self.tableView = tableView;
//}

- (Round *)roundFromChoiceIdentifier:(NSInteger)choiceID {
    Round *destinationRound = ((Choice *)[self.round.choices objectAtIndex:choiceID]).destinationRound;
    return destinationRound;
}

-(void)leftButtonTapped:(ChoiceCell *)cell {
    
    [cell.leftChoiceButton setEnabled:NO];
    [cell.leftChoiceButton setHighlighted:YES];
    [cell.rightChoiceButton setEnabled:NO];
    NSLog(@"Adding round from left button...");
    
    Round *currentRound = ((ChoiceHistory *)([[RoundHistoryController sharedInstance].choiceHistory lastObject])).round;
    [self addToTableViewStartingAtSection:[RoundHistoryController sharedInstance].choiceHistory.count withRound:currentRound];
    [[RoundServer sharedInstance] completedRound:currentRound withChoice:currentRound.choices[0]];
    
}

-(void)rightButtonTapped:(ChoiceCell *)cell {
    [cell.rightChoiceButton setEnabled:NO];
    [cell.rightChoiceButton setHighlighted:YES];
    [cell.leftChoiceButton setEnabled:NO];
    NSLog(@"Adding round from right button...");
    Round *currentRound = [[RoundHistoryController sharedInstance].choiceHistory lastObject];
    
    [[RoundServer sharedInstance] completedRound:currentRound withChoice:currentRound.choices[1]];
}

- (void)addToTableViewStartingAtSection:(NSInteger)section withRound:(Round *)round {
    NSMutableArray *arrayOfIndexPaths = [[NSMutableArray alloc] init];
    for (int messageCount = 0; messageCount <= round.messages.count; messageCount++) {
        NSLog(@"looping");
        NSIndexPath *pathForCell = [NSIndexPath indexPathForRow:messageCount inSection:section];
        [arrayOfIndexPaths addObject:pathForCell];
    }
    [self.tableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView reloadData];
    NSLog(@"Round added.");
    
//    }
//    [self.tableView insertRowsAtIndexPaths: withRowAnimation:UITableViewAnimation];
        
        
//}
}

@end
