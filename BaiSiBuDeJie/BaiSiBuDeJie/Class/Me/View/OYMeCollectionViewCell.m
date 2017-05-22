//
//  OYMeCollectionViewCell.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/23.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYMeCollectionViewCell.h"
#import <UIImageView+WebCache.h>
#import "OYMeItem.h"
@interface OYMeCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end

@implementation OYMeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setItem:(OYMeItem *)item{
    _item = item;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.icon]];
    self.titleL.text = item.name;
    
}

@end
