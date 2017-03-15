//
//  XXDownloadImg.m
//  XXDownloadImg
//
//  Created by tomxiang on 2017/2/22.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXDownloadImg.h"
#import <UIKit/UIKit.h>


#define URL_BIG_JPG @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1488214524647&di=9bd9c3979119e616f59e58640b14c3b9&imgtype=0&src=http%3A%2F%2Fd.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fd0c8a786c9177f3ecc73d9b671cf3bc79e3d56c1.jpg" //https://pixabay.com/zh/
#define URL_SMALL_JPG @"http://pic55.nipic.com/file/20141208/19462408_171130083000_2.jpg"

@interface XXDownloadImg()<NSURLSessionDataDelegate>
@end

@implementation XXDownloadImg

+ (instancetype)sharedInstance
{
    static XXDownloadImg *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XXDownloadImg alloc] init];
    });
    return sharedInstance;
}

#pragma mark- Download block
- (void)async_sessionDownloadImg{
    //1.会话
    NSURLSession *session = [NSURLSession sharedSession];
    //2.创建任务
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:[NSURL URLWithString:URL_BIG_JPG] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"currentThread--%@",[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
            [self showImage:image];
        });
    }];
    //3.开始任务
    [downloadTask resume];
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
