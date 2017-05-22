//
//  OYTopicViewController.h
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/7/2.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

@interface OYTopicViewController : UITableViewController
-(NSNumber *)type;
//  音频播放器
@property(nonatomic,strong)AVPlayer  *player;
@end
