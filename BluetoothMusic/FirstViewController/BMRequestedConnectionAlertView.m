//
//  BMRequestedConnectionAlertView.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/14.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMRequestedConnectionAlertView.h"

@interface BMRequestedConnectionAlertView()
@end

@implementation BMRequestedConnectionAlertView

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message onPressedYES:(void(^)())yesBlock onPressedNO:(void(^)())noBlock{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"no" otherButtonTitles:@"yes", nil];
    alert.delegate = self;
    [alert show];
    
    self.onPressedYES = yesBlock;
    self.onPressedNO = noBlock;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        self.onPressedNO();
    }else if (buttonIndex == 1) {
        self.onPressedYES();
    }
}

- (void)dealloc{
    self.onPressedYES = nil;
    self.onPressedNO = nil;
}

@end
