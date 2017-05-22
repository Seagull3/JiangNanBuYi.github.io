//
//  OYFollowViewCell.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/23.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYFollowViewCell.h"
#import <UIImageView+WebCache.h>
#import "OYFollowItem.h"

@interface OYFollowViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UILabel *numL;

@end


@implementation OYFollowViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItem:(OYFollowItem *)item{
    _item = item;
    
    //设置圆角
//    self.imageV.layer.cornerRadius = self.imageV.bounds.size.width * 0.5;
//    self.imageV.clipsToBounds = YES;
    
    
    if ([item.image_list isEqualToString: @""] ) {
        self.imageV.image = [UIImage imageNamed:@"header_cry_icon"];
    }
    else{
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:item.image_list] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            UIGraphicsBeginImageContextWithOptions(self.imageV.bounds.size, NO, 0);
            
            UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:self.imageV.bounds];
            [path addClip];
            
            [self.imageV.image drawInRect:self.imageV.bounds];
            
            
            self.imageV.image = UIGraphicsGetImageFromCurrentImageContext();
            
            UIGraphicsEndImageContext();
            
        }];
    }
   
    self.titleL.text = item.theme_name;
    
    NSInteger str = [item.sub_number integerValue];
    
    if (str  > 10000) {
        self.numL.text =[NSString stringWithFormat:@"%.1f万人",str/10000.0];
    }
    else{
    self.numL.text = [NSString stringWithFormat:@"%zd人",str];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
