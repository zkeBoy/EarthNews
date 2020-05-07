//
//  UIImage+Category.h
//  MaoNu
//
//  Created by zkeBoy on 2018/7/5.
//  Copyright © 2018年 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PaddingImgSize) {
    PaddingSquare = 0, //正方形图片
    PaddingShape  = 1  //长方形图片
};

@interface UIImage (Category)
- (UIImage *)compressImageToTargetWidth:(CGFloat)targetWidth;
- (UIImage *)imageCompressFitSize:(CGSize)size;
- (UIImage *)yy_imageByRoundCornerRadius:(CGFloat)radius;
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIColor *)mostColor:(UIImage*)image;
UIImage * paddingImg(PaddingImgSize size);
@end
