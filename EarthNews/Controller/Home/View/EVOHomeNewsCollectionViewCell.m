//
//  EVOHomeNewsCollectionViewCell.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOHomeNewsCollectionViewCell.h"

@implementation EVOHomeNewsCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        self.contentView.layer.cornerRadius = 8;
        self.contentView.clipsToBounds = YES;
        self.contentView.layer.backgroundColor = UIColor.whiteColor.CGColor;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
