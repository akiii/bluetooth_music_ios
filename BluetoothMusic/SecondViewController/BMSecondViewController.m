//
//  BMSecondViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/09.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMSecondViewController.h"
#import "BMSecondMainView.h"

@interface BMSecondViewController ()
@property (nonatomic, strong) NSString *peerID;
@property (nonatomic, strong) GKSession *session;
@property (nonatomic, strong) BMSecondMainView *mainView;
@property (nonatomic, strong) MPMusicPlayerController *pc;
@end

@implementation BMSecondViewController
@synthesize peerID;
@synthesize session;
@synthesize mainView;
@synthesize pc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.mainView = [[BMSecondMainView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, SCREEN_SIZE.height)];
        [self.view addSubview:self.mainView];
        
        __block id target = self;
        __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:target selector:@selector(timer:) userInfo:nil repeats:YES];
        [timer invalidate];
        
        self.mainView.onPressedSendButton = ^(){
            if ([timer isValid]) {
                [timer invalidate];
            }else {
                timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:target selector:@selector(timer:) userInfo:nil repeats:YES];
                [timer fire];
            }
        };
        
        self.pc = [[MPMusicPlayerController alloc] init];
        MPMediaItem *playingItem = [self.pc nowPlayingItem];
        NSLog(@"playing item : %@", playingItem);
        
//        [self.pc play];
        
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

- (void)setSession:(GKSession *)s peerID:(NSString *)p{
    self.session = s;
    self.peerID = p;
    self.session.delegate = self;
    [self.session setDataReceiveHandler:self withContext:(__bridge void *)(self.peerID)];
}

- (void)timer:(id)sender{
//    NSLog(@"play time : %f", self.pc.currentPlaybackTime);
    
//    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[NSNumber numberWithFloat:self.pc.currentPlaybackTime]];
//    [self.session sendData:data toPeers:[NSArray arrayWithObject:self.peerID] withDataMode:GKSendDataReliable error:nil];
    
//    [self.session setDataReceiveHandler:self withContext:(__bridge void *)(self.peerID)];

    NSError *error = nil;
    NSLog(@"send ? %d", [self.session sendData:[@"sending string" dataUsingEncoding:NSUTF8StringEncoding] toPeers:[NSArray arrayWithObject:self.peerID] withDataMode:GKSendDataReliable error:&error]);
    
    if (error) {
        NSLog(@"error : %@", error);
    }
}

- (void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context{
    NSLog(@"data : %@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
}

- (void)dealloc{
    self.mainView = nil;
    self.pc = nil;
    self.peerID = nil;
    self.session = nil;
}

@end
