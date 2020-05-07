//
//  UIView+Gesture.h
//  MFProject
//
//  Created by zkeBoy on 2020/3/19.
//

#import <UIKit/UIKit.h>

typedef void (^GestureActionBlock)(UIGestureRecognizer *_Nonnull);

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Gesture)
/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)addTapActionWithBlock:(GestureActionBlock)block;
/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)addLongPressActionWithBlock:(GestureActionBlock)block;

/// 添加手势
/// @param target
/// @param selector
- (void)addNormalTapGestureWithTarget:(id)target atction:(SEL)selector;


/// 添加长按
/// @param target
/// @param selector 
- (void)addLongPressGestureWithTarget:(id)target atction:(SEL)selector;

@end

NS_ASSUME_NONNULL_END
