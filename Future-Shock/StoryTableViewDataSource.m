//
//  StoryTableViewController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "StoryTableViewDataSource.h"
#import "MessageCell.h"
#import "Round.h"

static NSString * const messageCellID = @"messageCellID";

@implementation StoryTableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //RoundServer *roundServer = [RoundServer new];
    
    
    //NSLog(@"%lu", (unsigned long)roundServer.completedRounds.count);
    
//    return roundServer.completedRounds.count;
    
    return [RoundServer allRounds].count;

}


//getting data from round
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Round *round = [RoundController sharedInstance].messages[indexPath.row];
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
    
    if(!cell){
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:messageCellID];
    }
    
    Round *roundForCell = [RoundServer allRounds][indexPath.section];
    
    if ([roundForCell messages].count > indexPath.row) {
        Message *message = [roundForCell messages][indexPath.row];
        cell.messageLabel.text = message.text;
        
        UIImageView *borderImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BlackBorder.png"]];
        [borderImageView setFrame:cell.messageTextBorder.frame];
        
        
        //cell.textLabel.text = message.text;
    }
//    else{
//        Choice *choice = [roundForCell choices][indexPath.row - [roundForCell messages].count];
//        cell.textLabel.text = [NSString stringWithFormat:@"CHOICE: %@", choice.text];
//    }
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[(Round *)([RoundServer allRounds][section]) messages] count] + 2;
    //return [RoundServer allmessagesForRound:(Round *)];
}


- (void)registerTableView:(UITableView *)tableView {

}


@end
