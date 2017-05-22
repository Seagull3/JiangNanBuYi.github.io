//
//  OYTopicCell.h
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/29.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OYTopicsItem;
@class OYTopicCell;
@protocol oYTopicCellDelegate <NSObject>

-(void)playBtnclick:(OYTopicCell *)cell;


@end
@interface OYTopicCell : UITableViewCell
/**
 *  模型
 */
@property(nonatomic,strong)OYTopicsItem  *topicItem;
@property(nonatomic,weak) id<oYTopicCellDelegate>   delegate;



@end
