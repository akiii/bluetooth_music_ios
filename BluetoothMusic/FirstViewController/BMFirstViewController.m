//
//  ViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/09.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMFirstViewController.h"
#import "BMFirstMainView.h"
#import "BMSecondViewController.h"

@interface BMFirstViewController ()
@property (nonatomic, strong) BMFirstMainView *mainView;
@property (nonatomic, strong) GKPeerPickerController *pickerController;
@end

@implementation BMFirstViewController
@synthesize pickerController;
@synthesize mainView;

- (void)viewDidLoad
{
    [super viewDidLoad];
        
	// Do any additional setup after loading the view, typically from a nib.
    self.mainView = [[BMFirstMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    [self.view addSubview:self.mainView];
    
    self.mainView.onPressedConnectButton = ^(){
        [self.mainView notActivateButtons];
        
        self.pickerController = [[GKPeerPickerController alloc] init];
        self.pickerController.delegate = self;
        self.pickerController.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
        [self.pickerController show];
    };
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    [self.pickerController dismiss];
    self.pickerController.delegate = nil;
    self.pickerController = nil;
    
    BMSecondViewController *secondViewController = [[BMSecondViewController alloc] initWithNibName:nil bundle:nil];
    [secondViewController setSession:session peerID:peerID];
    [self presentModalViewController:secondViewController animated:YES];
}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker{
    self.pickerController.delegate = nil;
    self.pickerController = nil;
    [self.mainView activateButtons];
}

- (void)dealloc{
    self.mainView = nil;
    self.pickerController = nil;
}

@end
