//
//  FollewViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/17.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "FollewViewController.h"
#import "OYLoginRegisterViewController.h"

@interface FollewViewController ()

@end

@implementation FollewViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self setNav];
    
}
//点击了登录
- (IBAction)loginClick {
    OYLoginRegisterViewController *vc = [[OYLoginRegisterViewController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
    
}

-(void)setNav{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"friendsRecommentIcon"] highlightImage:[UIImage imageNamed:@"friendsRecommentIconClick"] target:self action:@selector(friendRecomment)];
    
    self.navigationItem.title = @"我的关注";
}

//点击了friendRecomment
-(void)friendRecomment{
    NSLog(@"点击了friendRecomment");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
