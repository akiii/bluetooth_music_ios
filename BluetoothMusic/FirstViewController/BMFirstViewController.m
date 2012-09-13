//
//  ViewController.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/09.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMFirstViewController.h"
#import "BMBluetoothUser.h"
#import "BMRequestedConnectionAlertView.h"
#import "BMSecondViewController.h"

@interface BMFirstViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) GKSession *mySession;
@property (nonatomic, strong) NSMutableArray *bluetoothUsers;
@property (nonatomic, strong) BMRequestedConnectionAlertView *alert;
@end

@implementation BMFirstViewController
@synthesize tableView;
@synthesize mySession;
@synthesize bluetoothUsers;
@synthesize alert;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        self.bluetoothUsers = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *tabBarItemImage = [UIImage imageNamed:@"setting.png"];
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"conn" image:tabBarItemImage tag:0];

    UINavigationBar *bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_SIZE.width, NAVIGATION_SIZE.height)];
    [self.view addSubview:bar];

    UINavigationItem *title = [[UINavigationItem alloc] initWithTitle:@"bluetooth music"];
    [bar setItems:[NSArray arrayWithObjects:title, nil]];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, bar.bounds.size.height, SCREEN_SIZE.width, SCREEN_SIZE.height - TOOL_BAR_SIZE.height - bar.bounds.size.height - TAB_BAR_SIZE.height) style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.mySession = [[GKSession alloc] initWithSessionID:@"BLUETOOTH_MUSIC" displayName:nil sessionMode:GKSessionModePeer];
    self.mySession.delegate = self;
    [self.mySession setDataReceiveHandler:self withContext:nil];
    
    self.mySession.available = YES;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bluetoothUsers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    BMBluetoothUser *u = [self.bluetoothUsers objectAtIndex:indexPath.row];
    NSString *text = [NSString string];
    text = [text stringByAppendingString:u.displayName];
    switch (u.state) {
        case BMSessionStateUnconnect:
            text = [text stringByAppendingString:@" un"];
            cell.userInteractionEnabled = YES;
            break;
            
        case BMSessionStateConnecting:
            text = [text stringByAppendingString:@" ing"];
            cell.userInteractionEnabled = NO;
            break;
            
        case BMSessionStateConnected:
            text = [text stringByAppendingString:@" ed"];
            cell.userInteractionEnabled = NO;
            break;
    }
    cell.textLabel.text = text;
//    cell.textLabel.text = ((BMBluetoothUser *)[self.bluetoothUsers objectAtIndex:indexPath.row]).displayName;

    return cell;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BMBluetoothUser *u = [self.bluetoothUsers objectAtIndex:indexPath.row];
    if (u.state == BMSessionStateUnconnect) {
        [self.mySession connectToPeer:u.peerID withTimeout:10];
        u.state = BMSessionStateConnecting;
        [tv deselectRowAtIndexPath:indexPath animated:YES];
        [self.tableView reloadData];
    }
}

- (BMBluetoothUser *)userFromPeerID:(NSString *)peerId{
    for (BMBluetoothUser *u in self.bluetoothUsers) {
        if ([u.peerID isEqual:peerId]) {
            return u;
        }
    }
    return nil;
}

- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
    BMBluetoothUser *u = [self userFromPeerID:peerID];
    switch (state) {
        case GKPeerStateAvailable:
            NSLog(@"発見");
            if (u == nil) {
                u = [[BMBluetoothUser alloc] init];
                u.displayName = [session displayNameForPeer:peerID];
                u.peerID = peerID;
                u.state = BMSessionStateUnconnect;
                [self.bluetoothUsers addObject:u];
            }
            break;
            
        case GKPeerStateConnected:
            NSLog(@"接続完了");
            u = [self userFromPeerID:peerID];
            u.state = BMSessionStateConnected;
            
            break;
            
        case GKPeerStateConnecting:
            NSLog(@"接続中");
            u = [self userFromPeerID:peerID];
            u.state = BMSessionStateConnecting;
            break;
            
        case GKPeerStateDisconnected:
            NSLog(@"切断");
            u = [self userFromPeerID:peerID];
            u.state = BMSessionStateUnconnect;
            break;
            
        case GKPeerStateUnavailable:
            NSLog(@"見失った");
            [self.bluetoothUsers removeObject:[self userFromPeerID:peerID]];
            break;
    }
    [self.tableView reloadData];
}

- (void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID{
    BMBluetoothUser *u = [self userFromPeerID:peerID];
    self.alert = [[BMRequestedConnectionAlertView alloc] init];
    
    [self.alert showAlertWithTitle:@"connect" message:[NSString stringWithFormat:@"%@からリクエストがあります。接続しますか？", u.displayName] onPressedYES:^{
        self.alert = nil;
        [self.mySession acceptConnectionFromPeer:peerID error:nil];
        [self.tableView reloadData];
    } onPressedNO:^{
        [self.mySession denyConnectionFromPeer:peerID];
        ((BMBluetoothUser *)[self userFromPeerID:peerID]).state = BMSessionStateUnconnect;
        [self.tableView reloadData];
        self.alert = nil;
    }];
}

- (void)dealloc{
    self.tableView = nil;
    self.mySession = nil;
    self.bluetoothUsers = nil;
    self.alert = nil;
}

@end
