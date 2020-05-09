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

kSPrStrong(NSData * userHeadImg); //新加
kSPrStrong(NSArray <NSData *>*imgArray); //新加 用户的动态图片
@end

NS_ASSUME_NONNULL_END
