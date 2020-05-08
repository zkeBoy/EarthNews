//
//  EVOMyCenterPhotoCollectionView.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EVOMyCenterPhotoCollectionView : UIView <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@end

NS_ASSUME_NONNULL_END
