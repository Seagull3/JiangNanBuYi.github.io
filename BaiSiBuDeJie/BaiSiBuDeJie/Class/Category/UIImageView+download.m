//
//  UIImageView+download.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/7/1.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "UIImageView+download.h"
#import <AFNetworking.h>

///Users/ouyanguiyou/Desktop/代码训练/BaiSiBuDeJie/BaiSiBuDeJie/Class/Category/UIImageView+download.m:19:190: Conflicting parameter types in implementation of 'oy_setOriginalImageUrl:thumbnailImageUrl:placeholderImage:completed:': '__strong id' vs '__strong SDWebImageCompletionBlock' (aka 'void (^__strong)(UIImage *__strong, NSError *__strong, SDImageCacheType, NSURL *__strong)')
@implementation UIImageView (download)

-(void)oy_setOriginalImageUrl:(NSString *)originalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl  completed:(SDWebImageCompletionBlock)completedBlock{
    [self oy_setOriginalImageUrl:originalImageUrl thumbnailImageUrl:thumbnailImageUrl placeholderImage:nil completed:completedBlock];
}

-(void)oy_setOriginalImageUrl:(NSString *)originalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl placeholderImage:(UIImage *)placeholderImage completed:(SDWebImageCompletionBlock)completionBlock {
    
    
    UIImage *originalImage =[[SDImageCache sharedImageCache] imageFromDiskCacheForKey:originalImageUrl];
    //缓存中有图片
    if (originalImage) {
        [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placeholderImage completed:completionBlock];
    }//没有图片的话
    else{
        AFNetworkReachabilityManager *mgr =  [AFNetworkReachabilityManager sharedManager];
        //WiFi的情况下
        
        if (mgr.isReachableViaWiFi) {
            
            [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placeholderImage completed:completionBlock];
        }//网络的情况下
        else if (mgr.isReachableViaWWAN){
            //假如用户硬性要求需要看高清的图片的话 就需要设置 用一个bool 值来接受
            BOOL alwaysDownloadCacheImage = [[NSUserDefaults standardUserDefaults] objectForKey:@"alwaysDownloadCacheImage"];
            if (alwaysDownloadCacheImage) {
                [self sd_setImageWithURL:[NSURL URLWithString:originalImageUrl] placeholderImage:placeholderImage completed:completionBlock];
            }else{
                
                [self sd_setImageWithURL:[NSURL URLWithString:thumbnailImageUrl] placeholderImage:placeholderImage completed:completionBlock];
            }
        }
        else {
            UIImage *thumbnailImage = [[SDImageCache sharedImageCache]imageFromDiskCacheForKey:thumbnailImageUrl];
            if (thumbnailImage) {
                [self sd_setImageWithURL:[NSURL URLWithString: thumbnailImageUrl] placeholderImage:placeholderImage completed:completionBlock];
            }
            else{
                [self  sd_setImageWithURL:nil placeholderImage:placeholderImage completed:completionBlock];
            }
        }
    }
}

-(void)oy_setOriginalImageUrl:(NSString *)originalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl placeholderImage:(UIImage *)placeholderImage {
    [self oy_setOriginalImageUrl:originalImageUrl thumbnailImageUrl:thumbnailImageUrl placeholderImage:placeholderImage completed:nil];
}

-(void)oy_setOriginalImageUrl:(NSString *)originalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl {
    [self oy_setOriginalImageUrl:originalImageUrl thumbnailImageUrl:thumbnailImageUrl placeholderImage:nil completed:nil];
}


@end
