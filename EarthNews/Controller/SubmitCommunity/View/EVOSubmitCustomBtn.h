//
//  EVOSubmitCustomBtn.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EVOSubmitCustomBtn : UIView
kSPrStrong(UIButton * deleteBtn);
kSPrStrong(UIButton * contentImgBtn);
kSPrAssign(NSInteger  selectTag);
kSPrAssign(BOOL enable);
kSPrCopy__(void(^clickRemoveImgBlock)(NSInteger tag));
kSPrCopy__(void(^clickSelectImgBlock)(void));
@end

NS_ASSUME_NONNULL_END
