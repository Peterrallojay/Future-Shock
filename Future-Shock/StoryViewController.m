//
//  ViewController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/18/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "StoryViewController.h"
#import "RoundController.h"

@interface StoryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [RoundController sharedInstance];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    //PW: not sure if this is necessary since we're not pushing/popping between master/detail views
    [self.tableView reloadData];
}


@end
