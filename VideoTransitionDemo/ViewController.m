//
//  ViewController.m
//  VideoTransitionDemo
//
//  Created by YaFei on 2018/12/10.
//  Copyright © 2018 YaFei. All rights reserved.
//

#import "ViewController.h"
#import "YFPlayerDetailsViewController.h"
#import "YFPlayerInteractiveAnimatedTransition.h"
#import "YFTimeLinePlayerControlView.h"

@interface ViewController ()<YFTimeLinePlayerControlDelegate>
@property (nonatomic, strong) YFPlayerInteractiveAnimatedTransition *animatedTransition;
@property (nonatomic, assign) BOOL isVisiable;
@property (nonatomic, assign) NSInteger readyPlayIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"视频列表";
    self.controlView.delegate = self;
    self.controlView.bottomPgrogress.hidden = NO;
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completeTransition:) name:@"YFPlayerCompleteTransitionPop" object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isVisiable = YES;
}

- (YFPlayerInteractiveAnimatedTransition *)animatedTransition{
    if (!_animatedTransition) {
        _animatedTransition = [[YFPlayerInteractiveAnimatedTransition alloc] init];
    }
    return _animatedTransition;
}

//重新方法 为了实现 cell 上没有播放视频的转场动画
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self startTransitionWithIndex:indexPath.row];
}

#pragma mark - YFTimeLinePlayerControlDelegate 开始转场
- (void)startTransition{
    [self startTransitionWithIndex:self.player.currentPlayIndex];
}

- (void)startTransitionWithIndex:(NSInteger)index{
    if (!self.isVisiable) {
        return;
    }
    self.readyPlayIndex = index;
    //准备转场前的参数
    YFPlayerTransitionParameter *transitionParameter = [self readyTransitionParameter:index];
    self.animatedTransition = nil;
    self.animatedTransition.transitionParameter = transitionParameter;
    
    YFPlayerDetailsViewController *detailVC = [YFPlayerDetailsViewController new];
    detailVC.animatedTransition = self.animatedTransition;
    detailVC.transitioningDelegate = self.animatedTransition;
    [self presentViewController:detailVC animated:YES completion:nil];
    
}

- (YFPlayerTransitionParameter *)readyTransitionParameter:(NSInteger)index{

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    ZFTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    YFPlayerTransitionParameter *transitionParameter = [[YFPlayerTransitionParameter alloc] init];
    transitionParameter.firstTransFrame = [cell.contentView  convertRect:cell.coverImageView.frame toView:self.view.window];
    transitionParameter.secondTransFrame = self.view.window.bounds;
    transitionParameter.playerContentView = cell.coverImageView;
    
    BOOL isSame = [self.player.assetURL.absoluteString isEqualToString:cell.layout.data.video_url];
    BOOL isPlaying = self.player.currentPlayerManager.isPlaying;
    if (!isSame && isPlaying) {
        [self.player stopCurrentPlayingCell];
    }
    if (isSame) {
        transitionParameter.transitionType = YFTransitionTypeVideo;
        if (self.player.currentPlayerManager.playState == ZFPlayerPlayStatePaused) {
            [self.player.currentPlayerManager play];
        }
    }else{
        cell.playBtn.hidden = YES;
        transitionParameter.transitionType = YFTransitionTypeDefault;
        transitionParameter.videoUrlString = cell.layout.data.video_url;
        transitionParameter.videoCoverUrlString = cell.layout.data.thumbnail_url;
        transitionParameter.videoCoverImage = cell.coverImageView.image;
    }
    
    transitionParameter.player = self.player;
    
    return transitionParameter;
}

#pragma mark - 结束转场
- (void)completeTransition:(NSNotification *)notify{
    
    NSInteger indexRow = self.readyPlayIndex;
    ZFTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexRow inSection:0]];
    cell.coverImageView.hidden = NO;
    self.player.currentPlayerManager.view.backgroundColor = [UIColor blackColor];
    [self.player updateNoramlPlayerWithContainerView:cell.coverImageView];
    
    self.controlView.delegate = self;
    if (self.animatedTransition.transitionParameter.transitionType != YFTransitionTypeVideo) {
        [self.player stop];
        cell.playBtn.hidden = NO;
        [cell.coverImageView bringSubviewToFront:cell.playBtn];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.isVisiable = NO;
}
@end
