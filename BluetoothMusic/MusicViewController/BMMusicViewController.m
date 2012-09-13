//
//  BMMusicViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/14.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMMusicViewController.h"

@interface BMMusicViewController ()

@end

@implementation BMMusicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIImage *tabBarItemImage = [UIImage imageNamed:@"music.png"];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"music" image:tabBarItemImage tag:0];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    MPMediaPickerController *mediaPickerController = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPickerController.view.frame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - TOOL_BAR_SIZE.height);
    mediaPickerController.delegate = self;
    [self.view addSubview:mediaPickerController.view];    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
