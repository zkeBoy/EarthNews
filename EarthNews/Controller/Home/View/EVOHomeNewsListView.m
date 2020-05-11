//
//  EVOHomeNewsListView.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOHomeNewsListView.h"
#import "EVOHomeNewsCollectionViewCell.h"

@implementation EVOHomeNewsListView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.dataManager = [EVOCommunityDataManager shareCommunityDataManager];
        [self setUIConfig];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataList) name:EVOShildeOtherCommunitySuccessKey object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDataList) name:EVOHomeRequestCommunitySuccessKey object:nil];
    }
    return self;
}

- (void)refreshDataList {
    [self.collectionView reloadData];
}

- (void)setUIConfig {
    UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc] init];
    layOut.itemSize = CGSizeMake(135, 172);
    layOut.sectionInset = UIEdgeInsetsMake(0, 13, 0, 13);
    layOut.minimumLineSpacing = 13;
    layOut.minimumInteritemSpacing = 0;
    layOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layOut];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"EVOHomeNewsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"EVOHomeNewsCollectionViewCell"];
    [self addSubview:self.collectionView];
    self.collectionView.frame = self.bounds;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataManager.homeSourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EVOHomeNewsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EVOHomeNewsCollectionViewCell" forIndexPath:indexPath];
    cell.dataObj = self.dataManager.homeSourceArray[indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EVOUserCommunityDataObj * dataObj = self.dataManager.homeSourceArray[indexPath.row];
    if (self.clickSelectNewsItemBlock) {
        self.clickSelectNewsItemBlock(dataObj);
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
