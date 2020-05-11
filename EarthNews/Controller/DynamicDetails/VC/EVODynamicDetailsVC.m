//
//  EVODynamicDetailsVC.m
//  EarthNews
//
//  Created by mr_huang on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVODynamicDetailsVC.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>
#import "EVODynamicInfoView.h"
#import "EVOAnnotation.h"
#import "EVOBulletChatView.h"
#import "FDanmakuView.h"
#import "EVOBullevchatModel.h"
#import "EVOInputCommentView.h"

@interface EVODynamicDetailsVC ()<MAMapViewDelegate,FDanmakuViewProtocol>
@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) FDanmakuView *bullteChatView;

@property (nonatomic, strong) EVOInputCommentView *inputView;
@end

@implementation EVODynamicDetailsVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [AMapServices sharedServices].apiKey = EVOAMapKey;
    
    self.mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
//    self.mapView.zoomEnabled = NO;
//    self.mapView.scrollEnabled = NO;
    self.mapView.rotateEnabled = NO;
    [self.view addSubview:self.mapView];
    [self.view sendSubviewToBack:self.mapView];
    
    CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(30.66074, 104.06327);
    
    NSMutableArray *poiAnnotations = [NSMutableArray new];
    EVOAnnotation * annotation = [[EVOAnnotation alloc]init];
    annotation.coordinate = coordinate;
    [poiAnnotations addObject:annotation];
    [self.mapView addAnnotations:poiAnnotations];
    [self.mapView showAnnotations:poiAnnotations animated:YES];
    
    self.mapView.centerCoordinate = coordinate;

    [self setupBullteChatView];
    [self setupInputView];
    [self setupTitleViews];
    [self addNotifacaitons];
}
- (void)setupTitleViews
{
    UIImageView * backView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"details_top"]];
    [self.view addSubview:backView];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(popBackClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *titleTextLabel = [UILabel new];
    titleTextLabel.text = @"轨迹详情";
    titleTextLabel.font = [UIFont boldSystemFontOfSize:17];
    titleTextLabel.textColor = UIColor.whiteColor;
    titleTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleTextLabel];
    
    [titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kStatusBarHeight+10);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleTextLabel);
        make.left.equalTo(self.view.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(38, 24));
    }];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(88));
    }];
}
- (void)setupBullteChatView
{
    _bullteChatView = [[FDanmakuView alloc]init];
    _bullteChatView.delegate = self;
    [self.view addSubview:_bullteChatView];
    [_bullteChatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.equalTo(@(250));
    }];
}
- (void)popBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

//MARK: 键盘相关通知
- (void)addNotifacaitons
{
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyBoardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}
- (void)keyBoardWillShow:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGFloat keyboardAnimationDurtion = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect endKeyboardRect = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:keyboardAnimationDurtion animations:^{
        
        self.inputView.frame = CGRectMake(0, kScreenHeight - endKeyboardRect.size.height - 49, kScreenWidth, 49);
       
    }];
//_keyBoardIsShow = YES;
}
- (void)keyBoardWillHide:(NSNotification *)notification{
    NSDictionary *info = [notification userInfo];
    CGFloat keyboardAnimationDurtion = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];

    [UIView animateWithDuration:keyboardAnimationDurtion animations:^{
        self.inputView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49);
    }];
}
- (void)keyBoardDidHide:(NSNotification *)notification{
//    _keyBoardIsShow = NO;
}
//MARK: 输入框
- (void)setupInputView
{
    _inputView = [[EVOInputCommentView alloc]init];
    __weak typeof(self) weakSelf = self;
    _inputView.sendCommentsBlock = ^(NSString *comments) {
        EVOBullevchatModel * model = [EVOBullevchatModel new];
        model.beginTime = .1;
        model.liveTime = 2;
        model.content = comments;
        model.name = @"张三";
        [weakSelf.bullteChatView.modelsArr addObject:model];
    };
    
    [self.view addSubview:_inputView];
}
//MARK: 添加弹幕
- (void)addBullteChat{
    EVOBullevchatModel *model1 = [[EVOBullevchatModel alloc]init];
    model1.beginTime = .1;
    model1.liveTime = 2;
    model1.content = @"哈哈哈~😊🙂😎~~~";
    model1.name = @"张三";
    
    EVOBullevchatModel *model2 = [[EVOBullevchatModel alloc]init];
    model2.beginTime = 1;
    model2.liveTime = 3;
    model2.content = @"23322333";
    model2.name = @"李四";
       
    [self.bullteChatView.modelsArr addObject:model1];
    [self.bullteChatView.modelsArr addObject:model2];
}
//MARK: MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[EVOAnnotation class]])
    {
        static NSString *poiIdentifier = @"poiIdentifier";
        EVODynamicInfoView *poiAnnotationView = (EVODynamicInfoView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:poiIdentifier];
        if (poiAnnotationView == nil)
        {
            poiAnnotationView = [[EVODynamicInfoView alloc] initWithAnnotation:annotation reuseIdentifier:poiIdentifier];
            
            // 屏蔽默认的calloutView
            poiAnnotationView.canShowCallout = NO;
        }
        [poiAnnotationView setInfoWithObj:self.objModel];
        __weak typeof(self) weakSelf = self;
        //MARK: 气泡点击响应
        poiAnnotationView.btnsOnClickBlock = ^(NSInteger btnTag) {
            if (btnTag == 0) {
               
            } else if (btnTag == 1)
            {
                [weakSelf.inputView.commentTextView becomeFirstResponder];
            } else {
              
            }
            
            
        };
        return poiAnnotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    
   
}
//MARK: FDanmakuViewProtocol
-(NSTimeInterval)currentTime {
    static double time = 0;
    time += 0.1 ;
    return time;
}
- (UIView *)danmakuViewWithModel:(EVOBullevchatModel *)model
{
    EVOBulletChatView * chatView = [[EVOBulletChatView alloc]init];
    chatView.model = model;
    return chatView;
}
- (void)danmuViewDidClick:(UIView *)danmuView at:(CGPoint)point
{
    
}
- (void)danmakuViewEndWithModel:(EVOBullevchatModel *)model
{
    [self.bullteChatView.modelsArr addObject:model];

}
@end
