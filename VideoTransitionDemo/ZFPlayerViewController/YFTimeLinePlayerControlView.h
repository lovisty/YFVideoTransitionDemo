//
//  YFTimeLinePlayerControlView.h
//  VideoTransitionDemo
//
//  Created by YaFei on 2018/12/11.
//  Copyright © 2018 YaFei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFPlayerControlView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YFTimeLinePlayerControlDelegate <NSObject>

- (void)startTransition;

@end


@interface YFTimeLinePlayerControlView : ZFPlayerControlView
@property (nonatomic, assign) id<YFTimeLinePlayerControlDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
