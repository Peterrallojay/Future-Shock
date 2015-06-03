//
//  ViewController.m
//  Future-Shock
//
//  Created by Peter Woodrow on 5/18/15.
//  Copyright (c) 2015 Peter Woodrow. All rights reserved.
//

#import "StoryViewController.h"
#import "RoundLoader.h"
#import "SettingsViewController.h"
#import "StoryTableViewDataSource.h"

@interface StoryViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) StoryTableViewDataSource *dataSource;

@end

@implementation StoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [RoundLoader sharedInstance];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FSBackgroundAlpha1.png"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.navigationController.navigationBar.translucent = YES;

    self.tableView.backgroundView = tempImageView;
    self.dataSource = [StoryTableViewDataSource new];
    self.dataSource.tableView = self.tableView;
    self.tableView.dataSource = self.dataSource;
//    self.tableView.layoutMargins = UIEdgeInsetsZero;
    
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [self fireNotification];
}


- (void)fireNotification{
    UILocalNotification *notification = [UILocalNotification new];
    if (notification) {
        notification.fireDate = [[NSDate new] dateByAddingTimeInterval:1];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.repeatInterval = 0;
        notification.soundName = UILocalNotificationDefaultSoundName;
        notification.applicationIconBadgeNumber = 1;
        notification.alertBody = @"Ben is waiting for you";
        
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
    }    
    
}
- (IBAction)settingButtonClicked:(id)sender {
    SettingsViewController *settingsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"settings"];
    [self addChildViewController:settingsViewController];
    [self.view addSubview:settingsViewController.view];
    [settingsViewController didMoveToParentViewController:self];
    settingsViewController.view.alpha = 1.0;
    
    
}

//SettingsViewController *settingsViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"settings"];
//[self addChildViewController:settingsViewController];
//[self.view addSubview:settingsViewController.view];
//[settingsViewController didMoveToParentViewController:self];
//settingsViewController.view.alpha = 1.0;


//"based on choice, I completed a round... what's next?"
- (void)updateWithRound {
    //insert first message at bottom of cell list
    //schedule next message to display after delay
    //after all messages display, present choices
    //insert choice cell at bottom
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    //PW: not sure if this is necessary since we're not pushing/popping between master/detail views
    [self.tableView reloadData];
}


@end
