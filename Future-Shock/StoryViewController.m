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

@end
