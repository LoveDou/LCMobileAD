//
//  AMError.h
//  AltamobSDKTest
//
//  Created by zjw1 on 2017/1/17.
//  Copyright © 2017年 Altamob. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AMError : NSObject

- (instancetype)initWithHttpCode:(NSInteger)httpCode
                  responseObject:(id)responseObj;

@property (nonatomic, assign) NSInteger errorCode;
@property (nonatomic, assign) NSInteger httpCode;
@property (nonatomic, strong) NSString *errorDescription;
@property (nonatomic, strong) id responseObject;

@end
