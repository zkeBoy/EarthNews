//
//  EVOSubmitCustomBtn.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOSubmitCustomBtn.h"

@implementation EVOSubmitCustomBtn

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setUIConfig];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)coder {
    self = [super initWithFrame:coder];
    if (self) {
        [self setUIConfig];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentImgBtn.frame = self.bounds;
    self.deleteBtn.frame = CGRectMake(CGRectGetWidth(self.frame)-20, 0, 20, 20);
}

- (void)setUIConfig {
    self.contentImgBtn = [UIButton new];
    [self.contentImgBtn setBackgroundImage:CreateImage(@"take_photo") forState:UIControlStateNormal];
    [self.contentImgBtn addTarget:self action:@selector(clickSelectImageAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.contentImgBtn];
    
    self.deleteBtn = [UIButton new];
    [self.deleteBtn setImage:CreateImage(@"icon_delete") forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(clickRemoveImgAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
}

- (void)setEnable:(BOOL)enable {
    self.contentImgBtn.enabled = enable;
}

#pragma mark - Private Method
- (void)clickSelectImageAction {
    if (self.clickSelectImgBlock) {
        self.clickSelectImgBlock();
    }
}

- (void)clickRemoveImgAction {
    if (self.clickRemoveImgBlock) {
        self.clickRemoveImgBlock(self.selectTag);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
