//
//  XXDownloadFile.h
//  XXDownload
//
//  Created by tomxiang on 2017/3/15.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXDownloadFile : NSObject

+ (instancetype)sharedInstance;

- (void)startDownloadFile;

- (void)pauseDownloadFile;

- (void)resumeDownloadFile;

@end
