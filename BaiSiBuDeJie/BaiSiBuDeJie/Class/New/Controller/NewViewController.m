//
//  NewViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/17.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "NewViewController.h"
#import "OYFollowViewController.h"
#import <AFNetworking.h>
#import "OYHttpTool.h"
#import "OYTopicsItem.h"
#import  <MJExtension.h>
#import <SVProgressHUD.h>
#import <MediaPlayer/MediaPlayer.h>
#import "OYTopicVideosView.h"
#import <AVFoundation/AVFoundation.h>
#import <UIImageView+WebCache.h>

#import "OYTopicCell.h"


@interface NewViewController ()<oYTopicCellDelegate>
/**
 *  模型数组
 */
@property(nonatomic,strong)NSMutableArray   *itemsArray;
/**
 *  底部view的lable
 */
@property(nonatomic,weak) UILabel   *footLable;
/**
 *  底部的View
 */
@property(nonatomic,weak) UIView   *footView;

/**maxtime */
@property (nonatomic, copy) NSString *maxtime;
/**
 *  下拉刷新的标题
 */
@property(nonatomic,weak) UILabel   *headLable;

/**
 *  底部是否刷新
 */
@property(nonatomic,assign,getter=isFootRefresh) BOOL  footRefresh;
/**
 *  头部是否刷新
 */
@property(nonatomic,assign,getter=isHeadRefresh) BOOL  headRefresh;

/**
 *  网络管理者
 */
@property(nonatomic,strong)AFHTTPSessionManager  *manger;
/**
 *  网络类型  1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
 */
@property(nonatomic,assign) NSNumber  *type;

//  模型
@property(nonatomic,weak)OYTopicVideosView  *VideosView;

//  模型
@property(nonatomic,strong)OYTopicsItem  *item;
//  音频播放器
@property(nonatomic,strong)AVPlayer  *player;

@end

@implementation NewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    [self setNav];
    self.tableView.contentInset = UIEdgeInsetsMake(OYNavgationBarH- 64,  0 , OYTarBarHeight - 64, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -30, 0, 0);
    
    [self setNote];
    [self setHeadView];
    [self setFootView];
    [self headBeginRefresh];
    [self registCell];
}
-(void)setNav{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"MainTagSubIcon"] highlightImage:[UIImage imageNamed:@"MainTagSubIconClick"] target:self action:@selector(subTag)];
    
    UIView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageV;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击了 subTag
-(void)subTag{
    OYFollowViewController *followVc = [[OYFollowViewController alloc]init];
    
    [self.navigationController pushViewController:followVc animated:YES];
    
    NSLog(@"点击了tag");
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(NSNumber *)type{
    return _type = @(OYTopicsItemTypeAll);
}

/**
 *  网络管理者 懒加载
 *
 *
 */
-(AFHTTPSessionManager *)manger{
    if (_manger == nil) {
        _manger = [[AFHTTPSessionManager alloc]init];
        
    }
    return _manger;
}
static NSString  *videosCell = @"VideosCell";
static NSString  *pictureCell = @"pictureCell";
static NSString  *wordCell = @"wordCell";
static NSString  *voiceCell = @"voiceCell";


static NSString  *topicCellID = @"topicCell";

#pragma mark -------------------
#pragma mark 注册cell
-(void)registCell{
    [self.tableView registerNib:[UINib nibWithNibName:@"OYTopicCell" bundle:nil] forCellReuseIdentifier:topicCellID];
}



#pragma mark -------------------
#pragma mark  playBtn的点击
-(void)playBtnclick:(OYTopicCell *)cell{
    if (cell.topicItem.type == OYTopicsItemTypeVideos ) {
        AVPlayerViewController *AvPlayer = [[AVPlayerViewController alloc]init];
        
        AvPlayer.player =[AVPlayer playerWithURL:[NSURL URLWithString:cell.topicItem.videouri]];
        [AvPlayer.player play];
        [self.navigationController pushViewController:AvPlayer animated:YES];

    }else{
        self.player  = [AVPlayer playerWithURL:[NSURL URLWithString:cell.topicItem.voiceuri]];
        [self.player play];
    }
 
    
}



-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark -------------------
#pragma mark 接收通知
-(void)setNote{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:OYTabBarRepeatClickNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(titleButtonDidRepeatClick) name:OYTitleRepeatClickNotification object:nil];
}
-(void)tabBarButtonDidRepeatClick{
    
    if (self.tableView.scrollsToTop == NO) return;
    if (self.tableView.window == nil)  return;
    [self headBeginRefresh];
}
-(void)titleButtonDidRepeatClick{
    [self tabBarButtonDidRepeatClick];
}

#pragma mark -------------------
#pragma mark 设置头部和尾部的view
-(void)setFootView{
    
    UIView *footView  = [[UIView alloc]init];
    footView.frame = CGRectMake(0, 0, mainScreenW, OYTitlesViewH);
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(0, 0, footView.OY_width, footView.OY_height /2);
    label.OY_centerY = footView.OY_centerY;
    [footView addSubview:label];
    self.tableView.tableFooterView = footView;
    label.textAlignment = NSTextAlignmentCenter;
    self.footLable = label;
    footView.backgroundColor = [UIColor redColor];
    label.text = @"向下拉刷新数据.....";
    self.footView = footView;
}

