//
//  BMSecondViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/09.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMSecondViewController.h"

@interface BMSecondViewController ()
@property (nonatomic, strong) MPMusicPlayerController *pc;
@end

@implementation BMSecondViewController
@synthesize peerID, session;
@synthesize pc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.pc = [[MPMusicPlayerController alloc] init];
        MPMediaItem *playingItem = [self.pc nowPlayingItem];
        NSLog(@"playing item : %@", playingItem);
        
        [self.pc play];
//        
//        double delayInSeconds = 2.0;
//        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//            [self.pc pause];
//        });
//        
//        double delayInSeconds_t = 5.0;
//        dispatch_time_t popTime_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds_t * NSEC_PER_SEC);
//        dispatch_after(popTime_t, dispatch_get_main_queue(), ^(void){
//            [self.pc play];
//        });
        [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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

- (void)timer:(id)sender{
//    NSLog(@"play time : %f", self.pc.currentPlaybackTime);
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[NSNumber numberWithFloat:self.pc.currentPlaybackTime]];
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context{
    
}

- (void)dealloc{
    self.pc = nil;
    self.peerID = nil;
    self.session = nil;
}

@end
