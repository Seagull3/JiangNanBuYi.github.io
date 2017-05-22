//
//  MainTabBarController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/17.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "MainTabBarController.h"
#import "AddViewController.h"
#import "FollewViewController.h"
#import "FirendTrendViewController.h"
#import "MeViewController.h"
#import "NewViewController.h"
#import "UIImage+Oringe.h"
#import "OYTabBar.h"
#import "OYNavigationController.h"


@interface MainTabBarController ()
@property(nonatomic,strong) UIButton   *btn;


@end

@implementation MainTabBarController

+(void)load{
    
    UITabBarItem  *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    NSMutableDictionary  *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor blackColor];
  
    [item setTitleTextAttributes:dic forState:UIControlStateSelected];
    
    NSMutableDictionary *fontAtt = [NSMutableDictionary dictionary];
    fontAtt[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    [item setTitleTextAttributes:fontAtt forState:UIControlStateNormal];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setChildController];
    
    [self setUpAllTitleButton];
    
    [self setTabBar];

}

-(void)setChildController{
    
    //精华
    FirendTrendViewController *essenceVc = [[FirendTrendViewController alloc]init];
    
    OYNavigationController *nav = [[OYNavigationController alloc]initWithRootViewController:essenceVc];
    
    [self addChildViewController:nav];
    
    //新帖
    NewViewController *newVc = [[NewViewController alloc]init];
    
    OYNavigationController *nav1 = [[OYNavigationController alloc]initWithRootViewController:newVc];
    
    
    [self addChildViewController:nav1];
   
    //关注
    FollewViewController *followVc = [[FollewViewController alloc]init];
    
    OYNavigationController *nav3 = [[OYNavigationController alloc]initWithRootViewController:followVc];
    
    
    
    [self addChildViewController:nav3];
    
    
    //me
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"MeViewController" bundle:nil];
    MeViewController *meVc = [story instantiateInitialViewController];
    OYNavigationController *nav4 = [[OYNavigationController alloc]initWithRootViewController:meVc];
    
    
    [self addChildViewController:nav4];

}

#pragma mark -------------------
#pragma mark  //自定义tabbar的内容

-(void)setTabBar{
    
    OYTabBar *tabBar = [[OYTabBar alloc]init];
    
    [self setValue:tabBar forKey:@"tabBar"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setUpAllTitleButton{
    //精华
    OYNavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    [nav.tabBarItem setImage:[UIImage imageNamed:@"tabBar_essence_icon"]];
    nav.tabBarItem.selectedImage = [UIImage imageWithOringeName:@"tabBar_essence_click_icon"];
    
    //新帖
    OYNavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    [nav1.tabBarItem setImage:[UIImage imageNamed:@"tabBar_new_icon"]];
    nav1.tabBarItem.selectedImage = [UIImage imageWithOringeName:@"tabBar_new_click_icon"];

    //关注
    OYNavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    [nav3.tabBarItem setImage:[UIImage imageNamed:@"tabBar_friendTrends_icon"]];
    nav3.tabBarItem.selectedImage = [UIImage imageWithOringeName:@"tabBar_friendTrends_click_icon"];

    //我
    
    OYNavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    [nav4.tabBarItem setImage:[UIImage imageNamed:@"tabBar_me_icon"]];
    nav4.tabBarItem.selectedImage = [UIImage imageWithOringeName:@"tabBar_me_click_icon"];

    
}
@end
