//
//  OYMeWebVIewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/23.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYMeWebVIewController.h"
#import <WebKit/WebKit.h>

@interface OYMeWebVIewController ()
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
//@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property(nonatomic,weak) WKWebView   *webView;



@end

@implementation OYMeWebVIewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"返回" target:self action:@selector(Back)];
    WKWebView  *webView  = [[WKWebView alloc]init];
    _webView = webView;
    
    [self.view insertSubview:webView atIndex:0];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    [webView loadRequest:request];
    
    [webView addObserver:self  forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    
}


//
//-(void)Back{
//    [self.navigationController popViewControllerAnimated:YES];
//}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    _progress.progress = _webView.estimatedProgress;
    
    _progress.hidden = _progress.progress >=1;
}
-(void)dealloc{
    [self.webView removeObserver:self  forKeyPath:@"estimatedProgress"];
}

@end
