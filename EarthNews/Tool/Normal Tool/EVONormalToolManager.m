//
//  EVONormalToolManager.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/8.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVONormalToolManager.h"

@implementation EVONormalToolManager

+ (EVONormalToolManager *)shareManager {
    static EVONormalToolManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [EVONormalToolManager new];
    });
    return manager;
}

//缓存的大小
- (float)cacheSize {
    float tmpSize = [[SDImageCache sharedImageCache] totalDiskSize] / 1024 /1024;
    return tmpSize;
}

- (void)cleanCache:(void(^)(void))completeBlock;{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        if (completeBlock) {
            completeBlock();
        }
    }];
    /*
    NSError * error = nil;
    NSString * path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    [[NSFileManager defaultManager] removeItemAtPath:path error:&error];*/
}

- (void)cleanCacheShowAlert:(NSString *)title message:(NSString *)message completionHandler:(void(^)(void))completionHandler {
    [self showAlertViewWithTitle:title message:message other:@"确定" cancel:@"取消" otherBlock:^{
        [self cleanCache:completionHandler];
    } cancelBlock:nil];
}

- (void)clipPhotoalbumImage:(void(^)(UIImage *image))completeBlock{
    UIImagePickerController * pickerVC = [[UIImagePickerController alloc] init];
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVC.mediaTypes = @[/*(NSString *)kUTTypeMovie,*/ (NSString *)kUTTypeImage];
    pickerVC.delegate = self;
    pickerVC.allowsEditing = YES;
    self.pickerVC = pickerVC;
    self.pickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.currentViewController presentViewController:self.pickerVC animated:YES completion:nil];
    self.clickPhotoAlubmBlock = ^(UIImage * image) {
        if (completeBlock) {
            completeBlock (image);
        }
    };
}

- (void)takePhotoAlbumImage:(void(^)(UIImage *image))completeClipBlock {
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (granted) {
                //允许了
                UIImagePickerController * pickerVC = [[UIImagePickerController alloc] init];
                pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
                pickerVC.mediaTypes = @[(NSString *)kUTTypeImage];
                pickerVC.delegate = self;
                pickerVC.allowsEditing = YES;
                self.pickerVC = pickerVC;
                [self.currentViewController presentViewController:self.pickerVC animated:YES completion:nil];
                self.clickPhotoAlubmBlock = ^(UIImage * image) {
                    if (completeClipBlock) {
                        completeClipBlock (image);
                    }
                };
            }else {
                //拒绝了
                //没有相关的权限提示用户
                NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
                // app名称
                NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
                NSString * messageStr = [NSString stringWithFormat:@"请在iPhone的\"设置-隐私-相机\"选项中，允许%@访问你的相机。",app_Name];
                [self showSureAlertViewTitle:messageStr message:nil sureAction:^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSURL * appurl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                        if([[UIApplication sharedApplication] canOpenURL:appurl]) {
                            [[UIApplication sharedApplication] openURL:appurl];
                        }
                    });
                }];
            }
        });
    }];
}

// 选择图片成功调用此方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage * image = info[UIImagePickerControllerEditedImage];
    if (!image) {
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (self.clickPhotoAlubmBlock) {
        self.clickPhotoAlubmBlock(image);
    }
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
}


// 取消图片选择调用此方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
}

- (UIViewController *)currentViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

- (BOOL)isEmptyWithString:(NSString *)str {
    if (str == nil || str == NULL||[str isKindOfClass:[NSNull class]]||[str isKindOfClass:[NSString class]]==NO) {
        return YES;
    }else{
        return  [self isEmpty:str];
    }
}

- (BOOL)isEmpty:(NSString *)str {
    if ([str isKindOfClass:[NSString class]]) {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - AlertView
- (void)showAlertViewWithTitle:(NSString *)title message:(NSString *)message other:(NSString *)other cancel:(NSString *)cancel otherBlock:(void(^)(void))otherBlock cancelBlock:(void(^)(void))cancelBlock {
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * sure = [UIAlertAction actionWithTitle:other style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (otherBlock) {
            otherBlock ();
        }
    }];
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (cancelBlock) {
            cancelBlock ();
        }
    }];
    [alertVC addAction:sure];
    [alertVC addAction:cancelAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [[self currentViewController] presentViewController:alertVC animated:YES completion:nil];
    });
}

- (void)showSureAlertViewTitle:(NSString *)title message:(NSString *)message sureAction:(void(^)(void))completionHandler {
    if ([[self currentViewController] isKindOfClass:[UIAlertController class]]) {
        return;
    }
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (completionHandler) {
            completionHandler();
        }
    }];
    [action1 setValue:RGBHex(@"#D3AE6C") forKey:@"titleTextColor"];
    [alertVC addAction:action1];
    [[self currentViewController] presentViewController:alertVC animated:YES completion:nil];
}

- (void)showSectionTitles:(NSArray <NSDictionary *>*)titles message:(NSString * _Nullable)message selectHandler:(void(^)(NSInteger selectIndex))selectHandler clickCancelBlock:(void(^)(void))clickCancelBlock {
    if ([[self currentViewController] isKindOfClass:[UIAlertController class]]) {
        return;
    }
    UIAlertController * sheetVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if (clickCancelBlock) {
            clickCancelBlock();
        }
    }];
    //[cancel setValue:MainStyleColor forKey:@"titleTextColor"];
    [sheetVC addAction:cancel];
    
    NSInteger selectIndex = 0;
    for (NSDictionary * dic in titles) {
        NSString * title = dic[@"title"];
        UIColor  * color = dic[@"color"];
        UIAlertAction * action = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (selectHandler) {
                selectHandler(selectIndex);
            }
        }];
        [sheetVC addAction:action];
        [action setValue:color forKey:@"titleTextColor"];
        selectIndex++;
    }
    
    if (message) {
        NSMutableAttributedString *messageString = [[NSMutableAttributedString alloc] initWithString:message];
        [messageString setAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#8F8F8F" alpha:1], NSFontAttributeName: [UIFont systemFontOfSize:14]} range:NSMakeRange(0, message.length)];
        [sheetVC setValue:messageString forKey:@"attributedMessage"];
    }
    [[self currentViewController] presentViewController:sheetVC animated:YES completion:nil];
}

- (NSString*)getCurrentTimes {
    NSDate * datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    NSString * timeSp = [NSString stringWithFormat:@"%ld", (long)([datenow timeIntervalSince1970]*1000)];
    return timeSp;
}

- (BOOL)isEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

@end
