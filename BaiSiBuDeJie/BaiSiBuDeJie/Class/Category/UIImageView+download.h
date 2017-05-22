//
//  UIImageView+download.h
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/7/1.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>

@interface UIImageView (download)
/**
 *  没有占位图片 完成之后做事的
 *
 *  @param originalImageUrl  高清图
 *  @param thumbnailImageUrl 缩略图
 *  @param  completed   完成之后做的事
 */
-(void)oy_setOriginalImageUrl:(NSString *)originalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl  completed:(SDWebImageCompletionBlock)completedBlock;
/**
 *  有占位图 完成之后做事
 *
 *  @param originalImageUrl  高清图
 *  @param thumbnailImageUrl 缩略图
 *  @param placeholderImage  占位图片
 *  @param  completed   完成之后做的事
 */
-(void)oy_setOriginalImageUrl:(NSString *)originalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl placeholderImage:(UIImage *)placeholderImage completed:(SDWebImageCompletionBlock)completionBlock ;
/**
 *  有占位图但完成之后不做事
 *
 *  @param originalImageUrl  高清图
 *  @param thumbnailImageUrl 缩略图
 *  @param placeholderImage  占位图片
 */
-(void)oy_setOriginalImageUrl:(NSString *)originalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl placeholderImage:(UIImage *)placeholderImage;
/**
 *  只设高清图片 和缩略图
 *
 *  @param originalImageUrl  高清图
 *  @param thumbnailImageUrl 缩略图
 */
-(void)oy_setOriginalImageUrl:(NSString *)originalImageUrl thumbnailImageUrl:(NSString *)thumbnailImageUrl ;
@end
