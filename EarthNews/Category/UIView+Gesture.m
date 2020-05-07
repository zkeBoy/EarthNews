//
//  UIView+Gesture.m
//  MFProject
//
//  Created by zkeBoy on 2020/3/19.
//

#import "UIView+Gesture.h"
#import <objc/runtime.h>
static char kActionHandlerTapBlockKey;
static char kActionHandlerTapGestureKey;
static char kActionHandlerLongPressBlockKey;
static char kActionHandlerLongPressGestureKey;

@implementation UIView (Gesture)

- (void)addTapActionWithBlock:(GestureActionBlock)block {
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerTapGestureKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForTapGesture:)];
        self.userInteractionEnabled=YES;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForTapGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerTapBlockKey);
        if (block) {
            block(gesture);
        }
    }
}

- (void)addLongPressActionWithBlock:(GestureActionBlock)block {
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kActionHandlerLongPressGestureKey);
    if (!gesture) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleActionForLongPressGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &kActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &kActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)handleActionForLongPressGesture:(UITapGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized){
        GestureActionBlock block = objc_getAssociatedObject(self, &kActionHandlerLongPressBlockKey);
        if (block){
            block(gesture);
        }
    }
}

- (void)addNormalTapGestureWithTarget:(id)target atction:(SEL)selector {
    self.userInteractionEnabled=YES;
    if ([target respondsToSelector:selector]) {
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tap];
    }
}

- (void)addLongPressGestureWithTarget:(id)target atction:(SEL)selector {
    self.userInteractionEnabled=YES;
    if ([target respondsToSelector:selector]) {
        UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:target action:selector];
        longPressGr.minimumPressDuration = 0.5;
        [self addGestureRecognizer:longPressGr];
    }
}

#pragma mark -
- (UIView *)firstResponder {
    UIView* ret = nil;
    for (UIView* view in [self subviews]){
        UIView* focus = [self firstResponderOfView:view];
        if (focus != nil){
            ret = focus;
            break;
        }
    }
    return ret;
}

- (UIView *)firstResponderOfView:(UIView*)view {
    if (view != nil && [view isFirstResponder]){
        return view;
    }
    for (UIView* subView in [view subviews]){
        UIView* focus = [self firstResponderOfView:subView];
        if (focus != nil && [focus isFirstResponder]){
            return focus;
        }
    }
    return nil;
}

- (BOOL)becomeFirstResponderWithSubView {
    for (UIView* subView in [self subviews]) {
        if ([subView isKindOfClass:[UITextField class]]){
            UITextField* textField = (UITextField*)subView;
            return [textField becomeFirstResponder];
        }
        if ([subView isKindOfClass:[UITextView class]]) {
            UITextView* textView = (UITextView*)subView;
            return [textView becomeFirstResponder];
        }
    }
    return NO;
}

- (BOOL)resignFirstResponderWithSubView {
    for (UIView* subView in [self subviews]) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField* textField = (UITextField*)subView;
            return [textField resignFirstResponder];
        }
        if ([subView isKindOfClass:[UITextView class]]){
            UITextView* textView = (UITextView*)subView;
            return [textView resignFirstResponder];
        }
    }
    return NO;
}

- (BOOL)isFirstResponderWithSubView {
    for (UIView* subView in [self subviews]) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField* textField = (UITextField*)subView;
            return [textField isFirstResponder];
        }
        if ([subView isKindOfClass:[UITextView class]]) {
            UITextView* textView = (UITextView*)subView;
            return [textView isFirstResponder];
        }
    }
    return NO;
}

- (NSString*)textOfSubView {
    for (UIView* subView in [self subviews]) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField* textField = (UITextField*)subView;
            return textField.text;
        }
        if ([subView isKindOfClass:[UITextView class]]) {
            UITextView* textView = (UITextView*)subView;
            return textView.text;
        }
    }
    return @"";
}

- (void)setSubViewText:(NSString*)text {
    for (UIView* subView in [self subviews]) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField* textField = (UITextField*)subView;
            textField.text = text;
            break;
        }
        if ([subView isKindOfClass:[UITextView class]]) {
            UITextView* textView = (UITextView*)subView;
            textView.text = text;
            break;
        }
    }
}

- (void)hideKeyboard {
    [self endEditing:YES];
}

-(void)setSubViewEnable:(BOOL)enable {
    for (UIView* subView in [self subviews]) {
        subView.userInteractionEnabled=enable;
    }
}

@end
