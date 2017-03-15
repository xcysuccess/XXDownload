//
//  XXDownloadImg.h
//  XXDownloadImg.h
//
//  Created by tomxiang on 2017/2/22.
//  Copyright © 2017年 tomxiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XXDownloadFile.h"

@interface XXDownloadImg : NSObject

+ (instancetype)sharedInstance;

- (void)async_sessionDownloadImg;

@end
