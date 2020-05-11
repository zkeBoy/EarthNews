//
//  EVOInputCommentView.h
//  EarthNews
//
//  Created by mr_huang on 2020/5/9.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^sendCommentsBlock)(NSString * comments);
@interface EVOInputCommentView : UIView
@property (nonatomic, copy) sendCommentsBlock sendCommentsBlock;

@property (nonatomic, strong) UITextField *commentTextView;
@end


