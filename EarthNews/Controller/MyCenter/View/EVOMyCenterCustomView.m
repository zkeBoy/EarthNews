//
//  EVOMyCenterCustomView.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOMyCenterCustomView.h"

@implementation EVOMyCenterCustomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIConfig];
    }
    return self;
}

- (void)setUIConfig {
    self.numberLabel = [UILabel new];
    self.numberLabel.textColor = UIColor.whiteColor;
    self.numberLabel.textAlignment = NSTextAlignmentCenter;
    self.numberLabel.font = BFont(17);
    
    self.textTitleLabel = [UILabel new];
    self.textTitleLabel.textColor = UIColor.whiteColor;
    self.textTitleLabel.textAlignment = NSTextAlignmentCenter;
    self.textTitleLabel.font = BFont(17);
    
    [self addSubview:self.numberLabel];
    [self addSubview:self.textTitleLabel];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.top.equalTo(self);
        make.height.mas_equalTo(24);
    }];
    
    [self.textTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.bottom.equalTo(self);
        make.height.mas_equalTo(20);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
