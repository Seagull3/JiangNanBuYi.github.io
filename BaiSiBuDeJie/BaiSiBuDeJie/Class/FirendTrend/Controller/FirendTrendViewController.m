//
//  FirendTrendViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/17.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "FirendTrendViewController.h"
#import "UIBarButtonItem+OYItem.h"
#import "OYTitleButton.h"

#import "OYVideosViewController.h"
#import "OYWordViewController.h"
#import "OYVoiceViewController.h"
#import "OYAllViewViewController.h"
#import "OYPictureViewController.h"

@interface FirendTrendViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak) OYTitleButton   *previousButton;
@property(nonatomic,weak) UIView   *titlesView;
@property(nonatomic,weak) UIView   *underLine;
@property(nonatomic,weak) UIScrollView    *scrollerView;


@end

@implementation FirendTrendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor redColor];
    [self addChildViewController];
    [self setNavBar];
    [self setScrollView];
    [self setTitlesView];
    
    [self addChildViewIndex:0];
    
}

-(void)dealloc{
    
}

#pragma mark -------------------
#pragma mark 添加scrollerView
//添加scorllView

-(void)setScrollView{
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView * scrollView = [[UIScrollView alloc]init];

    scrollView.frame = self.view.bounds;
    scrollView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:scrollView];
    
    
    scrollView.showsVerticalScrollIndicator  = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    

//    for (NSInteger i = 0 ; i < 5;  i ++) {
//        UIView *childView = self.childViewControllers[i].view;
//        
//    childView.frame = CGRectMake(i * mainScreenW, 0, mainScreenW, mainScreenH);
//        
//        
//        [scrollView addSubview:childView];
//    }
//    
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(5 * mainScreenW, 0);
    scrollView.scrollsToTop = NO;
    
    scrollView.delegate = self;
    self.scrollerView = scrollView;
}

#pragma mark -------------------
#pragma mark 添加自控制器

-(void)addChildViewController{
    
    [self addChildViewController:[[OYAllViewViewController alloc]init]];
    [self addChildViewController:[[OYVideosViewController  alloc]init]];
    [self addChildViewController:[[OYVoiceViewController alloc]init]];
    [self addChildViewController:[[OYPictureViewController alloc]init]];
    [self addChildViewController:[[OYWordViewController alloc]init]];
}


#pragma mark -------------------
#pragma mark 添加titlesView
/**
 *  封装的标题View
 */
-(void)setTitlesView{
    
    UIView *titlesView = [[UIView alloc]init];
    CGFloat  titlesH = 40;
    titlesView.frame = CGRectMake(0, 64, mainScreenW, titlesH);
    titlesView.backgroundColor  = [UIColor colorWithWhite:1 alpha:0.5];
    
    [self.view addSubview:titlesView];
     self.titlesView = titlesView;
    
    [self addTitleButton:titlesView];
    
    [self setUnderlineView];
    
    
    
}

/**
 *  添加下划线
 */
-(void)setUnderlineView{
    OYTitleButton *titleButton = _titlesView.subviews.firstObject;
    
    CGFloat underLineH = 2;
    UIView *underLine = [[UIView alloc]init];
    underLine.frame = CGRectMake(0, _titlesView.OY_height - underLineH, titleButton.titleLabel.OY_width, underLineH);
    underLine.backgroundColor = [UIColor redColor];
    
    [_titlesView addSubview:underLine];
    _underLine = underLine;
    
    titleButton.selected = YES;
    self.previousButton = titleButton;
    
    //一般都要写这句  自适应尺寸
    [titleButton.titleLabel sizeToFit];

    underLine.OY_width = titleButton.titleLabel.OY_width + 10;
    underLine.OY_centerX = titleButton.OY_centerX;
}


