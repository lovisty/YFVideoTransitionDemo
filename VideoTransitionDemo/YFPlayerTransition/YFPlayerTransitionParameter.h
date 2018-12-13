//
//  YFPlayerTransitionParameter.h
//  VideoTransitionDemo
//
//  Created by YaFei on 2018/12/10.
//  Copyright © 2018 YaFei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 此处展示有两种 Present 转场场景
 1、如果正在播放的视频，视频保持播放进行 Present 转场。
 2、如果播放器还未初始化，使用封面图进行 Present 转场。
 */

typedef NS_ENUM (NSInteger, YFTransitionType) {
    YFTransitionTypeDefault = 0,
    YFTransitionTypeVideo,
};

@interface YFPlayerTransitionParameter : NSObject

@property (nonatomic, assign) CGRect firstTransFrame;//转场前相对于 Window 的 frame
@property (nonatomic, assign) CGRect secondTransFrame;//转场后在目标 ViewController 中的 frame

@property (nonatomic, assign) YFTransitionType transitionType;
@property (nonatomic, strong) NSString *videoUrlString;//视频源地址
@property (nonatomic, strong) NSString *videoCoverUrlString;//视频封面地址
@property (nonatomic, strong) ZFPlayerController *player;//播放器
@property (nonatomic, strong) UIView *playerContentView;//播放器所在的View;
@property (nonatomic, strong) UIImage *videoCoverImage;

@end

NS_ASSUME_NONNULL_END
