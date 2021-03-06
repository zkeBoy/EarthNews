//
//  EVOSubmitCommunityController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOSubmitCommunityController.h"
#import "EVOSubmitCustomBtn.h"
#import "EVOUserDataManager.h"
#import "EVOUserCommunityDataObj.h"
#import "EVOCommunityDataManager.h"

@interface EVOSubmitCommunityController () <TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navBarHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (nonatomic, strong) EVOSubmitCustomBtn * uploadImgBtn;
@property (nonatomic, strong) EVOSubmitCustomBtn * picture1;
@property (nonatomic, strong) EVOSubmitCustomBtn * picture3;
@property (nonatomic, strong) EVOSubmitCustomBtn * picture2;
@property (weak, nonatomic) IBOutlet UIView *bottomLayerView;
@property (weak, nonatomic) IBOutlet UILabel *localAddressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;

@property (nonatomic, strong) NSMutableArray <UIImage *>* selectUploadImgArray; //缩略图
@property (nonatomic, strong) NSMutableArray <UIImage *>* normalUploadImgArray; //原图
@end

@implementation EVOSubmitCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectUploadImgArray = [NSMutableArray array];
    self.normalUploadImgArray = [NSMutableArray array];
    
    self.navBarHeightConstraint.constant = kStatusBarHeight+kNavigationBarHeight;
    
    self.bottomLayerView.layer.cornerRadius = 14;
    self.localAddressLabel.text = [EVOUserDataManager shareUserDataManager].userDataObj.location;
    
    self.view.backgroundColor = MainBgColor;
    self.inputTextView.backgroundColor = SecondBgColor;
    self.inputTextView.placeholder = @"说点什么～";
    self.inputTextView.placeholdFont = NFont(16);
    self.inputTextView.limitLength = @(140);
    
    WeakSelf(self);
    self.uploadImgBtn = [EVOSubmitCustomBtn new];
    self.uploadImgBtn.deleteBtn.hidden = YES;
    [self.view addSubview:self.uploadImgBtn];
    self.uploadImgBtn.clickSelectImgBlock = ^{
        //选择照片
        [WeakSelf takePhotoActionh];
    };
    
    self.picture1 = [EVOSubmitCustomBtn new];
    self.picture1.selectTag = 100;
    self.picture1.hidden = YES;
    [self.view addSubview:self.picture1];
    self.picture1.clickRemoveImgBlock = ^(NSInteger tag) {
        NSInteger selectIndex = tag/100-1;
        [WeakSelf deleteSelectImgIndex:selectIndex];
    };
    
    self.picture2 = [EVOSubmitCustomBtn new];
    self.picture2.selectTag = 200;
    self.picture2.hidden = YES;
    [self.view addSubview:self.picture2];
    self.picture2.clickRemoveImgBlock = ^(NSInteger tag) {
        NSInteger selectIndex = tag/100-1;
        [WeakSelf deleteSelectImgIndex:selectIndex];
    };
    
    self.picture3 = [EVOSubmitCustomBtn new];
    self.picture3.selectTag = 300;
    self.picture3.hidden = YES;
    [self.view addSubview:self.picture3];
    self.picture3.clickRemoveImgBlock = ^(NSInteger tag) {
        NSInteger selectIndex = tag/100-1;
        [WeakSelf deleteSelectImgIndex:selectIndex];
    };
    
    NSInteger itemSize = (kScreenWidth-34)/3;
    NSInteger top = kStatusBarHeight+kNavigationBarHeight+198+15;
    
    self.topHeight.constant = 30+itemSize;
    
    [self.uploadImgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(itemSize);
        make.left.equalTo(self.view).offset(13);
        make.top.equalTo(self.view).offset(top);
    }];
    
    [self.picture1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(itemSize);
        make.left.equalTo(self.view).offset(13);
        make.top.equalTo(self.view).offset(top);
    }];
    
    [self.picture2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(itemSize);
        make.left.equalTo(self.picture1.mas_right).offset(4);
        make.top.equalTo(self.view).offset(top);
    }];
    
    [self.picture3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(itemSize);
        make.left.equalTo(self.picture2.mas_right).offset(4);
        make.top.equalTo(self.view).offset(top);
    }];
}

