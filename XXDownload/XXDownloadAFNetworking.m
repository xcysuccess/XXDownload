//
//  XXDownloadAFNetworking.m
//  XXDownload
//
//  Created by tomxiang on 2017/3/29.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXDownloadAFNetworking.h"
#import <AFNetworking/AFNetworking.h>

#define DOWNLOAD_URL @"http://sqdownb.onlinedown.net/down/Photoshop_12_LS3.zip"

#define URL_BIG_JPG @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488214524647&di=9bd9c3979119e616f59e58640b14c3b9&imgtype=0&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fd0c8a786c9177f3ecc73d9b671cf3bc79e3d56c1.jpg" //https://pixabay.com/zh/
#define URL_SMALL_JPG @"http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg"

@implementation XXDownloadAFNetworking

+ (instancetype)sharedInstance
{
    static XXDownloadAFNetworking *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XXDownloadAFNetworking alloc] init];
    });
    return sharedInstance;
}

#pragma mark- Download Delegate
- (void)downloadImg{
    //1.定义一个管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //download
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL_BIG_JPG]];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"当前的进度：%lf",downloadProgress.completedUnitCount*1.f / downloadProgress.totalUnitCount);

    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"--targetPath->%@",response);
        
        //选择放置路径
        NSString *location = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:location];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"filePath=%@",filePath);
        NSLog(@"error=%@",error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:filePath]];
            [self showImage:image];
        });
    }];
    
    [task resume];
}

-(void) showImage:(UIImage*) image{
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:@"图片下载成功" message:nil
                                                   delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
#pragma clang diagnostic pop
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, 40, 40)];
    imageView.image = image;
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        [Alert setValue:imageView forKey:@"accessoryView"];
    }else{
        [Alert addSubview:imageView];
    }
    
    [Alert show];
}
@end
