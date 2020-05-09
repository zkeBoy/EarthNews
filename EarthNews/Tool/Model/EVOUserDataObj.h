//
//  EVOUserDataObj.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface EVOUserDataObj : NSObject <NSCoding>
kSPrCopy__(NSString * userName);
kSPrStrong(NSData   * userHeadImg);
kSPrCopy__(NSString * userSex);
kSPrCopy__(NSString * birthDay);
kSPrCopy__(NSString * userAge);
kSPrCopy__(NSString * location);
@end

NS_ASSUME_NONNULL_END
