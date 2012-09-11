//
//  BMFirstMainView.h
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/09.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMFirstMainView : UIView {
    
}
@property (nonatomic, copy) void (^onPressedConnectButton)();
- (void)activateButtons;
- (void)notActivateButtons;
@end
