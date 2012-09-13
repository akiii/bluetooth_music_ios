//
//  BMBluetoothUser.h
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/14.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _BMSessionState {
    BMSessionStateUnconnect,
    BMSessionStateConnecting,
    BMSessionStateConnected
} BMSessionState;

@interface BMBluetoothUser : NSObject
@property (nonatomic, strong) NSString *displayName;
@property (nonatomic, strong) NSString *peerID;
@property (assign) BMSessionState state;
@end
