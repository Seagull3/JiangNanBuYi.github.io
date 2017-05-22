//
//  AppDelegate.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/17.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarController.h"
#import "OYADViewController.h"
#import <AFNetworking.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  //1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
   //2.设置根控制器
    MainTabBarController *mainVC = [[MainTabBarController alloc]init];
    
//    
//    OYADViewController *adVC = [[OYADViewController alloc]init];
//    
//    self.window.rootViewController = adVC;
    self.window.rootViewController =  mainVC;
    //3.显示窗口
    
    [self.window makeKeyAndVisible];
    
    //4.开始网络监测
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    return YES;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:nil];
    
    if (point.y > 20) return;
    NSLog(@"点击了状态栏");
    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
