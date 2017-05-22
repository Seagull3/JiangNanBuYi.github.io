//
//  OYLoginRegisterViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/22.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYLoginRegisterViewController.h"
#import "OYFastLoginView.h"
#import "OYRegistLoginView.h"

@interface OYLoginRegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *midView;
@property (weak, nonatomic) IBOutlet UIView *topView;
//约束是相对于走边或者右边的宽度

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *width;



@end

@implementation OYLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //快速登录
    OYFastLoginView *fastLoginView = [OYFastLoginView fastLoginView];
    [self.bottomView  addSubview:fastLoginView];
   
    //登录
    OYRegistLoginView *loginView  = [OYRegistLoginView registLoginView];
    [self.midView addSubview:loginView];
    //注册
    OYRegistLoginView *registView  = [OYRegistLoginView registView];
    [self.midView addSubview:registView];
    
    NSLog(@"%@",NSStringFromCGRect(self.midView.frame));
    
    
   
}
//退出
- (IBAction)goBackClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)registClickBtn:(UIButton *)sender {
    
    sender.selected =  !sender.selected;
    self.width.constant = self.width.constant == 0 ? -mainScreenW : 0;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    OYFastLoginView *fastLoginView = self.bottomView.subviews[0];
    fastLoginView.frame = self.bottomView.bounds;
//    self.bottomView.backgroundColor = [UIColor redColor];
    
    //登录的View
    OYRegistLoginView *loginView = self.midView.subviews[0];
    loginView.frame = CGRectMake(0, 0, mainScreenW, self.midView.bounds.size.height);
   
    //注册的View
    OYRegistLoginView *registView = self.midView.subviews[1];
    registView.frame = CGRectMake( mainScreenW, 0, mainScreenW, self.midView.bounds.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