#pragma mark - Private Method
- (IBAction)clickBackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitCommunityAction:(id)sender {
    if (!self.inputTextView.text.length) {
        [self showToastText:@"请输入描述!"];
        return;
    }
    
    if (self.inputTextView.text.length>140) {
        [self showToastText:@"描述应少于140字符!"];
        return;
    }
    
    if (!self.selectUploadImgArray.count) {
        [self showToastText:@"请上传发布的照片!"];
        return;
    }
    
    [[EVONormalToolManager shareManager] showAlertViewWithTitle:@"发布轨迹动态将会记录并展示您的当前位置信息，确定要发布吗？" message:nil other:@"确定" cancel:@"取消" otherBlock:^{
        NSMutableArray * imgs = [NSMutableArray array];
        for (UIImage * image in self.selectUploadImgArray) {
            NSData * data = UIImagePNGRepresentation(image);
            [imgs addObject:data];
        }
        
        NSMutableArray * normalImgs = [NSMutableArray array];
        for (UIImage * image in self.normalUploadImgArray) {
            NSData * data = UIImagePNGRepresentation(image);
            [normalImgs addObject:data];
        }
        
        EVOUserCommunityDataObj * communityDataObj = [EVOUserCommunityDataObj new];
        communityDataObj.userHeadImg = [EVOUserDataManager shareUserDataManager].userDataObj.userHeadImg;
        communityDataObj.Gender = [EVOUserDataManager shareUserDataManager].userDataObj.userSex;
        communityDataObj.Name = [EVOUserDataManager shareUserDataManager].userDataObj.userName;
        communityDataObj.Intrduce = self.inputTextView.text;
        communityDataObj.Age = [EVOUserDataManager shareUserDataManager].userDataObj.userAge;
        communityDataObj.imgArray = imgs;
        communityDataObj.normalImgArray = normalImgs;
        communityDataObj.Nation = [EVOUserDataManager shareUserDataManager].userDataObj.location;
        communityDataObj.isSelf = @"1";
        communityDataObj.ID = [[EVONormalToolManager shareManager] getCurrentTimes];
        [[EVOCommunityDataManager shareCommunityDataManager] submitMySelfCommunityData:communityDataObj];
        
        [self showToastText:@"发布成功"];
        
        [self clickBackAction:nil];
    } cancelBlock:nil];
}

- (void)deleteSelectImgIndex:(NSInteger)idx {
    if (idx>=self.selectUploadImgArray.count) {
        return;
    }
    
    [self.normalUploadImgArray removeObjectAtIndex:idx];
    [self.selectUploadImgArray removeObjectAtIndex:idx];
    [self refreshSelectImgBtn];
}

- (void)takePhotoActionh {
    if (self.selectUploadImgArray.count>=3) {
        [self showToastText:@"已经达到上限!"];
        return;
    }
    /*
    [[EVONormalToolManager shareManager] clipPhotoalbumImage:^(UIImage * _Nonnull image) {
        UIImage * newImg = [image imageCompressFitSize:CGSizeMake(38, 38)];
        [self.selectUploadImgArray addObject:newImg];
        [self.normalUploadImgArray addObject:image];
        [self refreshSelectImgBtn];
    }];*/
    [self clickAddHeadAction:nil];
}

- (void)clickAddHeadAction:(id)sender {
    //MaxImagesCount  可以选着的最大条目数
    TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
    // 是否显示可选原图按钮
    imagePicker.allowPickingOriginalPhoto = NO;
    // 是否允许显示视频
    imagePicker.allowPickingVideo = NO;
    // 是否允许显示图片
    imagePicker.allowPickingImage = YES;
    // 这是一个navigation 只能present
    // 设置 模态弹出模式。 iOS 13默认非全屏
    imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
// 选择照片的回调
- (void)imagePickerController:(TZImagePickerController *)picker
      didFinishPickingPhotos:(NSArray<UIImage *> *)photos
                sourceAssets:(NSArray *)assets
       isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    [self.selectUploadImgArray addObject:photos.firstObject];
    [self.normalUploadImgArray addObject:photos.firstObject];
    [self refreshSelectImgBtn];
}

- (void)refreshSelectImgBtn {
    if (self.normalUploadImgArray.count==0) {
        self.picture1.hidden = YES;
        self.picture2.hidden = YES;
        self.picture3.hidden = YES;
        self.uploadImgBtn.hidden = NO;
        self.uploadImgBtn.mj_x = self.picture1.mj_x;
    }
    
    if (self.normalUploadImgArray.count==1) {
        self.picture1.hidden = NO; [self.picture1.contentImgBtn setImage:self.normalUploadImgArray.firstObject forState:UIControlStateNormal];
        self.picture2.hidden = YES;
        self.picture3.hidden = YES;
        self.uploadImgBtn.hidden = NO;
        self.uploadImgBtn.mj_x = self.picture2.mj_x;
    }
    
    if (self.normalUploadImgArray.count==2) {
        self.picture1.hidden = NO; [self.picture1.contentImgBtn setImage:self.normalUploadImgArray.firstObject forState:UIControlStateNormal];
        self.picture2.hidden = NO; [self.picture2.contentImgBtn setImage:self.normalUploadImgArray.lastObject forState:UIControlStateNormal];
        self.picture3.hidden = YES;
        self.uploadImgBtn.hidden = NO;
        self.uploadImgBtn.mj_x = self.picture3.mj_x;
    }
    
    if (self.normalUploadImgArray.count==3) {
        self.picture1.hidden = NO; [self.picture1.contentImgBtn setImage:self.normalUploadImgArray.firstObject forState:UIControlStateNormal];
        self.picture2.hidden = NO; [self.picture2.contentImgBtn setImage:self.normalUploadImgArray[1] forState:UIControlStateNormal];
        self.picture3.hidden = NO; [self.picture3.contentImgBtn setImage:self.normalUploadImgArray.lastObject forState:UIControlStateNormal];
        self.uploadImgBtn.hidden = NO;
        self.uploadImgBtn.hidden = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
