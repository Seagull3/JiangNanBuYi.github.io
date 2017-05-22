//
//  OYVoiceViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/24.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYVoiceViewController.h"
#import "OYTopicsItem.h"

@interface OYVoiceViewController ()


@end

@implementation OYVoiceViewController
-(NSNumber *)type{
    return  @(OYTopicsItemTypeVoice);
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    

}


@end
