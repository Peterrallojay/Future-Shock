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
    return [RoundServer sharedInstance].currentRound + 1;
}


//getting data from round
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [RoundServer allRounds];
    UITableViewCell *cell;
    Round *roundForCell =[RoundServer allRounds] [[RoundServer sharedInstance].currentRound ];
    
    if ([roundForCell messages].count > indexPath.row) {
        cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
        Message *message = [roundForCell messages][indexPath.row];
        UIImageView *borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlackBorder.png"]];
        ((MessageCell *)cell).messageTextBorder = borderImageView;
        ((MessageCell *)cell).messageLabel.text = message.text;
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:choiceCellID];
        [((ChoiceCell *)cell).leftChoiceButton setTitle:[[roundForCell choices][0] text] forState:UIControlStateNormal];
        [((ChoiceCell *)cell).rightChoiceButton setTitle:[[roundForCell choices][1] text] forState:UIControlStateNormal];
        ((ChoiceCell *)cell).delegate = self;
    }
    
    //integrate roundstraversed array
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[(Round *)[RoundServer allRounds][section] messages] count] + 1;
    //return [RoundServer allmessagesForRound:(Round *)];
}


- (void)registerTableView:(UITableView *)tableView {
    self.tableView = tableView;
}

- (Round *)roundFromChoiceIdentifier:(NSInteger)choiceID {
    Round *destinationRound = ((Choice *)[self.round.choices objectAtIndex:choiceID]).destinationRound;
    return destinationRound;
}

-(void)leftButtonTapped:(ChoiceCell *)cell {
    [self addRoundToStoryTableView:[self roundFromChoiceIdentifier:cell.choiceIdentifier]];
}

-(void)rightButtonTapped:(ChoiceCell *)cell {
    [self addRoundToStoryTableView:[self roundFromChoiceIdentifier:cell.choiceIdentifier]];
}

- (void)addRoundToStoryTableView:(Round *)round {
    for (Message *currentMessage in self.round.messages) {
//        [self.tableView insertRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:UITableViewAnimation];
//    }
//    [self.tableView insertRowsAtIndexPaths:<#(NSArray *)#> withRowAnimation:UITableViewAnimation];
        
        
}
}

@end
