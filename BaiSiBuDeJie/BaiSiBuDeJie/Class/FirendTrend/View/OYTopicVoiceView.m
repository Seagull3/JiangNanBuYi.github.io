//
//  OYTopicVoiceView.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/30.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYTopicVoiceView.h"
#import "OYTopicsItem.h"
#import <UIImageView+WebCache.h>
@interface OYTopicVoiceView()
@property (weak, nonatomic) IBOutlet UILabel *voicePlayCountLael;
@property (weak, nonatomic) IBOutlet UIImageView *voiceImageView;
@property (weak, nonatomic) IBOutlet UILabel *voiceTimeLabel;
@end


@implementation OYTopicVoiceView

-(void)setTopicItem:(OYTopicsItem *)topicItem{
    _topicItem = topicItem;
    
    if (topicItem.playcount.integerValue > 0 ) {
        self.voicePlayCountLael.text = [NSString stringWithFormat:@"%zd次播放",topicItem.playcount.integerValue];
    }else{
        self.voicePlayCountLael.text = @"播放";
    }
    NSInteger voiceTime = topicItem.voicetime.integerValue;
    self.voiceTimeLabel.text = [NSString stringWithFormat:@"%02zd :%02zd",voiceTime /60 ,voiceTime % 60];
  
    [self.voiceImageView oy_setOriginalImageUrl:topicItem.image1 thumbnailImageUrl:topicItem.image0 placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil ) return ;
        if (error) return;
        if (!topicItem.isBigImage) return;
        //开启图形上下文 (区域是要显示位置)
        CGFloat itemW = mainScreenW - 2 * OYMargain;
        UIGraphicsBeginImageContext(CGSizeMake(itemW, self.frame.size.height)); // 获取要画的区域
        CGFloat imageW =  itemW ;
        CGFloat imageH =   itemW * topicItem.height /topicItem.width;
        
        [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
        
        self.voiceImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }];
    
    
}
@end
