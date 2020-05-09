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
        
    }
    return self;
}

- (void)setUIConfig {
    self.contentImgBtn = [UIButton new];
    [self.contentImgBtn setImage:CreateImage(@"icon_photo") forState:UIControlStateNormal];
    [self.contentImgBtn addTarget:self action:@selector(clickSelectImageAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.contentImgBtn];
    [self.contentImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark - Private Method
- (void)clickSelectImageAction {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
