//
//  BMSecondMainView.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/11.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMSecondMainView.h"


@interface BMSecondMainView()
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation BMSecondMainView
@synthesize onPressedSendButton;
@synthesize buttons;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.buttons = [NSMutableArray array];
        
        UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        float w = 200;
        float h = 40;
        sendButton.frame = CGRectMake((SCREEN_SIZE.width - w)/2, (SCREEN_SIZE.height - h)/2, w, h);
        [sendButton setTitle:@"send" forState:UIControlStateNormal];
        [sendButton addTarget:self action:@selector(pressedSendButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:sendButton];
        
        [self.buttons addObject:sendButton];
    }
    return self;
}

- (void)pressedSendButton:(id)sender{
    if (self.onPressedSendButton) self.onPressedSendButton();
}

- (void)activateButtons{
    for (UIButton *b in self.buttons) {
        b.enabled = YES;
    }
}

- (void)notActivateButtons{
    for (UIButton *b in self.buttons) {
        b.enabled = NO;
    }
}

- (void)dealloc{
    self.buttons = nil;
}

@end