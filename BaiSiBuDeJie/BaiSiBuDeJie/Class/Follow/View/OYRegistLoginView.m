//
//  OYRegistLoginView.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/22.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYRegistLoginView.h"
@interface OYRegistLoginView()
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;



@end

@implementation OYRegistLoginView

+(instancetype)registLoginView{
    return [[[NSBundle mainBundle]loadNibNamed:@"OYRegistLoginView" owner:nil options:nil] firstObject];
}
+(instancetype)registView{
    return [[[NSBundle mainBundle]loadNibNamed:@"OYRegistLoginView" owner:nil options:nil] lastObject];
}
-(void)awakeFromNib{
    UIImage *image = self.loginBtn.currentBackgroundImage;
    
    
    image = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
    [self.loginBtn setBackgroundImage:image forState:UIControlStateNormal];
    
//    self.loginBtn setBackgroundImage:<#(nullable UIImage *)#> forState:<#(UIControlState)#>
}

@end
