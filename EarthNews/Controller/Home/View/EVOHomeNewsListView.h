//
//  EVOHomeNewsListView.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EVOCommunityDataManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface EVOHomeNewsListView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic,   copy) void (^clickSelectNewsItemBlock)(void);
@property (nonatomic, strong) EVOCommunityDataManager * dataManager;
@end

NS_ASSUME_NONNULL_END
