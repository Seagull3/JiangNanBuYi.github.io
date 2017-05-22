//
//  OYTopicCell.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/29.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYTopicCell.h"
#import "OYTopicsItem.h"
#import <UIImageView+WebCache.h>

#import "OYTopicVoiceView.h"
#import "OYTopicPictureView.h"
#import "OYTopicVideosView.h"


@interface OYTopicCell ()

/**
 *  内容的文本
 */
@property (weak, nonatomic) IBOutlet UILabel *text_Lable;
/**
 *  用户的头像
 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/**
 *  用户的名字
 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**
 *  审核时间
 */
@property (weak, nonatomic) IBOutlet UILabel *passtimeLabel;
/**
 *  顶的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/**
 * 踩的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/**
 *  转发的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *repostButton;

///** 用户的名字 */
//@property (nonatomic, copy) NSString *name;
///** 用户的头像 */
//@property (nonatomic, copy) NSString *profile_image;
///** 帖子的文字内容 */
//@property (nonatomic, copy) NSString *text;
///** 帖子审核通过的时间 */
//@property (nonatomic, copy) NSString *created_at;
///** 顶数量 */
//@property (nonatomic, assign) NSInteger ding;
///** 踩数量 */
//@property (nonatomic, assign) NSInteger cai;
///** 转发\分享数量 */
//@property (nonatomic, assign) NSInteger repost;
///** 评论数量 */
//@property (nonatomic, assign) NSInteger comment;
/**
 *  评论的按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *top_cmtLabel;

@property (weak, nonatomic) IBOutlet UIView *top_cmtView;

/**
 *  pictureView
 */
@property(nonatomic,strong)OYTopicVoiceView  *voiceView;
@property(nonatomic,strong)OYTopicVideosView  *videosView;
@property(nonatomic,strong)OYTopicPictureView  *pictureView;
@end

@implementation OYTopicCell


#pragma mark -------------------
#pragma mark 添加高度

-(void)awakeFromNib{
    self.backgroundColor = OYColor(215, 215, 215);
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
//    [self addGestureRecognizer:tap];
    
    [self.videosView.playButton addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    [self.voiceView.mp3Player addTarget:self action:@selector(tapClick) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)tapClick {
    
    NSLog(@"%s",__func__);
    if ([self.delegate respondsToSelector:@selector(playBtnclick:)]) {
        [self.delegate playBtnclick:self];
    }
}

#pragma mark -------------------
#pragma mark 懒加载
-(OYTopicVoiceView *)voiceView{
    if (_voiceView == nil) {
        OYTopicVoiceView *voiceView = [OYTopicVoiceView loadNibName];
        
        [self.contentView addSubview:voiceView];
        
        _voiceView = voiceView;
    }
    return _voiceView;
}
-(OYTopicPictureView *)pictureView{
    if (_pictureView == nil) {
        OYTopicPictureView *pictureView = [OYTopicPictureView loadNibName];
        [self.contentView addSubview:pictureView];
        
        _pictureView = pictureView;
    }
    return  _pictureView;
}
-(OYTopicVideosView *)videosView{
    if (_videosView == nil) {
        OYTopicVideosView *videosView =  [OYTopicVideosView loadNibName];
        
        [self.contentView addSubview:videosView];
        
        _videosView = videosView;
    }
    return _videosView;
}






#pragma mark -------------------
#pragma mark 设置数据
-(void)setTopicItem:(OYTopicsItem *)topicItem{
    
    _topicItem = topicItem;
    
    
    //顶部内容
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topicItem.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    self.nameLabel.text = topicItem.name;
    self.passtimeLabel.text = topicItem.created_at;
    
    //底部内容
    [self button:self.dingButton count:topicItem.ding placeholder:@"顶"];
    [self button:self.caiButton count:topicItem.cai placeholder:@"踩"];
    [self button:self.repostButton count:topicItem.repost placeholder:@"转发"];
    [self button:self.commentButton count:topicItem.comment placeholder:@"评论"];
    //最热评论的内容
    self.text_Lable.text = topicItem.text;
    if (topicItem.top_cmt.count) {
        self.top_cmtView.hidden = NO;
        self.top_cmtLabel.text = [NSString stringWithFormat:@"%@ : %@",topicItem.top_cmt.firstObject[@"user"][@"username"],topicItem.top_cmt.firstObject[@"content"]];
    }else{
        self.top_cmtView.hidden = YES;
    }
//    中间的内容
    switch (topicItem.type) {
        case  OYTopicsItemTypePicture:
            self.pictureView.hidden = NO;
            self.videosView.hidden = YES;
            self.voiceView.hidden = YES;
            break;
            
        case  OYTopicsItemTypeVideos:
            self.pictureView.hidden = YES;
            self.videosView.hidden = NO;
            self.voiceView.hidden = YES;
            break;
            
        case  OYTopicsItemTypeVoice:
            self.pictureView.hidden = YES;
            self.videosView.hidden = YES;
            self.voiceView.hidden = NO;
            break;
        case  OYTopicsItemTypeWord:
            self.pictureView.hidden = YES;
            self.videosView.hidden = YES;
            self.voiceView.hidden = YES;
            
            break;
    }
    
    
}

///** *所有*/
//OYTopicsItemTypeAll = 1,
///** *图片*/
//OYTopicsItemTypePicture = 10,
///** *视频*/
//OYTopicsItemTypeVideos = 41,
///** *音频*/
//OYTopicsItemTypeVoice  = 31,
///** *段子*/
//OYTopicsItemTypeWord  = 29
//网络类型  1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
-(void)layoutSubviews{
    
    [super layoutSubviews];
    switch (self.topicItem.type) {
        case  OYTopicsItemTypePicture:
            self.pictureView.frame = self.topicItem.frame;
            self.pictureView.topicItem = self.topicItem;
            break;
            
        case  OYTopicsItemTypeVideos:
             self.videosView.frame = self.topicItem.frame;
            self.videosView.topicItem = self.topicItem;
            break;
            
        case  OYTopicsItemTypeVoice:
          self.voiceView.frame = self.topicItem.frame;
        self.voiceView.topicItem = self.topicItem;
            
            break;
            
        default:
            break;
    }
    
}
-(void)button:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder{
    if ( count > 10000) {
        [button setTitle:[NSString stringWithFormat:@"%.1f万",count / 10000.0] forState:UIControlStateNormal];
    }else if(count > 0 ){
        [button setTitle:[NSString stringWithFormat:@"%zd",count] forState:UIControlStateNormal];
    }
    else{
        [button setTitle:placeholder forState:UIControlStateNormal];
    }

}

-(void)setFrame:(CGRect)frame{
    
    frame.size.height -= OYMargain;
//    self.topicItem.cellHeight -=OYMargain;
    [super setFrame:frame];
}
@end
