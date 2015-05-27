//
//  StoryTableViewController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "StoryTableViewDataSource.h"
#import "MessageCell.h"

static NSString * const messageCellID = @"messageCellID";

@implementation StoryTableViewDataSource
//getting data from round
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Round *round = [RoundController sharedInstance].messages[indexPath.row];
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:messageCellID];
    
    
    //this instantiates new cells by checking that they are uitableviewcells. These cells will contain Round objects.
    if (!cell) {
        NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"MessageCellView" owner:self options:nil];
        for (id currentCellObject in cellObjects) {
            if([currentCellObject isKindOfClass:[UITableViewCell class]]){
                cell = (MessageCell *)currentCellObject;
                break;
            }
        }
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:messageCellID];
    }
    
    //configure the cell (Round -> Messages ->Choices)
    
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (void)registerTableView:(UITableView *)tableView {

}
@end
