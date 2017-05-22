//
//  OYTopicPictureView.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/30.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYTopicPictureView.h"
#import "OYTopicsItem.h"
#import <UIImage+GIF.h>
#import <UIImageView+WebCache.h>
//#import <SDWebImageManager.h>
#import <AFNetworking.h>
#import "OYSeeBigPictureViewController.h"
@interface OYTopicPictureView()
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UIImageView *gifImageView;

@property (weak, nonatomic) IBOutlet UIButton *seeBigPictureButton;

@end

@implementation OYTopicPictureView

-(void)awakeFromNib{
    self.pictureImageView.userInteractionEnabled = YES;
    [self.pictureImageView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bigImage)]];
    
}

#pragma mark -------------------
#pragma mark 跳转大图控制器
-(void)bigImage{
    OYSeeBigPictureViewController *bigImageVC = [[OYSeeBigPictureViewController alloc]init];
    bigImageVC.topicItem = self.topicItem;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:bigImageVC  animated:YES completion:nil];
    
}

#pragma mark -------------------
#pragma mark 赋值
-(void)setTopicItem:(OYTopicsItem *)topicItem{
    
    _topicItem = topicItem;
    
//    UIGraphicsBeginImageContext(CGSizeZero);
[self.pictureImageView oy_setOriginalImageUrl:topicItem.image1 thumbnailImageUrl:topicItem.image0 placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
      
        if (image == nil ) return ;
        if (error) return;
    if (!topicItem.isBigImage) return;
    //开启图形上下文 (区域是要显示位置)
        CGFloat itemW = mainScreenW - 2 * OYMargain;
    UIGraphicsBeginImageContext(CGSizeMake(itemW, self.frame.size.height)); // 获取要画的区域
        CGFloat imageW =  itemW ;
        CGFloat imageH =   itemW * topicItem.height /topicItem.width;
        
        [image drawInRect:CGRectMake(0, 0, imageW, imageH)];
        
        self.pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    
    }];
    self.gifImageView.hidden = !topicItem.is_gif;
    self.seeBigPictureButton.hidden = !topicItem.bigImage;
  
}


/**
 *  根据网络情况加载图片
 */

    //已经封装
-(void)loadImage{
//    
//    UIImage *originalImage =[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageUrl];
//    //缓存中有图片
//    if (originalImage) {
//        [self.pictureImageView sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:self.topicItem.image1 completed:completedBlock];
//    }//没有图片的话
//    else{
//        AFNetworkReachabilityManager *mgr =  [AFNetworkReachabilityManager sharedManager];
//        //WiFi的情况下
//        
//        if (mgr.isReachableViaWiFi) {
//            
//            [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placeholderImage completed:completedBlock];
//        }//网络的情况下
//        else if (mgr.isReachableViaWWAN){
//            //假如用户硬性要求需要看高清的图片的话 就需要设置 用一个bool 值来接受
//            BOOL alwaysDownloadCacheImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"alwaysDownloadCacheImage"];
//            if (alwaysDownloadCacheImage) {
//                [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placeholderImage completed:completedBlock];
//            }else{
//                
//                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrl] placeholderImage:placeholderImage completed:completedBlock];
//            }
//        }
//        else {
//            UIImage *thumbnailImage = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:thumbnailImageUrl];
//            if (thumbnailImage) {
//                [self sd_setImageWithURL:[NSURL URLWithString: thumbnailImageUrl] placeholderImage:placeholderImage completed:completedBlock];
//            }
//            else{
//                [self  sd_setImageWithURL:nil placeholderImage:placeholderImage completed:completedBlock];
//            }
//        }
//    }

   
 
}
@end
