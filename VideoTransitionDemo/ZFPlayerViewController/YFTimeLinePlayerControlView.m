//
//  YFTimeLinePlayerControlView.m
//  VideoTransitionDemo
//
//  Created by YaFei on 2018/12/11.
//  Copyright © 2018 YaFei. All rights reserved.
//

#import "YFTimeLinePlayerControlView.h"
#import "UIImageView+ZFCache.h"

@interface YFTimeLinePlayerControlView()

@end

@implementation YFTimeLinePlayerControlView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)gestureSingleTapped:(ZFPlayerGestureControl *)gestureControl {
    if (!self.player) return;
    if ([self.delegate respondsToSelector:@selector(startTransition)]) {
        [self.delegate performSelector:@selector(startTransition)];
    }
}

@end
