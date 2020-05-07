//
//  EVOHomeNewsCollectionViewCell.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EVOHomeNewsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *bgContentView;
@property (weak, nonatomic) IBOutlet UILabel *newsAddressTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsTimeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *newsContentTextLabel;
@end

NS_ASSUME_NONNULL_END
