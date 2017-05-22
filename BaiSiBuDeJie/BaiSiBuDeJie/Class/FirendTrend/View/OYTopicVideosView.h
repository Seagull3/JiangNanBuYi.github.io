//
//  OYTopicVideosView.h
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/30.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OYTopicsItem;
typedef NSString *(^urlBlock)(NSString *url);
@interface OYTopicVideosView : UIView
@property(nonatomic,strong)OYTopicsItem  *topicItem;
@property (weak, nonatomic) IBOutlet UIButton *playButton;

@property(nonatomic,weak) urlBlock   block;


@end
