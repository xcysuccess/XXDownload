//
//  XXDownload.h
//  XXDownload
//
//  Created by tomxiang on 2017/2/22.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXDownload : NSObject

+ (instancetype)sharedInstance;

/**
 NSURLConnection with sync
 */
- (void)sync_connection;

/**
 NSURLConnection with async block
 */
- (void)async_connectionWithCompletion:(void (^)())completion;

/**
 NSURLConnection with async delegate
 */
- (void)async_connectionWithDelegate;

/**
 NSURLSessionDataTask
 */
- (void)async_sessionDataTaskGet;

- (void)async_sessionDataTaskPost;

@end
