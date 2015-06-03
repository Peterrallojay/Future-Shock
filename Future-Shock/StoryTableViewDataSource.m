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

@end

@implementation StoryTableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if ([RoundHistoryController sharedInstance].choiceHistory.count == 0) {
        [[RoundServer sharedInstance] completedRound:nil withChoice:nil];
    }
    
    return [RoundHistoryController sharedInstance].choiceHistory.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ChoiceHistory *choiceHistory = [RoundHistoryController sharedInstance].choiceHistory[indexPath.section];
    
    
    Round *sectionRound;
    if (!choiceHistory.choiceMade) {
        sectionRound = [[RoundLoader sharedInstance] roundFromRoundIdentifier:1];
    }
    else {
        sectionRound = choiceHistory.choiceMade.destinationRound;
    }
    
    
    if (indexPath.row < sectionRound.messages.count) {
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"messageCellID"];
        
        Message *message = sectionRound.messages[indexPath.row];
        
        [cell updateWithMessage:message];
        
        return cell;
    } else {
        ChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"choiceCellID"];
        cell.delegate = self;
        
        [cell updateWithRound:sectionRound];
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ChoiceHistory *history = [[RoundHistoryController sharedInstance].choiceHistory objectAtIndex:section];

    if (!history.round) {
        return 5;
    }
    
    return history.round.messages.count + 1;
}


//- (void)registerTableView:(UITableView *)tableView {
//    self.tableView = tableView;
//}

- (Round *)roundFromChoiceIdentifier:(NSInteger)choiceID {
    Round *destinationRound = ((Choice *)[self.round.choices objectAtIndex:choiceID]).destinationRound;
    return destinationRound;
}

- (void)buttonTappedWithIndex:(NSInteger)index andSender:(ChoiceCell *)cell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    
    Round *round;
    
    if (((ChoiceHistory *)[RoundHistoryController sharedInstance].choiceHistory[indexPath.section]).round)
    {
        round = ((ChoiceHistory *)[RoundHistoryController sharedInstance].choiceHistory[indexPath.section]).round;
    }
    else
    {
        round = [[RoundLoader sharedInstance] roundFromRoundIdentifier:1];
    }
    
    [[RoundServer sharedInstance] completedRound:round withChoice:round.choices[index]];
    
//    [self addRoundToTableView:destinationRound];
    
    [self.tableView reloadData];
}

- (void)addRoundToTableView:(Round *)round {
    
    [self.tableView reloadData];
//    
//    [self.tableView beginUpdates];
//    [self.tableView insertRowsAtIndexPaths:arrayOfIndexPaths withRowAnimation:UITableViewRowAnimationBottom];
//    [self.tableView endUpdates];
//    [self.tableView reloadData];
//    NSLog(@"TDS: Round added.");
//    
//    }
//    [self.tableView insertRowsAtIndexPaths: withRowAnimation:UITableViewAnimation];
//        
//        
//}
}

@end
