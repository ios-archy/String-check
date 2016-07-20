//
//  NewTextfIed.m
//  字符串校验。。。。
//
//  Created by archy on 16/7/20.
//  Copyright © 2016年 archy. All rights reserved.
//

#import "NewTextfIed.h"

@implementation NewTextfIed

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController) {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}



@end
