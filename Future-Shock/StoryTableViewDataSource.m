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
    return [RoundHistoryController sharedInstance].roundsUserTraversed.count +1;
}


//getting data from round
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *roundsInTable = [RoundHistoryController sharedInstance].roundsUserTraversed;
    UITableViewCell *cell;
    Round *roundForSection =(Round *)roundsInTable[indexPath.section];
    cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
    Message *message = [roundForSection messages][indexPath.row];
    UIImageView *borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlackBorder.png"]];
    ((MessageCell *)cell).messageTextBorder = borderImageView;
    ((MessageCell *)cell).messageLabel.text = message.text;
//    }
//    if ([roundForSection messages].count > indexPath.row) {
//        cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
//        Message *message = [roundForSection messages][indexPath.row];
//        UIImageView *borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlackBorder.png"]];
//        ((MessageCell *)cell).messageTextBorder = borderImageView;
//        ((MessageCell *)cell).messageLabel.text = message.text;
//    }
//    else {
//        cell = [tableView dequeueReusableCellWithIdentifier:choiceCellID];
//        [((ChoiceCell *)cell).leftChoiceButton setTitle:[[roundForSection choices][0] text] forState:UIControlStateNormal];
//        [((ChoiceCell *)cell).rightChoiceButton setTitle:[[roundForSection choices][1] text] forState:UIControlStateNormal];
//        ((ChoiceCell *)cell).delegate = self;
//    }
    
    //integrate roundstraversed array
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Loading row from section %ld. Current round history:%@",(long)section,[RoundHistoryController sharedInstance].roundsUserTraversed);
    return ((Round *)[RoundHistoryController sharedInstance].roundsUserTraversed[section]).messages.count;
//    return [[(Round *)[RoundServer allRounds][section] messages] count] + 1;
    //return [RoundServer allmessagesForRound:(Round *)];
}


//- (void)registerTableView:(UITableView *)tableView {
//    self.tableView = tableView;
//}

- (Round *)roundFromChoiceIdentifier:(NSInteger)choiceID {
    Round *destinationRound = ((Choice *)[self.round.choices objectAtIndex:choiceID]).destinationRound;
    return destinationRound;
}

-(void)leftButtonTapped:(ChoiceCell *)cell { //DD: Gets currentRound from RoundServer to determine it's choices and sends the destination to addRoundToStoryTableView for loading.
    [cell.leftChoiceButton setEnabled:NO];
    [cell.leftChoiceButton setHighlighted:YES];
    [cell.rightChoiceButton setEnabled:NO];
    NSLog(@"Adding round from left button...");
    NSLog(@"Destination Round Identifier: %@",((Choice *)((Round *)([RoundServer allRounds] [[RoundServer sharedInstance].currentRound])).choices[0]).destinationRound);
    [self addToTableViewStartingAtSection:0 withRound:((Choice *)((Round *)([RoundServer allRounds] [[RoundServer sharedInstance].currentRound])).choices[0]).destinationRound];
    
}

-(void)rightButtonTapped:(ChoiceCell *)cell { //DD: Gets currentRound from RoundServer to determine it's choices and sends the destination to addRoundToStoryTableView for loading.
    [cell.rightChoiceButton setEnabled:NO];
    [cell.rightChoiceButton setHighlighted:YES];
    [cell.leftChoiceButton setEnabled:NO];
    NSLog(@"Adding round from right button...");
    NSLog(@"Destination Round Identifier: %@",((Choice *)((Round *)([RoundServer allRounds] [[RoundServer sharedInstance].currentRound])).choices[1]).destinationRound.choices);
    [self addToTableViewStartingAtSection:2 withRound:((Choice *)((Round *)([RoundServer allRounds] [[RoundServer sharedInstance].currentRound])).choices[1]).destinationRound];
}

- (void)addToTableViewStartingAtSection:(NSInteger)section withRound:(Round *)round {
    NSMutableArray *arrayOfIndexPaths = [[NSMutableArray alloc] init];
    for (int messageCount = 0; messageCount <= round.messages.count; messageCount++) {
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
