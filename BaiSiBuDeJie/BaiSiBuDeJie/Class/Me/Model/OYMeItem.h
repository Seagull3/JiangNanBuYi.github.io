//
//  OYMeItem.h
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/23.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OYMeItem : NSObject
/**标题 */
@property (nonatomic, copy) NSString *name;
/**图片 */
@property (nonatomic, copy) NSString *icon;
/** 跳转的地址*/
@property (nonatomic, copy) NSString *url;
@end
