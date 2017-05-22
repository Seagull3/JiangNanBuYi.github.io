//
//  OYSeeBigPictureViewController.m
//  BaiSiBuDeJie
//
//  Created by 江南布衣 on 16/7/1.
//  Copyright © 2016年 江南布衣. All rights reserved.
//

#import "OYSeeBigPictureViewController.h"
#import "OYTopicsItem.h"
#import <SVProgressHUD.h>
#import <Photos/Photos.h>
@interface OYSeeBigPictureViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *savePictureButton;
@property(nonatomic,strong) UIImageView   *imaegView;

- (PHFetchResult<PHAsset *> *)createdAssets;
- (PHAssetCollection *)createdCollection;
@end
@implementation OYSeeBigPictureViewController

-(void)awakeFromNib{
//    self.savePictureButton.hidden = NO;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(back:)];
    scrollView.frame = [UIScreen mainScreen].bounds;
    [scrollView addGestureRecognizer:tap];
    scrollView.backgroundColor = [UIColor darkGrayColor];
    
    [self.view  insertSubview:scrollView atIndex:0];
    
    UIImageView *imageV = [[UIImageView alloc]init];
  

    [imageV oy_setOriginalImageUrl:self.topicItem.image1 thumbnailImageUrl:self.topicItem.image0 placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image == nil) return ;
        self.savePictureButton.enabled = YES;

    }];
    imageV.OY_width = mainScreenW;
    imageV.OY_x = 0 ;
    [scrollView addSubview:imageV];
    self.imaegView = imageV;
    
    imageV.OY_height = imageV.OY_width * self.topicItem.height /self.topicItem.width ;
    
    if (imageV.OY_height >= mainScreenH) { // 长图
        imageV.OY_y = 0;
        scrollView.contentSize = CGSizeMake(0, imageV.OY_height);
    } else {
        imageV.OY_centerY = scrollView.OY_height * 0.5;
    }
    
    
    //解决比例缩放功能
    CGFloat scale = self.topicItem.width / imageV.OY_width;
    if (scale >= 1 ) {
        scrollView.maximumZoomScale =scale;
        scrollView.delegate = self;
        
    }
    
}
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
     return  self.imaegView;
}


- (IBAction)savePicture:(id)sender {
    //第一种方式:  C语言实现  但是无法选择图片到
//    UIImageWriteToSavedPhotosAlbum(self.imaegView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //第二种方式 使用photos 框架
//    
//    PHAuthorizationStatusNotDetermined = 0, // User has not yet made a choice with regards to this application
//    PHAuthorizationStatusRestricted,        // This application is not authorized to access photo data.
//    // The user cannot change this application’s status, possibly due to active restrictions
//    //   such as parental controls being in place.
//    PHAuthorizationStatusDenied,            // User has explicitly denied this application access to photos data.
//    PHAuthorizationStatusAuthorized
    
        PHAuthorizationStatus oldStatus =  [PHPhotoLibrary authorizationStatus];
    
      [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
          dispatch_async(dispatch_get_main_queue(), ^{
              switch (status) {
                  case PHAuthorizationStatusAuthorized:
                      [self saveImageIntoAlbum];
                      break;
                      
                  case PHAuthorizationStatusDenied:
                      if (oldStatus == PHAuthorizationStatusDenied ) {
                          return ;
                      }
                       [SVProgressHUD showErrorWithStatus:@"你需要授权"];
                      break;
                      
                      
                  case PHAuthorizationStatusNotDetermined:
                      if (oldStatus == PHAuthorizationStatusDenied ) {
                          return ;
                      }
                      [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
                      break;

                  default:
                      break;
              }
          });
      }];
    
//    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
//    
//    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            switch (status) {
//                case PHAuthorizationStatusAuthorized: {
//                    //  保存图片到相册
//                  [self saveImageIntoAlbum];
//                    break;
//                }
//                    
//                case PHAuthorizationStatusDenied: {
//                    if (oldStatus == PHAuthorizationStatusNotDetermined) return;
//                    
//             
//                    break;
//                }
//                    
//                case PHAuthorizationStatusRestricted: {
//                    [SVProgressHUD showErrorWithStatus:@"因系统原因，无法访问相册！"];
//                    break;
//                }
//                    
//                default:
//                    break;
//            }
//        });
//    }];
//
   
    
}
//- (PHFetchResult<PHAsset *> *)createdAssets{
//    
//}
- (PHFetchResult<PHAsset *> *)createdAssets{
    
    
   __block NSString *CreatedAssetID = nil;
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
         CreatedAssetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imaegView.image].placeholderForCreatedAsset.localIdentifier;
    } error:nil];
       if (CreatedAssetID == nil ) return nil;
        return   [PHAsset fetchAssetsWithLocalIdentifiers:@[CreatedAssetID] options:nil];
   
    
 
    
}
//- (PHAssetCollection *)createdCollection{
//    
//}
//新建自定义相册
- (PHAssetCollection *)createdCollection{
    
   NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    //获取所有的相册
   PHFetchResult<PHAssetCollection *> *collections=  [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    for (PHAssetCollection *collection  in collections) {
        if ([collection.localIdentifier isEqualToString:title])
            return nil;
    }
 //来到这里说明没有创建自定义相册
   __block NSString *collectionId = nil;
    
    //创建自定义相册
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        collectionId =[PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;

    } error:nil];
        
    if (collectionId == nil ) return  nil;
    return  [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}


//将图片添加到自定义相册中

-(void)saveImageIntoAlbum{
    //获取相册和图片
    PHFetchResult<PHAsset *> *createdAssets  = self.createdAssets;
    PHAssetCollection *createdCollection = self.createdCollection;
    if (createdAssets == nil || createdCollection == nil) {
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
        return;
    }
    //来到这里说明两者都有值
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        
        
          PHAssetCollectionChangeRequest *request =   [PHAssetCollectionChangeRequest  changeRequestForAssetCollection:createdCollection];
        
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];

    } error:&error ];
    
    if (error == nil) {
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }else{
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
         [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
    else{
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    }
}

- (IBAction)back:(id)sender {
    
    [self  dismissViewControllerAnimated:YES completion:nil];
    
}



//
//#import <Photos/PHPhotoLibrary.h>
//#import <Photos/PhotosTypes.h>
//

//#import <Photos/PHAsset.h>

//
//#import <Photos/PHFetchOptions.h>
//#import <Photos/PHFetchResult.h>

//#import <Photos/PHAssetChangeRequest.h>
//#import <Photos/PHAssetCreationRequest.h>
//#import <Photos/PHAssetCollectionChangeRequest.h>
//#import <Photos/PHCollectionListChangeRequest.h>
//
//#import <Photos/PHImageManager.h>
//
//#import <Photos/PHAssetResourceManager.h>
//#import <Photos/PHAssetResource.h>

@end
