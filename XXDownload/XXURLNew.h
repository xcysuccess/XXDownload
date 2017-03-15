//
//  XXURLNew.h
//  XXDownload
//
//  Created by tomxiang on 2017/3/15.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXURLNew : NSObject

+ (instancetype)sharedInstance;
/**
 NSURLSessionDataTask
 */
- (void)async_sessionDataTaskGet;

- (void)async_sessionDataTaskPost;

- (void)async_sessionDataTaskPostDelegate;

@end
