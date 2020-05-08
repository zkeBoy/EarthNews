//
//  EVOMyCenterPhotoCollectionView.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOMyCenterPhotoCollectionView.h"
#import "EVOMyCenterPhotoViewCell.h"

@implementation EVOMyCenterPhotoCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIConfig];
    }
    return self;
}

- (void)setUIConfig {
    NSInteger itemSize = (kScreenWidth-6)/3;
    
    UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake(itemSize, itemSize);
    layOut.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
    layOut.minimumLineSpacing = 3;
    layOut.minimumInteritemSpacing = 3;
    layOut.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layOut];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"EVOMyCenterPhotoViewCell" bundle:nil] forCellWithReuseIdentifier:@"EVOMyCenterPhotoViewCell"];
    [self addSubview:self.collectionView];
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EVOMyCenterPhotoViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EVOMyCenterPhotoViewCell" forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
