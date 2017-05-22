//
//  OYADItem.h
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/21.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OYADItem : NSObject
/** 广告图片*/
@property (nonatomic ,strong) NSString *w_picurl;
/** 广告界面跳转地址*/
@property (nonatomic ,strong) NSString *ori_curl;
@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@end
