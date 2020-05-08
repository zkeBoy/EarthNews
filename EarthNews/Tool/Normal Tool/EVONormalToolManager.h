//
//  EVONormalToolManager.h
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <sys/utsname.h>
#import <AVFoundation/AVFoundation.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <Foundation/Foundation.h>

typedef void(^clickClipBlock)(UIImage *_Nullable); //从相册选择相片
typedef void(^takePhotoBlock)(UIImage *_Nullable); //拍照

NS_ASSUME_NONNULL_BEGIN

@interface EVONormalToolManager : NSObject <UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIImagePickerController * pickerVC;
@property (nonatomic,   copy) clickClipBlock            clickPhotoAlubmBlock;

+ (EVONormalToolManager *)shareManager;

- (float)cacheSize;
- (void)cleanCache:(void(^)(void))completeBlock;
- (void)cleanCacheShowAlert:(NSString *)title
                    message:(NSString *)message
          completionHandler:(void(^)(void))completionHandler;

- (void)clipPhotoalbumImage:(void(^)(UIImage *image))completeClipBlock; //从相册选取照片
- (void)takePhotoAlbumImage:(void(^)(UIImage *image))completeClipBlock; //拍照获取照片
- (UIViewController *)currentViewController;
- (BOOL)isEmptyWithString:(NSString *)str; //判断是否为空字符串

- (void)showAlertViewWithTitle:(NSString * _Nullable)title
                       message:(NSString * _Nullable)message
                         other:(NSString * _Nullable)other
                        cancel:(NSString * _Nullable)cancel
                    otherBlock:(void(^)(void))otherBlock
                   cancelBlock:(void(^)(void))cancelBlock;

- (void)showSectionTitles:(NSArray <NSDictionary *>*)titles
                  message:(NSString * _Nullable)message
            selectHandler:(void(^)(NSInteger selectIndex))selectHandler
         clickCancelBlock:(void(^)(void))clickCancelBlock;
@end

NS_ASSUME_NONNULL_END
