//
//  StoryTableViewController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/20/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "StoryTableViewDataSource.h"

static NSString * const cellID = @"cellID";

@implementation StoryTableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Round *round = [RoundController sharedInstance].messages[indexPath.row];
    
    MessageCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    //this instantiates new cells by checking that they are uitableviewcells. These cells will contain Round objects.
    if (!cell) {
        NSArray *cellObjects = [[NSBundle mainBundle] loadNibNamed:@"MessageCellView" owner:self options:nil];
        for (id currentCellObject in cellObjects) {
            if([currentCellObject isKindOfClass:[UITableViewCell class]]){
                cell = (MessageCellView *)currentCellObject;
                break;
            }
        }
        cell = [[MessageCellView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    //configure the cell (Round -> Messages ->Choices)
    
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [RoundController sharedInstance].messages.count;
}

//- (void)registerTableView:(UITableView *)tableView {
//    [tableView registerClass:[MessageCellView class] forCellReuseIdentifier:cellID];
//}
@end
