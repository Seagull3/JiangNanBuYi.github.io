//
//  OYTopicVideosView.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/30.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYTopicVideosView.h"

#import "OYTopicsItem.h"
#import <UIImageView+WebCache.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface OYTopicVideosView()
@property (weak, nonatomic) IBOutlet UIImageView *VideoimageView;

@property (weak, nonatomic) IBOutlet UILabel *playCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *passTimeLable;

@end

@implementation OYTopicVideosView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setTopicItem:(OYTopicsItem *)topicItem{
    
    _topicItem = topicItem;
    [self.VideoimageView sd_setImageWithURL:[NSURL URLWithString:topicItem.image0]];
    if (topicItem.playcount.integerValue > 0 ) {
        self.playCountLabel.text = [NSString stringWithFormat:@"%zd次播放",topicItem.playcount.integerValue];
    }else{
         self.playCountLabel.text = @"播放";
    }
    NSInteger VoideoTime = topicItem.videotime.integerValue;
    self.passTimeLable.text = [NSString stringWithFormat:@"%02zd :%02zd",VoideoTime /60 ,VoideoTime % 60];
    [self.playButton setImage:[UIImage imageNamed:@"video-play"] forState:UIControlStateNormal];
    [self.VideoimageView oy_setOriginalImageUrl:topicItem.image1 thumbnailImageUrl:topicItem.image0 placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil ) return ;
        if (error) return;
        if (!topicItem.isBigImage) return;
        //开启图形上下文 (区域是要显示位置)
        CGFloat itemW = mainScreenW - 2 * OYMargain;
        UIGraphicsBeginImageContext(CGSizeMake(itemW, self.frame.size.height)); // 获取要画的区域
        CGFloat imageW =  itemW ;
        CGFloat imageH =   itemW * topicItem.height /topicItem.width;
        
        [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
        
        self.VideoimageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
    }];

}



@end
