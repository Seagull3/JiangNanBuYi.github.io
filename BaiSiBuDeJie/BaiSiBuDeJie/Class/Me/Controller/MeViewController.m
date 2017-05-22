//
//  MeViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/17.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "MeViewController.h"
#import "OYSettingViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import "OYMeItem.h"
#import "OYMeCollectionViewCell.h"
#import <SafariServices/SafariServices.h>
#import <WebKit/WebKit.h>
#import "OYMeWebVIewController.h"
#import "OYHttpTool.h"




static NSInteger const col = 4;
static CGFloat const margie  = 1 ;
#define itemWH ( mainScreenW - (col - 1) *margie ) / 4
static NSString *ID = @"meCell";

@interface MeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate, SFSafariViewControllerDelegate>
//  模型数组
@property(nonatomic,strong)NSMutableArray  *array;
@property(nonatomic,weak) UICollectionView   *collectionView;


@end

@implementation MeViewController


- (void)viewDidLoad {
    [super viewDidLoad];
//     self.tableView.backgroundColor = [UIColor grayColor];
    [self setNav];
    
    
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 10;
    //设置分割线的距离
    self.tableView.separatorInset = UIEdgeInsetsMake(0, -100, 0, 0);
    //设置 tableview 距离顶部的constentinst
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    [self setUpFootView];
    
    [self loadDate];
    [self.tableView reloadData];
    
    
}

-(void)setUpFootView{
   
    //创建collectionView 
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(itemWH , itemWH );
    layout.minimumLineSpacing = margie;
    layout.minimumInteritemSpacing = margie;
    
    UICollectionView *collection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    
    self.tableView.tableFooterView = collection;
    collection.dataSource = self;
    collection.delegate = self;
    
    collection.backgroundColor = XMGGlobeColor;
     _collectionView = collection;

    
    [collection registerNib:[UINib nibWithNibName:@"OYMeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:ID];

}



#pragma mark -------------------
#pragma mark //加载数据
-(void)loadDate{
    
//    创建会话管理者
//    AFHTTPSessionManager *mgr  = [AFHTTPSessionManager manager];
    
    NSDictionary  *dic  = @{
                            @"a" : @"square",
                            @"c": @"topic",
                            };
    
    [OYHttpTool get:@"http://api.budejie.com/api/api_open.php" params:dic success:^(id responseObj) {
        NSArray *dicArray = responseObj[@"square_list"];
        NSLog(@"%@",dicArray);
        //数组转数组模型
        _array = [OYMeItem mj_objectArrayWithKeyValuesArray:dicArray];
        [self relodeDate];
        
        NSInteger count = _array.count;
        NSLog(@"%zd",count);
        //布局
        NSInteger row  = ( count - 1) / col + 1;
        //获取cell的高度
        CGFloat collectViewH = row * itemWH + (row - 1) * margie;
        self.collectionView.OY_height = collectViewH;
        
        //这里是最重要的  能自动计算collectionView的高度
        self.tableView.tableFooterView = self.collectionView;
        [self.collectionView reloadData];
        //        NSLog(@"%@",responseObject);
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    /*
    //发送get请求获取数据
    [mgr GET:@"http://api.budejie.com/api/api_open.php" parameters:dic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray *dicArray = responseObject[@"square_list"];
        NSLog(@"%@",dicArray);
        //数组转数组模型
        _array = [OYMeItem mj_objectArrayWithKeyValuesArray:dicArray];
        [self relodeDate];
        
        NSInteger count = _array.count;
        NSLog(@"%zd",count);
        //布局
        NSInteger row  = ( count - 1) / col + 1;
        //获取cell的高度
        CGFloat collectViewH = row * itemWH + (row - 1) * margie;
        self.collectionView.OY_height = collectViewH;
        
        //这里是最重要的  能自动计算collectionView的高度
        self.tableView.tableFooterView = self.collectionView;
        [self.collectionView reloadData];
//        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
     */
}

//设置导航条
-(void)setNav{
   UIBarButtonItem *nightItem =  [UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-moon-icon"] highlightImage:[UIImage imageNamed:@"mine-moon-icon-click"] target:self action:@selector(night)];
    UIBarButtonItem *setItem =[UIBarButtonItem barButtonItemWithImage:[UIImage imageNamed:@"mine-setting-icon"] highlightImage:[UIImage imageNamed:@"mine-setting-icon-click"] target:self action:@selector(setting)];
    
    self.navigationItem.rightBarButtonItems = @[setItem,nightItem];
    
    self.navigationItem.title = @"我的";
    
 }
//点击了夜间
-(void)night{
    NSLog(@"点击了夜间");
}

//数据处理
-(void)relodeDate{
    NSInteger extre = self.array.count % 4;
    if (extre) {
        NSInteger cols = col -extre;
        for (int  i = 0 ; i  < cols ; i++) {
            OYMeItem *item  = [[OYMeItem alloc]init];
            [self.array addObject:item];
        }
    }

}

//点击了设置
-(void)setting{
    
    OYSettingViewController   *setVC = [[OYSettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------
#pragma mark 数据源

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OYMeCollectionViewCell  *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
//    UICollectionViewCell *cell  = [[UICollectionViewCell alloc]init];
    cell.item = self.array[indexPath.item];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了");
    OYMeItem *item = self.array[indexPath.item];
    if (![item.url containsString:@"http"]) {
        return;
        
    }
    //    SFSafariViewController *safarVc = [[SFSafariViewController alloc]initWithURL:[NSURL URLWithString:item.url]];
//    [self  presentViewController:safarVc animated:YES completion:nil];
    

    
//    [self.navigationController pushViewController:safarVc animated:YES];
  
    OYMeWebVIewController *webVC = [[OYMeWebVIewController alloc]init];
    webVC.url = item.url;
    [self.navigationController pushViewController:webVC animated:YES];
}
//- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller{
//    [controller dismissViewControllerAnimated:YES completion:nil];
//}

@end
