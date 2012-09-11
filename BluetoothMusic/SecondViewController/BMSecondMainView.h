//
//  BMSecondMainView.h
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/11.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMSecondMainView : UIView {

}
@property (nonatomic, copy) void (^onPressedSendButton)();
- (void)activateButtons;
- (void)notActivateButtons;
@end
