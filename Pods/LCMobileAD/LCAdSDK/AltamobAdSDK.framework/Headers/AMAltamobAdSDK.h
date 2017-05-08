//
//  AMAltamobAdSDK.h
//  AltamobSDK
//
//  Created by zjw1 on 2017/1/6.
//  Copyright © 2017年 Altamob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMAltamobAdSDK : NSObject

+ (instancetype)shareInstance;

- (void)resgistWithAppkey:(NSString *)appkey;

@property(nonatomic, copy, readonly) NSString *appKey;

@property (nonatomic, assign) BOOL debugEable;

@end
