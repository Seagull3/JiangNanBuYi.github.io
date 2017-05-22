//
//  OYSettingViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/19.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYSettingViewController.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>
#define cacthPath  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

@implementation OYSettingViewController

static NSString  *ID = @"setCell";
-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"设置";

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:UIBarButtonItemStyleDone target:self action:@selector(jump)];

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];

    [self.tableView reloadData];
//    [self getSize];

}
-(void)jump{
    
}




-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    [SVProgressHUD  dismiss];
}




#pragma mark -------------------
#pragma mark 数据源
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (indexPath.section == 0 ) {
        if (indexPath.row == 0) {
            
            cell.textLabel.text = [self getSize];
            
            return cell;
        }else{
            cell.textLabel.text =[NSString stringWithFormat:@"_%zd行_%zd列_",indexPath.section,indexPath.row];
            return cell ;
        }
    }else{
    cell.textLabel.text =[NSString stringWithFormat:@"_%zd行_%zd列_",indexPath.section,indexPath.row];
        return cell ;
    }
    return cell;
}

-(NSString *)getSize{
    NSInteger size  = [self getSizeCaches:cacthPath];
    NSLog(@"size == %zd",size);
   
    NSString *str = @"清除缓存";
    if (size > 1000 * 1000) {
       str =  [str stringByAppendingFormat:@"(%.1fMB)",size /1000.0 /1000.0];
    }
    else if (size > 1000){
        str =  [str stringByAppendingFormat:@"(%1fKB)",size / 1000.0 ];
        
    }
    else
      str  = [str stringByAppendingFormat:@"(%zdB)",size];
    return str;

}

-(NSInteger)getSizeCaches:(NSString *)cachers{
    NSInteger size  = 0;
   
    
    NSFileManager *mgr   = [NSFileManager defaultManager];
    NSLog(@"%@",cachers);
  NSArray *subPaths  =  [mgr subpathsAtPath:cachers];
    for (NSString *fileName  in subPaths) {

        NSString *fillPath = [cachers stringByAppendingPathComponent:fileName];
        
        NSDictionary *attrs = [mgr attributesOfItemAtPath:fillPath error:nil];
        size += [attrs fileSize];
    }
//    NSLog(@"%@",subPaths);
    NSLog(@"size == %zd",size);
    return  size;
    
}
-(void)remove:(NSString *)cachers{
      NSFileManager *mgr   = [NSFileManager defaultManager];
    NSArray *subPaths  =  [mgr subpathsAtPath:cachers];
    for (NSString *fileName  in subPaths) {
        
        NSString *fillPath = [cachers stringByAppendingPathComponent:fileName];
        
        [mgr removeItemAtPath:fillPath error:nil];
    }

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            [SVProgressHUD showSuccessWithStatus:@"正在清理中...."];
        
            [self remove:cacthPath];
            
            [self.tableView reloadData];
            NSLog(@"点击了");
        }
    }
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
