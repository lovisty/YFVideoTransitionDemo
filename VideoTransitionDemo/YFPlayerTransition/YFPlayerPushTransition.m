//
//  YFPlayerPushTransition.m
//  VideoTransitionDemo
//
//  Created by YaFei on 2018/12/10.
//  Copyright © 2018 YaFei. All rights reserved.
//

#import "YFPlayerPushTransition.h"
#import "YFTimeLinePlayerControlView.h"

@implementation YFPlayerPushTransition
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
//    if (self.transitionParameter.transitionType == YFTransitionTypeVideo){
//        return 0.35
//    }
    return 0.35;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIView *containerView = [transitionContext containerView];
    containerView.backgroundColor = [UIColor clearColor];
    
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toViewController.view.hidden = YES;
    [containerView addSubview:toViewController.view];
    
    UIView *bgView = [[UIView alloc] initWithFrame:containerView.bounds];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0;
    [containerView addSubview:bgView];
    
    UIView *transitionView = [[UIView alloc] initWithFrame:self.transitionParameter.firstTransFrame];
    
    UIImageView *coverImageView = nil;
    if (self.transitionParameter.transitionType == YFTransitionTypeVideo){
        ZFPlayerControlView *controlView = (ZFPlayerControlView *)self.transitionParameter.player.controlView;
        controlView.coverImageView.hidden = YES;
        [self.transitionParameter.player updateNoramlPlayerWithContainerView:transitionView];
    }else{
        coverImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.transitionParameter.firstTransFrame.size.width, self.transitionParameter.firstTransFrame.size.height)];
        coverImageView.image = self.transitionParameter.videoCoverImage;
        coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        [transitionView addSubview:coverImageView];
    }
    [containerView addSubview:transitionView];
    
    self.transitionParameter.player.currentPlayerManager.view.backgroundColor = [UIColor clearColor];
    //动画
    @weakify(self)
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        transitionView.frame = self.transitionParameter.secondTransFrame;
        CGFloat _y =  (transitionView.frame.size.height-self.transitionParameter.firstTransFrame.size.height)/2;
        if (coverImageView) {
            coverImageView.frame = CGRectMake(0, _y, self.transitionParameter.firstTransFrame.size.width, self.transitionParameter.firstTransFrame.size.height);
        }

        //转场开始隐藏cell上的视图 隐藏控制层
        self.transitionParameter.playerContentView.hidden = YES;
        self.transitionParameter.player.controlView.hidden = YES;
        bgView.alpha = 1;
    } completion:^(BOOL finished) {
        @strongify(self)
        NSLog(@"%@",coverImageView);
        toViewController.view.hidden = NO;
        [bgView removeFromSuperview];
        [transitionView removeFromSuperview];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"YFPlayerCompleteTransitionPush" object:@(self.transitionParameter.transitionType)];
        //通知系统动画执行完毕
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        //转场结束显示cell上的视图 显示控制层
        self.transitionParameter.player.controlView.hidden = NO;
       
    }];
}

@end
