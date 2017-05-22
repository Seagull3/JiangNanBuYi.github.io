//
//  OYTopicVoiceView.h
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/30.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OYTopicsItem;
@interface OYTopicVoiceView : UIView
@property (weak, nonatomic) IBOutlet UIButton *mp3Player;
@property(nonatomic,strong)OYTopicsItem  *topicItem;
@end
