//
//  EVOInputCommentView.m
//  EarthNews
//
//  Created by mr_huang on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOInputCommentView.h"


@interface EVOInputCommentView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *sendBtn;

@property (nonatomic, copy) NSString *normalStr;
@end

@implementation EVOInputCommentView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 49);
        self.backgroundColor = RGBHex(@"#000000");
        _normalStr = @"输入评论内容";
        [self setupUI];
    }
    return self;
}


- (void)setupUI
{
    _commentTextView = [[UITextField alloc]init];
    _commentTextView.delegate = self;
    _commentTextView. backgroundColor = RGBHex(@"#1A1A1A");
    _commentTextView.layer.cornerRadius = 4;
    _commentTextView.attributedPlaceholder = [[NSAttributedString alloc]initWithString:_normalStr attributes:@{NSForegroundColorAttributeName:RGBHex(@"#5F5F5F")}];
    _commentTextView.keyboardType = UIKeyboardTypeDefault;
    _commentTextView.returnKeyType = UIReturnKeySend;
    _commentTextView.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 1)];
    _commentTextView.leftViewMode = UITextFieldViewModeAlways;
    _commentTextView.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 1)];
    _commentTextView.rightViewMode = UITextFieldViewModeAlways;
    _commentTextView.textColor = RGBHex(@"#FFFFFF");
    _commentTextView.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    [self addSubview:_commentTextView];
    
    _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBtn setTitleColor:RGBHex(@"#FFFFFF") forState:UIControlStateNormal];
    _sendBtn.titleLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
    [_sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sendBtn];
    
    [_sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.width.equalTo(@(61));
    }];
    [_commentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(8);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.left.equalTo(self.mas_left).offset(16);
        make.right.equalTo(self.sendBtn.mas_left);
    }];
}

- (void)sendBtnClick
{
    [self.commentTextView resignFirstResponder];
    if ([self.commentTextView.text isEqualToString:@""] || self.commentTextView.text == nil) {
        
        return;
    }
    if (self.sendCommentsBlock) {
        self.sendCommentsBlock(self.commentTextView.text);
    }
    self.commentTextView.text = @"";
}

//MARK: UITextViewDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([textField.text isEqualToString:@""] || textField.text == nil) {
        
        return YES;
    }
    if (self.sendCommentsBlock) {
        self.sendCommentsBlock(textField.text);
    }
    textField.text = @"";
    return YES;
}

@end
