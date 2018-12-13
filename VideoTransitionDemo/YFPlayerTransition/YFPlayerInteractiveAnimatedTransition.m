//
//  YFPlayerInteractiveAnimatedTransition.m
//  VideoTransitionDemo
//
//  Created by YaFei on 2018/12/10.
//  Copyright © 2018 YaFei. All rights reserved.
//

#import "YFPlayerInteractiveAnimatedTransition.h"
#import "YFPlayerPushTransition.h"
#import "YFPlayerPopTransition.h"

@interface YFPlayerInteractiveAnimatedTransition ()
@property (nonatomic, strong) YFPlayerPushTransition *customPush;
@property (nonatomic, strong) YFPlayerPopTransition  *customPop;
@end

@implementation YFPlayerInteractiveAnimatedTransition

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self.customPush;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    dismissed.view.hidden = NO;
    return self.customPop;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    return nil;//手势交互
}

- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    return nil;//手势交互
}

- (YFPlayerPushTransition *)customPush{
    if (!_customPush) {
        _customPush = [[YFPlayerPushTransition alloc] init];
    }
    return _customPush;
}

- (YFPlayerPopTransition *)customPop{
    if (!_customPop) {
        _customPop = [[YFPlayerPopTransition alloc] init];
    }
    return _customPop;
}

- (void)setTransitionParameter:(YFPlayerTransitionParameter *)transitionParameter{
    _transitionParameter = transitionParameter;
    self.customPush.transitionParameter = transitionParameter;
    self.customPop.transitionParameter = transitionParameter;
}

@end
