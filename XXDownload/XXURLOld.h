//
//  XXURLOld.h
//  XXDownload
//
//  Created by tomxiang on 2017/3/15.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXURLOld : NSObject

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

@end
