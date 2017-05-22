//
//  OYADViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/19.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYADViewController.h"
#import "MainTabBarController.h"
#import <AFNetworking.h>
#import "OYADItem.h"
#import <MJExtension.h>
#import <UIImageView+WebCache.h>


#define ipone6P [UIScreen mainScreen].bounds.size.height == 736
#define ipone6  [UIScreen mainScreen].bounds.size.height == 667
#define ipone5  [UIScreen mainScreen].bounds.size.height == 568
#define ipone4  [UIScreen mainScreen].bounds.size.height == 480
#define url @"http://mobads.baidu.com/cpro/ui/mads.php%20"
#define code @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface OYADViewController ()
@property(nonatomic,weak) UIImageView   *imageV;


@property (weak, nonatomic) IBOutlet UIButton *adBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *adVIew;
//  定时器
@property(nonatomic,strong)NSTimer  *timer;
//  主控制器
@property(nonatomic,strong) MainTabBarController *mainVc ;
//  模型
@property(nonatomic,strong)OYADItem  *item;


@end

@implementation OYADViewController
  /* 
   http://mobads.baidu.com/cpro/ui/mads.php%20
   */

/*http://mobads.baidu.com/cpro/ui/mads.php%20?code2=phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setImageV];
   NSTimer *time =  [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(change) userInfo:nil repeats:YES];

    self.timer = time;
    [self setImageV];
    [self loadADImage];
    
}

-(UIImageView *)imageV{
    
    if (_imageV == nil )
    {
        UIImageView *imageView = [[UIImageView alloc]init];
        _imageV = imageView;
        
        [self.adVIew addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(tap)];
        [imageView addGestureRecognizer:tap];
    
    }
    return _imageV;
}




-(void)tap{
    
   UIApplication *app =  [UIApplication sharedApplication];
    if ([app canOpenURL:[NSURL URLWithString:self.item.ori_curl]]) {
        [app openURL:[NSURL URLWithString:self.item.ori_curl]];
    }
    
    
}
//监听点击按钮
- (IBAction)adBtnClick:(UIButton *)sender {
    
    [self.timer invalidate];
    [UIApplication sharedApplication].keyWindow.rootViewController =[[MainTabBarController alloc]init];
}

//加载广告界面
-(void)loadADImage{
    
    //创建会话管理者
    AFHTTPSessionManager  *mgr = [AFHTTPSessionManager manager];
    
    //请求参数  ,@"text/html"
    
    NSDictionary *dic  = @{
                @"code2":code
                           };
    
    [mgr GET:url parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *ADDic = responseObject;
        NSArray *array = ADDic[@"ad"];
        
        OYADItem  *item = [OYADItem mj_objectWithKeyValues:array[0]];
        
//        self.imageView.bounds.size.height = item.w  ;
        if (item.w == 0 || item.h == 0) {
            return ;
        }
        self.item = item;
        CGFloat screenW = mainScreenW;
        CGFloat screenH = mainScreenW/item.w * item.h;
        
        self.imageV.frame = CGRectMake(0, 0, screenW, screenH);
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:item.w_picurl]];
        
        
//        NSLog(@"成功 ===  %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
    
}



-(void)change{
    
  static  NSInteger i = 3;
    
    if (i <= 0 ) {

        [self.timer invalidate];
       
        [self adBtnClick:nil];
        
    }
    i--;
    [self.adBtn setTitle:[NSString stringWithFormat:@"跳过 %zds",i] forState:UIControlStateNormal];
    [self.adBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}
//设置启动图片
-(void)setImageV{
    UIImage *image = [[UIImage alloc]init];
    if (ipone6P) {
        image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
    }
    else if (ipone6){
        image = [UIImage imageNamed:@"LaunchImage-800-667h"];
    }
    else if (ipone5){
        image = [UIImage imageNamed:@"LaunchImage-700-568h"];
    }
    else if (ipone4){
        image = [UIImage imageNamed:@"LaunchImage"];
    }
    _imageView.image = image;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
