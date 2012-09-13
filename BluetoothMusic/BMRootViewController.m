//
//  BMRootViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/14.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMRootViewController.h"
#import "BMFirstViewController.h"
#import "BMSecondViewController.h"

@interface BMRootViewController ()
@property (nonatomic, strong) BMFirstViewController *settingViewController;
@property (nonatomic, strong) BMSecondViewController *musicViewController;
@end

@implementation BMRootViewController
@synthesize settingViewController;
@synthesize musicViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.settingViewController = [[BMFirstViewController alloc] initWithNibName:nil bundle:nil];
    self.musicViewController = [[BMSecondViewController alloc] initWithNibName:nil bundle:nil];
    
    [self setViewControllers:[NSArray arrayWithObjects:self.settingViewController, self.musicViewController, nil] animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc{
    self.settingViewController = nil;
    self.musicViewController = nil;
}

@end