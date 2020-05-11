//
//  EVOMyCenterPhotoCollectionView.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOMyCenterPhotoCollectionView.h"
#import "EVOMyCenterPhotoViewCell.h"
#import "EVOCommunityDataManager.h"
#import "EVODynamicDetailsVC.h"

@implementation EVOMyCenterPhotoCollectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUIConfig];
        [self addNotifications];
    }
    return self;
}

- (void)addNotifications {
    //发布动态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserData) name:EVOUserSubmitCommunitySuccessKey object:nil];
    
    //点赞他人
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUserData) name:EVOUserAddGoodCommunitySuccessKey object:nil];
}

- (void)refreshUserData {
    [self.collectionView reloadData];
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
    if (self.cType==MyCollectionTypeGuiJi) {
        return [EVOCommunityDataManager shareCommunityDataManager].mySelfSourceArray.count;
    }
    return [EVOCommunityDataManager shareCommunityDataManager].othreSourceArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WeakSelf(self);
    EVOMyCenterPhotoViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EVOMyCenterPhotoViewCell" forIndexPath:indexPath];
    EVOUserCommunityDataObj * dataObj;
    if (self.cType==MyCollectionTypeGuiJi) {
        dataObj = [EVOCommunityDataManager shareCommunityDataManager].mySelfSourceArray[indexPath.row];
    }else {
        dataObj = [EVOCommunityDataManager shareCommunityDataManager].othreSourceArray[indexPath.row];
    }
    cell.collectionType = self.cType;
    cell.userDataObj = dataObj;
    cell.clickDeleteMyCommunityBlock = ^(EVOUserCommunityDataObj * _Nonnull dataObj) {
        //删除数据
        if (WeakSelf.cType==MyCollectionTypeGuiJi) {
            //我的轨迹
            [[EVOCommunityDataManager shareCommunityDataManager] removeMySelfCommunityData:dataObj];
        }else {
            //我的点赞
            [[EVOCommunityDataManager shareCommunityDataManager] removeAddGoodCommunityData:dataObj];
        }
    };
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    EVOUserCommunityDataObj * dataObj;
    if (self.cType==MyCollectionTypeGuiJi) {
        dataObj = [EVOCommunityDataManager shareCommunityDataManager].mySelfSourceArray[indexPath.row];
    }else {
        dataObj = [EVOCommunityDataManager shareCommunityDataManager].othreSourceArray[indexPath.row];
    }
    EVODynamicDetailsVC * vc  = [EVODynamicDetailsVC new];
    vc.objModel = dataObj;
    [[EVONormalToolManager shareManager].currentViewController.navigationController pushViewController:vc animated:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
