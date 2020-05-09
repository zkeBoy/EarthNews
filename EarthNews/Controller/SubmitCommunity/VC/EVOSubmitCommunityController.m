//
//  EVOSubmitCommunityController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOSubmitCommunityController.h"

@interface EVOSubmitCommunityController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navBarHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextView *inputTextView;

@end

@implementation EVOSubmitCommunityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navBarHeightConstraint.constant = kStatusBarHeight+kNavigationBarHeight;
    
    self.view.backgroundColor = MainBgColor;
    self.inputTextView.backgroundColor = SecondBgColor;
    self.inputTextView.placeholder = @"说点什么～";
    self.inputTextView.placeholdFont = NFont(16);
    self.inputTextView.limitLength = @(140);
}

#pragma mark - Private Method
- (IBAction)clickBackAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)submitCommunityAction:(id)sender {
    
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