-(void)setHeadView{
    
    UILabel  *headLabel = [[UILabel alloc]init];
    headLabel.frame = CGRectMake(0, -40, mainScreenW, 40);
    //    headLabel.backgroundColor = [UIColor redColor];
    headLabel.textAlignment = NSTextAlignmentCenter;
    headLabel.text = @"下拉可以刷新";
    [self.tableView addSubview:headLabel];
    self.headLable = headLabel ;
    
}

#pragma mark -------------------
#pragma mark 发送网络请求

-(void)loadDate:(BOOL)boolMaxtime{
    [self.manger.tasks makeObjectsPerformSelector:@selector(cancel)];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"newlist";
    params[@"c"] = @"data";
    params[@"type"] = self.type;
    if (boolMaxtime == YES) {
        params[@"maxtime"] = self.maxtime;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.manger GET:getUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            
            NSArray *array = responseObject[@"list"];
            
            NSMutableArray  *itemsArray = [OYTopicsItem mj_objectArrayWithKeyValuesArray:array];
            if (boolMaxtime == YES) {
                self.maxtime = responseObject[@"info"][@"maxtime"];
                [self.itemsArray addObjectsFromArray:itemsArray];
                [self footEndRefresh];
            }else{
                NSString *maxtime = responseObject[@"info"][@"maxtime"];
                
                self.maxtime = maxtime;
                self.itemsArray = itemsArray;
                [self headEndRefresh];
            }
            
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (boolMaxtime) {
                
                [self footEndRefresh];
            }else{
                [self headEndRefresh];
            }
            if (error.code == NSURLErrorCancelled) return;
            
            // 请求失败的提醒
            [SVProgressHUD showErrorWithStatus:@"网络繁忙,请稍后再试!"];
            
            
        }];
    });
    
}


#pragma mark -------------------
#pragma mark 减速完成
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    
    if (self.isHeadRefresh) return;
    
    //    if (scrollView.contentOffset.x < 0 ) return;
    CGFloat offsetY = -(self.tableView.contentInset.top + self.headLable.OY_height);
    if (scrollView.contentOffset.y <=offsetY ) {
        [self headBeginRefresh];
    }
    //    NSLog(@"%f",self.tableView.contentOffset.y);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [self dealHeader];
    [self dealFooter];
    [[SDImageCache sharedImageCache] clearMemory];;
    
    
}
#pragma mark -------------------
#pragma mark 头部下拉刷新
-(void)dealHeader{
    if (self.headLable == nil )   return;
    if(self.isHeadRefresh) return;
    if (self.tableView.contentOffset.y <= -(OYTitlesViewH +OYNavgationBarH + self.headLable.OY_height )) {
        self.headLable.text = @"松开立即刷新";
        self.headLable.backgroundColor = [UIColor purpleColor];
    }else{
        self.headLable.text = @"下拉可以刷新";
        self.headLable.backgroundColor = [UIColor redColor];
        
    }
    //    NSLog(@"%f",self.tableView.contentOffset.y);
}

-(void)headBeginRefresh{
    
    if (self.isHeadRefresh) return;
    self.headRefresh = YES;
    self.headLable.text = @"正在刷新中";
    self.headLable.backgroundColor = [UIColor yellowColor];
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top += self.headLable.OY_height;
        self.tableView.contentInset = inset;
        
        CGPoint offset = self.tableView.contentOffset;
        offset.y = - inset.top;
        self.tableView.contentOffset = offset;
    }];
    // 发送请求给服务器
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self loadDate:NO];
    });
}

-(void)headEndRefresh{
    self.headRefresh = NO;
    
    // 减小内边距
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.tableView.contentInset;
        inset.top -= self.headLable.OY_height;
        self.tableView.contentInset = inset;
    }];
    
}
#pragma mark -------------------
#pragma mark 尾部上拉刷新
-(void)dealFooter{
    if (self.itemsArray.count == 0) return;
    
    if (self.isFootRefresh) return;
    CGFloat offsetY = self.tableView.contentSize.height + self.footView.bounds.size.height - self.tableView.bounds.size.height;
    
    if (self.tableView.contentOffset.y > offsetY ) {
        [self footBeginRefresh];
    }
    
}

-(void)footBeginRefresh{
    if (self.isFootRefresh) return;
    self.footRefresh = YES;
    self.footLable.text = @"正在玩命的加载中........";
    self.footView.backgroundColor = [UIColor blueColor];
    [self loadDate:YES];
}

-(void)footEndRefresh{
    self.footRefresh = NO;
    self.footView.backgroundColor = [UIColor redColor];
    self.footLable.text = @"向上拉刷新数据.....";
}
#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    OYTopicsItem *item  = self.itemsArray[indexPath.row];
    
    return item.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.footView.hidden = (self.itemsArray.count == 0);
    return self.itemsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    	1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
    OYTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:topicCellID];
    cell.delegate =  self;
    OYTopicsItem *item = self.itemsArray[indexPath.row];
    self.item = item;
    cell.topicItem = item;
    return cell;
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.player = nil;
}




@end
