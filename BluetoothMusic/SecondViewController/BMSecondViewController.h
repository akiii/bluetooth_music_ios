//
//  BMSecondViewController.h
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/09.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface BMSecondViewController : UIViewController <GKSessionDelegate>
@property (nonatomic, strong) NSString *peerID;
@property (nonatomic, strong) GKSession *session;
@end
