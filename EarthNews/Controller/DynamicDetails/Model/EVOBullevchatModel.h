//
//  EVOBullevchatModel.h
//  EarthNews
//
//  Created by mr_huang on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FDanmakuModelProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface EVOBullevchatModel : NSObject <FDanmakuModelProtocol>
@property (nonatomic,assign)NSTimeInterval beginTime;
@property (nonatomic,assign)NSTimeInterval liveTime;
@property (nonatomic,copy)NSString *content;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString * imageUrl;
@end

NS_ASSUME_NONNULL_END
