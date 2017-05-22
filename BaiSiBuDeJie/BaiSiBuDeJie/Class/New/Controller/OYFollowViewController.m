//
//  OYFollowViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/23.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYFollowViewController.h"
#import "OYHttpTool.h"
#import "OYFollowViewCell.h"
#import "OYFollowItem.h"
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface OYFollowViewController ()
//  数组
@property(nonatomic,strong)NSMutableArray   *array;
//  保存的模型
@property(nonatomic,strong)OYFollowItem  *item;
//  任务
@property(nonatomic,strong)NSURLSessionDataTask  *task;
@end

@implementation OYFollowViewController


static NSString  *ID = @"followCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"推荐标签";
    [self relodeDate];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"OYFollowViewCell" bundle:nil] forCellReuseIdentifier:ID];
    
    
    
}
#pragma mark -------------------
#pragma mark 加载数据

-(void)relodeDate{

    NSDictionary *dic  = @{
                           @"a": @"tag_recommend",
                           @"c" : @"topic",
                          @"action":@"sub",
         
                           };
    [SVProgressHUD showWithStatus:@"正在登录中......"];
    
      [OYHttpTool get:@"http://api.budejie.com/api/api_open.php" params:dic success:^(id responseObj) {
        
        [SVProgressHUD dismiss];
        
        _array = [OYFollowItem mj_objectArrayWithKeyValuesArray:responseObj];
        
        
        [self.tableView reloadData];
        
        NSLog(@"%@",responseObj);
        
        
       
    } failure:^(NSError *error) {
        [SVProgressHUD  dismiss];
         NSLog(@"%@",error);
    }];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    [[SDImageCache sharedImageCache] clearMemory];;
    
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [SVProgressHUD dismiss];
    //请求任务也要结束
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OYFollowViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
//    cell.textLabel.text = @"123";
    cell.item = self.array[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


@end
