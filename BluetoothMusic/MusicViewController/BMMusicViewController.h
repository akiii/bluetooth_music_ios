//
//  BMMusicViewController.h
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/14.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface BMMusicViewController : UIViewController <MPMediaPickerControllerDelegate>
@property (nonatomic, strong) void (^onPressedCancelButton)();
@end
