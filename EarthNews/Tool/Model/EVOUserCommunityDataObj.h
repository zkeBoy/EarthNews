//
//  EVOUserCommunityDataObj.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EVOUserCommunityDataObj : NSObject <NSCoding>
kSPrCopy__(NSString * ID);
kSPrCopy__(NSString * Name);
kSPrCopy__(NSString * Gender);
kSPrCopy__(NSString * Age);
kSPrCopy__(NSString * Nation);
kSPrCopy__(NSString * Image);
kSPrCopy__(NSString * Intrduce);
kSPrCopy__(NSString * Image_1);
kSPrCopy__(NSString * review); //评论内容
kSPrCopy__(NSString * reviewImage); //评论头像
kSPrAssign(double longitude); //纬度
kSPrAssign(double latitude);  //精度

kSPrCopy__(NSString * isSelf); //新加 是否是自己的动态
kSPrStrong(NSData * userHeadImg); //新加
kSPrStrong(NSArray <NSData *>*imgArray); //新加 用户的动态图片
kSPrStrong(NSArray <NSDate *>*normalImgArray); //新加 动态原图
@end

NS_ASSUME_NONNULL_END