#pragma mark -------------------
#pragma mark titleView 添加button
-(void)addTitleButton:(UIView *)titlesView{
    
    NSArray *array = @[@"全部",@"视频",@"声音",@"图片",@"段子"];
    
    CGFloat titleButtonH = titlesView.OY_height;
    CGFloat titleButtonW = titlesView.OY_width / array.count;
    
    for (NSInteger i = 0 ; i < array.count ; i ++ ) {
        OYTitleButton *titleButton = [[OYTitleButton alloc]init];
        titleButton.frame = CGRectMake(i * titleButtonW , 0, titleButtonW, titleButtonH);
        
        [titleButton setTitle:array[i] forState:UIControlStateNormal];

        [titleButton addTarget:self  action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        titleButton.tag = i;
        
        [titlesView addSubview:titleButton];
    }
}


#pragma mark -------------------
#pragma mark scrollView的偏移
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//  
//}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
    NSInteger index = scrollView.contentOffset.x /mainScreenW;
    
   
//    
//    self.underLine.OY_centerX = self.scrollerView.contentOffset.x / index * mainScreenW;
    // 如果上一次点击的按钮 和 这次想要点击的按钮 相同，直接返回
    // 如果上一次点击的按钮 和 这次想要点击的按钮 相同，直接返回
    if (self.previousButton == self.titlesView.subviews[index]) return;
    
    [self titleButtonClick:self.titlesView.subviews[index]];
    
}

#pragma mark -------------------
#pragma mark //设置点击TitleView的Button

-(void)titleButtonClick:(OYTitleButton *)titleButton {
    if (self.previousButton == titleButton) {
        [[NSNotificationCenter defaultCenter]  postNotificationName:OYTitleRepeatClickNotification object:nil];
    }
  //把之前选中的选中状态取消
    //再把现在选中的设置为Yes
    //还要重写button的setHighlight 方法 加入点击了就会变成nomal状态
    //   自定义btn 一次性设置的initWithFrame  方法中 假如要假如子控件 也是   布局的话  在LayoutSubViews
    
    _previousButton.selected = NO;
    titleButton.selected = YES;
    _previousButton = titleButton;
    NSInteger  index = titleButton.tag;
//    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.underLine.OY_width = titleButton.titleLabel.OY_width + 10;
        self.underLine.OY_centerX = titleButton.OY_centerX;
        
        
        self.scrollerView.contentOffset = CGPointMake(index * mainScreenW, 0);
        
    } completion:^(BOOL finished) {
        [self addChildViewIndex:index];
        
  }];
    
    //遍历子控制器的View 首先  假如没有加载了的话 才能跳过 再取出控制器的view 强转成scrollerView  设置它的属性  回到顶部  假如选中的i的值与tag 值一样  那就设成Yes
    for (NSInteger i = 0 ; i < self.childViewControllers.count; i ++ ) {
        UIViewController *childVc  = self.childViewControllers[i];
        if (![childVc isViewLoaded]) continue;
        
        UIScrollView *scrollerView =(UIScrollView *) childVc.view;
        
        if (index == i ) {
           scrollerView.scrollsToTop = YES;
        }
        else{
           scrollerView.scrollsToTop = NO;
        }
    }
 
//    NSLog(@"点击了btn");
}


#pragma mark -------------------
#pragma mark 创建tableView  实现懒加载效果
-(void)addChildViewIndex:(NSInteger )index {
    UIViewController *childVc  = self.childViewControllers[index];
    if ([childVc isViewLoaded])  return;
    childVc.view.frame = CGRectMake(index * mainScreenW, 0, mainScreenW, mainScreenH);
    
    [self.scrollerView addSubview:childVc.view];
}

#pragma mark -------------------
#pragma mark //设置导航条

-(void)setNavBar{

    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"nav_item_game_icon"] highlightImage:[UIImage imageNamed:@"nav_item_game_click_icon"] target:self action:@selector(game)];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"navigationButtonRandomN"] highlightImage:[UIImage imageNamed:@"navigationButtonRandomClick"] target:self action:@selector(random)];
    
    UIView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"MainTitle"]];
    self.navigationItem.titleView = imageV;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  //点击游戏按钮
 */
-(void)game{
    NSLog(@"点击了游戏");
}
/**
 *  //点击了随机
 */
-(void)random{
    NSLog(@"点击了随机");
}


@end
