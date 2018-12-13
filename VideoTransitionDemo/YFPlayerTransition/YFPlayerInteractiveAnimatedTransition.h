//
//  YFPlayerInteractiveAnimatedTransition.h
//  VideoTransitionDemo
//
//  Created by YaFei on 2018/12/10.
//  Copyright © 2018 YaFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YFPlayerTransitionParameter.h"

NS_ASSUME_NONNULL_BEGIN

@interface YFPlayerInteractiveAnimatedTransition : NSObject<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) YFPlayerTransitionParameter *transitionParameter;
@end

NS_ASSUME_NONNULL_END
