//
//  BMFirstMainView.m
//  BluetoothMusic
//
//  Created by Akifumi on 2012/09/09.
//  Copyright (c) 2012年 Akifumi. All rights reserved.
//

#import "BMFirstMainView.h"

@interface BMFirstMainView()
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation BMFirstMainView
@synthesize buttons;
@synthesize onPressedConnectButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.buttons = [NSMutableArray array];
        
        UIButton *connectButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        float w = 200;
        float h = 40;
        connectButton.frame = CGRectMake((SCREEN_SIZE.width - w)/2, (SCREEN_SIZE.height - h)/2, w, h);
        [connectButton setTitle:@"connect" forState:UIControlStateNormal];
        [connectButton addTarget:self action:@selector(pressedConnectButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:connectButton];
        
        [self.buttons addObject:connectButton];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


- (void)pressedConnectButton:(id)sender{
    if (self.onPressedConnectButton) self.onPressedConnectButton();
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

@end
