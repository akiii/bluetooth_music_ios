//
//  BMMusicViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/14.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMMusicViewController.h"

@interface BMMusicViewController ()
@property (nonatomic, strong) MPMediaPickerController *mediaPickerController;
@end

@implementation BMMusicViewController
@synthesize onPressedCancelButton;
@synthesize mediaPickerController;

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
    self.mediaPickerController = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    self.mediaPickerController.delegate = self;
    self.mediaPickerController.view.frame = CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height - TOOL_BAR_SIZE.height);
    [self.view addSubview:mediaPickerController.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{

}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker{
    if (self.onPressedCancelButton) self.onPressedCancelButton();
}

- (void)dealloc{
    self.mediaPickerController = nil;
    self.onPressedCancelButton = nil;
}

@end
