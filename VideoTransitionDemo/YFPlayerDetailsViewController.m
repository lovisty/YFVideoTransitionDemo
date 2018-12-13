//
//  YFPlayerDetailsViewController.m
//  VideoTransitionDemo
//
//  Created by YaFei on 2018/12/10.
//  Copyright © 2018 YaFei. All rights reserved.
//

#import "YFPlayerDetailsViewController.h"
#import "YFTimeLinePlayerControlView.h"

@interface YFPlayerDetailsViewController ()<YFTimeLinePlayerControlDelegate>
@property (nonatomic, strong) UIView *myContentView;
@property (nonatomic, strong) ZFAVPlayerManager *playerManager;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) YFTimeLinePlayerControlView *controlView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation YFPlayerDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeTransition:) name:@"YFPlayerCompleteTransitionPush" object:nil];
    
    self.myContentView = [[UIView alloc] initWithFrame:self.animatedTransition.transitionParameter.secondTransFrame];
    
    [self.view addSubview:self.myContentView];
}

- (YFTimeLinePlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [YFTimeLinePlayerControlView new];
    }
    return _controlView;
}


- (void)completeTransition:(NSNotification *)notify{
    YFTransitionType transitionType = [notify.object integerValue];
    if (transitionType == YFTransitionTypeVideo) {
        _player = self.animatedTransition.transitionParameter.player;
        [self.animatedTransition.transitionParameter.player updateNoramlPlayerWithContainerView:self.myContentView];
        YFTimeLinePlayerControlView *controlView =  (YFTimeLinePlayerControlView *)self.player.controlView;
        controlView.delegate = self;
    }else{
        self.playerManager = [[ZFAVPlayerManager alloc] init];
        self.player = [ZFPlayerController playerWithPlayerManager:self.playerManager containerView:self.myContentView];
        self.player.controlView = self.controlView;
        // 设置退到后台继续播放
        self.player.pauseWhenAppResignActive = NO;
        @weakify(self)
        self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
            @strongify(self)
            [self setNeedsStatusBarAppearanceUpdate];
        };
        self.playerManager.assetURL = [NSURL URLWithString:self.animatedTransition.transitionParameter.videoUrlString];
        YFTimeLinePlayerControlView *controlView =  self.controlView;
        [controlView showTitle:@"视频标题" coverURLString:self.animatedTransition.transitionParameter.videoCoverUrlString fullScreenMode:ZFFullScreenModeLandscape];
        controlView.delegate = self;
        controlView.coverImageView.hidden = YES;
        self.animatedTransition.transitionParameter.player = self.player;
    }
}

- (void)startTransition{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
