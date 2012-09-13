//
//  BMRequestedConnectionAlertView.h
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/14.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMRequestedConnectionAlertView : NSObject
@property (nonatomic, strong) void (^onPressedYES)();
@property (nonatomic, strong) void (^onPressedNO)();
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message onPressedYES:(void(^)())yesBlock onPressedNO:(void(^)())noBlock;
@end
