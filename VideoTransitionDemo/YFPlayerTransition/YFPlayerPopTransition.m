//
//  YFPlayerPopTransition.m
//  VideoTransitionDemo
//
//  Created by YaFei on 2018/12/10.
//  Copyright © 2018 YaFei. All rights reserved.
//

#import "YFPlayerPopTransition.h"

@implementation YFPlayerPopTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    //转场过渡的容器view
    UIView *containerView = [transitionContext containerView];
    //ToVC
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.hidden = NO;
    [containerView addSubview:toViewController.view];
    //FromVC
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //有渐变的黑色背景
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 1;
    [containerView addSubview:bgView];
    
    UIView *transitionView = [[UIView alloc] initWithFrame:self.transitionParameter.secondTransFrame];
    self.transitionParameter.player.allowOrentitaionRotation = NO;
    [self.transitionParameter.player updateNoramlPlayerWithContainerView:transitionView];
    [containerView addSubview:transitionView];
    
    //动画
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.transitionParameter.player.controlView.hidden = YES;
        transitionView.frame = self.transitionParameter.firstTransFrame;
        bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [bgView removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YFPlayerCompleteTransitionPop" object:@(self.transitionParameter.transitionType)];
        [transitionView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        self.transitionParameter.player.controlView.hidden = NO;
        self.transitionParameter.playerContentView.hidden = NO;
    }];
    
}

@end
