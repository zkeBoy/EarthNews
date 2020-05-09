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

@interface EVOSubmitCommunityController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navBarHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;
@property (nonatomic, strong) EVOSubmitCustomBtn * uploadImgBtn;
@property (nonatomic, strong) EVOSubmitCustomBtn * picture1;
@property (nonatomic, strong) EVOSubmitCustomBtn * picture3;
@property (nonatomic, strong) EVOSubmitCustomBtn * picture2;
@property (nonatomic, strong) NSMutableArray <UIImage *>* selectUploadImgArray;
@end

@implementation EVOSubmitCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.selectUploadImgArray = [NSMutableArray array];
    
    self.navBarHeightConstraint.constant = kStatusBarHeight+kNavigationBarHeight;
    
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
    NSInteger top = kStatusBarHeight+kNavigationBarHeight+211;
    
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
    
    if (self.selectUploadImgArray.count) {
        [self showToastText:@"请上传发布的照片!"];
        return;
    }
    
    NSMutableArray * imgs = [NSMutableArray array];
    for (UIImage * image in self.selectUploadImgArray) {
        NSData * data = UIImagePNGRepresentation(image);
        [imgs addObject:data];
    }
    
    EVOUserCommunityDataObj * communityDataObj = [EVOUserCommunityDataObj new];
    communityDataObj.userHeadImg = [EVOUserDataManager shareUserDataManager].userDataObj.userHeadImg;
    communityDataObj.Gender = [EVOUserDataManager shareUserDataManager].userDataObj.userSex;
    communityDataObj.Name = [EVOUserDataManager shareUserDataManager].userDataObj.userName;
    communityDataObj.Intrduce = self.inputTextView.text;
    communityDataObj.Age = [EVOUserDataManager shareUserDataManager].userDataObj.userAge;
    communityDataObj.imgArray = imgs;
    communityDataObj.Nation = @"成都";
    
    
}

- (void)deleteSelectImgIndex:(NSInteger)idx {
    if (idx>=self.selectUploadImgArray.count) {
        return;
    }
    
    [self.selectUploadImgArray removeObjectAtIndex:idx];
    [self refreshSelectImgBtn];
}

- (void)takePhotoActionh {
    if (self.selectUploadImgArray.count>=3) {
        [self showToastText:@"已经达到上限!"];
        return;
    }
    [[EVONormalToolManager shareManager] takePhotoAlbumImage:^(UIImage * _Nonnull image) {
        [self.selectUploadImgArray addObject:image];
        [self refreshSelectImgBtn];
    }];
}

- (void)refreshSelectImgBtn {
    if (self.selectUploadImgArray.count==0) {
        self.picture1.hidden = YES;
        self.picture2.hidden = YES;
        self.picture3.hidden = YES;
        self.uploadImgBtn.hidden = NO;
        self.uploadImgBtn.mj_x = self.picture1.mj_x;
    }
    
    if (self.selectUploadImgArray.count==1) {
        self.picture1.hidden = NO; [self.picture1.contentImgBtn setImage:self.selectUploadImgArray.firstObject forState:UIControlStateNormal];
        self.picture2.hidden = YES;
        self.picture3.hidden = YES;
        self.uploadImgBtn.hidden = NO;
        self.uploadImgBtn.mj_x = self.picture2.mj_x;
    }
    
    if (self.selectUploadImgArray.count==2) {
        self.picture1.hidden = NO; [self.picture1.contentImgBtn setImage:self.selectUploadImgArray.firstObject forState:UIControlStateNormal];
        self.picture2.hidden = NO; [self.picture2.contentImgBtn setImage:self.selectUploadImgArray.lastObject forState:UIControlStateNormal];
        self.picture3.hidden = YES;
        self.uploadImgBtn.hidden = NO;
        self.uploadImgBtn.mj_x = self.picture3.mj_x;
    }
    
    if (self.selectUploadImgArray.count==3) {
        self.picture1.hidden = NO; [self.picture1.contentImgBtn setImage:self.selectUploadImgArray.firstObject forState:UIControlStateNormal];
        self.picture2.hidden = NO; [self.picture2.contentImgBtn setImage:self.selectUploadImgArray[1] forState:UIControlStateNormal];
        self.picture3.hidden = NO; [self.picture3.contentImgBtn setImage:self.selectUploadImgArray.lastObject forState:UIControlStateNormal];
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
