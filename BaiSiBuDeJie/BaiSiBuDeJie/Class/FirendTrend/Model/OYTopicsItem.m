//
//  OYTopicsItem.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/26.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYTopicsItem.h"


@implementation OYTopicsItem

-(CGFloat)cellHeight{
    
    if (_cellHeight) return _cellHeight;
    
    //计算文字用户图片的高度
    _cellHeight += 50 + OYMargain;
    
    //计算lable的高度
    _cellHeight +=[self.text boundingRectWithSize:CGSizeMake(mainScreenW- 2 * OYMargain , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height + OYMargain;
    
  
    
    //中间内容的高度
    if (self.type != OYTopicsItemTypeWord) {
        CGFloat X = OYMargain;
        CGFloat Y = _cellHeight;
        CGFloat W = mainScreenW - 2*OYMargain;
        
            
        CGFloat H = 1.0 * W * self.height / self.width;
        if ( H > mainScreenH) {
            self.bigImage = YES;
            H = mainScreenH * 0.3;
        }
        
        self.frame = CGRectMake(X, Y, W, H);
        
        _cellHeight += H;
    }
    
    //添加最热评论
    if (self.top_cmt.count) {
        _cellHeight += 21;
        
        NSString *TextString = [NSString stringWithFormat:@"%@ : %@",self.top_cmt.firstObject[@"user"][@"username"],self.top_cmt.firstObject[@"content"]];
        _cellHeight +=[TextString  boundingRectWithSize:CGSizeMake(mainScreenW- 2 * OYMargain , MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.height + OYMargain;
    }
    // 底部按钮的高度
    _cellHeight += 40 +OYMargain;
    return _cellHeight;
}


@end
