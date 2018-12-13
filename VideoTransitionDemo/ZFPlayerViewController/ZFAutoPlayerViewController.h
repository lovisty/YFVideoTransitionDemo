//
//  ZFAutoPlayerViewController.h
//  ZFPlayer
//
//  Created by 紫枫 on 2018/5/14.
//  Copyright © 2018年 紫枫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZFPlayerDetailViewController.h"
#import "ZFTableViewCell.h"
#import "ZFTableData.h"
#import "YFTimeLinePlayerControlView.h"

@interface ZFAutoPlayerViewController : UIViewController
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) YFTimeLinePlayerControlView *controlView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *urls;
@end
