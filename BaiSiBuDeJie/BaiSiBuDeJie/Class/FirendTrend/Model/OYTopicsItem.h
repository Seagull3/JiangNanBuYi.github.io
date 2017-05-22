//
//  OYTopicsItem.h
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/6/26.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import <Foundation/Foundation.h>
//网络类型  1为全部，10为图片，29为段子，31为音频，41为视频，默认为1
typedef NS_ENUM(NSInteger,OYTopicsItemType) {
    /** *所有*/
    OYTopicsItemTypeAll = 1,
    /** *图片*/
    OYTopicsItemTypePicture = 10,
    /** *视频*/
    OYTopicsItemTypeVideos = 41,
      /** *音频*/
    OYTopicsItemTypeVoice  = 31,
      /** *段子*/
    OYTopicsItemTypeWord  = 29
    
};
@interface OYTopicsItem : NSObject

/** 用户的名字 */
@property (nonatomic, copy) NSString *name;
/** 用户的头像 */
@property (nonatomic, copy) NSString *profile_image;
/** 帖子的文字内容 */
@property (nonatomic, copy) NSString *text;
/** 帖子审核通过的时间 */
@property (nonatomic, copy) NSString *created_at;
/** 顶数量 */
@property (nonatomic, assign) NSInteger ding;
/** 踩数量 */
@property (nonatomic, assign) NSInteger cai;
/** 转发\分享数量 */
@property (nonatomic, assign) NSInteger repost;
/** 评论数量 */
@property (nonatomic, assign) NSInteger comment;
/**
 *  类型
 */
@property(nonatomic,assign) NSInteger  type;

/**
 *  宽度
 */
@property(nonatomic,assign) NSInteger  width;
/**
 *  高度
 */
@property(nonatomic,assign) NSInteger  height;

/**缩略图 */
@property (nonatomic, copy) NSString *image0;
/**大图 */
@property (nonatomic, copy) NSString *image1;
/**中图 */
@property (nonatomic, copy) NSString *image2;
/**视屏播放地址 */
@property (nonatomic, copy) NSString *videouri;
/**音频播放地址 */
@property (nonatomic, copy) NSString *voiceuri;
/**视频播放时间 */
@property (nonatomic, copy) NSString *videotime;
/**音频播放时间 */
@property (nonatomic, copy) NSString *voicetime;
/**播放次数 */
@property (nonatomic, copy) NSNumber *playcount;

/**判断是否是动图 */
//@property (nonatomic, copy) NSString *is_gif;
/**判断是否是动图 */
@property (nonatomic, assign) BOOL is_gif;

/**
 *  额外增加的属性 (方便开发)
 */
/**判断是否是动图 */
@property (nonatomic, assign ,getter=isBigImage)BOOL bigImage;
/**
 *  获取cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;
/**
 *  最热评论
 */
@property(nonatomic,strong)NSArray  *top_cmt;


/**
 *  frame
 */
@property(nonatomic,assign) CGRect  frame;

@end
