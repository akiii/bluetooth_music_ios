//
//  BMRootViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/14.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMRootViewController.h"
#import "BMConnectionViewController.h"
#import "BMMusicViewController.h"
#import "BMSecondViewController.h"

@interface BMRootViewController ()
@property (nonatomic, strong) BMConnectionViewController *connectionViewController;
@property (nonatomic, strong) BMMusicViewController *musicViewController;
@property (nonatomic, strong) BMSecondViewController *secondViewController;
@end

@implementation BMRootViewController
@synthesize connectionViewController;
@synthesize musicViewController;
@synthesize secondViewController;

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
    self.musicViewController = [[BMMusicViewController alloc] initWithNibName:nil bundle:nil];
    self.secondViewController = [[BMSecondViewController alloc] initWithNibName:nil bundle:nil];
    
    self.delegate = self;
    
    [self setViewControllers:[NSArray arrayWithObjects:self.connectionViewController, self.musicViewController, self.secondViewController, nil] animated:NO];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if ([viewController isEqual:self.musicViewController]) {
        [self changeMyTabBarState];
    }
}

- (void)changeMyTabBarState{
    for (UIView *view in self.view.subviews) {
        CGRect rect = view.frame;
        if ([view isKindOfClass:[UITabBar class]]) {
            rect.origin.y = SCREEN_SIZE.height;
        }else {
            rect.size.height = SCREEN_SIZE.height;
        }
        view.frame = rect;
    }
}

- (void)dealloc{
    self.connectionViewController = nil;
    self.musicViewController = nil;
    self.secondViewController = nil;
}

@end
