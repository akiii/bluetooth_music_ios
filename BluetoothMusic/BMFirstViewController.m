//
//  ViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/09.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMFirstViewController.h"
#import "BMFirstMainView.h"

@interface BMFirstViewController ()
@property (nonatomic, strong) BMFirstMainView *mainView;
@end

@implementation BMFirstViewController
@synthesize mainView;

- (void)viewDidLoad
{
    [super viewDidLoad];
        
	// Do any additional setup after loading the view, typically from a nib.
    self.mainView = [[BMFirstMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
    [self.view addSubview:self.mainView];
    
    self.mainView.onPressedConnectButton = ^(){
        [self.mainView notActivateButtons];
        
        GKPeerPickerController *picker = [[GKPeerPickerController alloc] init];
        picker.delegate = self;
        picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
        [picker show];
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

}

- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker{
    [self.mainView activateButtons];
}

@end
