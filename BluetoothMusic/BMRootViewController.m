//
//  BMRootViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/14.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMRootViewController.h"
#import "BMConnectionViewController.h"
#import "BMSecondViewController.h"

@interface BMRootViewController ()
@property (nonatomic, strong) BMConnectionViewController *connectionViewController;
@property (nonatomic, strong) BMSecondViewController *musicViewController;
@end

@implementation BMRootViewController
@synthesize connectionViewController;
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
    self.connectionViewController = [[BMConnectionViewController alloc] initWithNibName:nil bundle:nil];
    self.musicViewController = [[BMSecondViewController alloc] initWithNibName:nil bundle:nil];
    
    [self setViewControllers:[NSArray arrayWithObjects:self.connectionViewController, self.musicViewController, nil] animated:YES];
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
    self.connectionViewController = nil;
    self.musicViewController = nil;
}

@end
