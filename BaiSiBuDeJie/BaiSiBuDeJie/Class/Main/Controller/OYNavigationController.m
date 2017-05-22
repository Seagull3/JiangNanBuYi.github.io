//
//  OYNavigationController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/18.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYNavigationController.h"

@interface OYNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation OYNavigationController

+(void)load{
    UINavigationBar *navBar  = [UINavigationBar  appearanceWhenContainedIn:self,nil];
    
//    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:[OYNavigationController class]];
    
    NSMutableDictionary *dic  = [NSMutableDictionary dictionary];
    
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:22];
    
    navBar.titleTextAttributes = dic;
    
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //解决手势问题
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    
    
    
    //这个只是解决了手势边缘可以滑动
    self.interactivePopGestureRecognizer.delegate =  NO;
    
    
 
    
}
//实现代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    return self.childViewControllers.count > 1;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.childViewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;

        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        
        [backBtn setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateSelected];
        
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        
        
        [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        
        [backBtn sizeToFit];
        
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    }
    
    
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}



@end
