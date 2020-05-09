//
//  EVOMyCenterPhotoCollectionView.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MyCollectionType) {
    MyCollectionTypeGuiJi = 0, //我的轨迹
    MyCollectionTypeDianZ = 1  //我的点赞
};

NS_ASSUME_NONNULL_BEGIN

@interface EVOMyCenterPhotoCollectionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, assign) MyCollectionType cType;
@property (nonatomic, strong) NSMutableArray * dataSourceArray;
@end

NS_ASSUME_NONNULL_END
