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
    MessageCellView *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[MessageCellView alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row];
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
