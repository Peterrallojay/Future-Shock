//
//  StoryTableViewController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "StoryTableViewDataSource.h"
#import "MessageCell.h"
#import "ChoiceCell.h"
#import "Round.h"

static NSString * const messageCellID = @"messageCellID";
static NSString * const choiceCellID = @"choiceCellID";

@interface StoryTableViewDataSource ()

@end

@implementation StoryTableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [RoundServer allRounds].count;
}


//getting data from round
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    Round *roundForCell = [RoundServer allRounds][indexPath.section];
    
    if ([roundForCell messages].count > indexPath.row)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
        Message *message = [roundForCell messages][indexPath.row];
        cell.textLabel.text = message.text;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:choiceCellID];
        [((ChoiceCell *)cell).leftChoiceButton setTitle:[[roundForCell choices][0] text] forState:UIControlStateNormal];
        [((ChoiceCell *)cell).rightChoiceButton setTitle:[[roundForCell choices][1] text] forState:UIControlStateNormal];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[(Round *)([RoundServer allRounds][section]) messages] count] + 1;
    //return [RoundServer allmessagesForRound:(Round *)];
}

- (void)registerTableView:(UITableView *)tableView {

}


@end
