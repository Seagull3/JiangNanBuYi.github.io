//
//  UIView+Frame.m
//  BuDeJie
//
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)OY_centerX
{
    return self.center.x;
}
- (void)setOY_centerX:(CGFloat)OY_centerX
{
    CGPoint center = self.center;
    center.x = OY_centerX;
    self.center = center;
}

- (CGFloat)OY_centerY
{
    return self.center.y;
}
- (void)setOY_centerY:(CGFloat)OY_centerY
{
    CGPoint center = self.center;
    center.y = OY_centerY;
    self.center = center;
}

- (CGFloat)OY_height
{
    return self.frame.size.height;
}

- (void)setOY_height:(CGFloat)OY_height
{
    CGRect rect = self.frame;
    rect.size.height = OY_height;
    self.frame = rect;
}

- (CGFloat)OY_width
{
    return self.frame.size.width;
}

- (void)setOY_width:(CGFloat)OY_width
{
    CGRect rect = self.frame;
    rect.size.width = OY_width;
    self.frame = rect;

}

- (CGFloat)OY_x
{
    return self.frame.origin.x;
}

- (void)setOY_x:(CGFloat)OY_x
{
    CGRect rect = self.frame;
    rect.origin.x = OY_x;
    self.frame = rect;

}

- (CGFloat)OY_y
{
    return self.frame.origin.y;
}

- (void)setOY_y:(CGFloat)OY_y
{
    CGRect rect = self.frame;
    rect.origin.y = OY_y;
    self.frame = rect;

}
+(instancetype)loadNibName{
    return [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}
@end
