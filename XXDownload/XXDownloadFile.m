//
//  XXDownloadFile.m
//  XXDownload
//
//  Created by tomxiang on 2017/3/15.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import "XXDownloadFile.h"
#import <UIKit/UIKit.h>

#define DOWNLOAD_URL @"http://sqdownb.onlinedown.net/down/Photoshop_12_LS3.zip"

@interface XXDownloadFile()<NSURLSessionDownloadDelegate>
@property(nonatomic,strong) NSURLSessionDownloadTask *task;
@property(nonatomic,strong) NSData *resumedata;
@property(nonatomic,strong) NSURLSession *session;
@end


@implementation XXDownloadFile

+ (instancetype)sharedInstance
{
    static XXDownloadFile *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[XXDownloadFile alloc] init];
    });
    return sharedInstance;
}

#pragma mark- Download Delegate
-(NSURLSession *)session{
    if(!_session){
        // 创建会话
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _session;
}
- (void)startDownloadFile{
    // 下载任务
    self.task = [self.session downloadTaskWithURL:[NSURL URLWithString:DOWNLOAD_URL]];
    
    [self.task resume];
}

- (void)pauseDownloadFile{
    if(self.task){
        //任务可以恢复
//        [self.task suspend];
        
        //不可以恢复任务
        __weak typeof(self) weakSelf = self;
        [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            //表示当前下载了多少数据
            self.resumedata = resumeData;
            weakSelf.task = nil;
        }];
    }
}

- (void)resumeDownloadFile{
    self.task = [self.session downloadTaskWithResumeData:self.resumedata];
        
    [self.task resume];
}

/* Sent when a download task that has completed a download.  The delegate should
 * copy or move the file at the given location to a new location as it will be
 * removed when the delegate message returns. URLSession:task:didCompleteWithError: will
 * still be called.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    NSLog(@"location:%@",[location absoluteString]);
}

/* Sent periodically to notify the delegate of download progress. */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"currentProgress:%lf",1.f*totalBytesWritten / totalBytesExpectedToWrite);
}

/* Sent when a download has been resumed. If a download failed with an
 * error, the -userInfo dictionary of the error will contain an
 * NSURLSessionDownloadTaskResumeData key, whose value is the resume
 * data.
 */
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{
    NSLog(@"%s",__func__);
}
/* Sent as the last message related to a specific task.  Error may be
 * nil, which implies that no error occurred and this task is complete.
 */
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error{
    if(self.task){
        [self.task suspend];
    }
}
@end
