//
//  IWComposeDataTool.m
//  Weibo16
//
//  Created by 0426iOS on 15/8/9.
//  Copyright (c) 2015年 0426iOS. All rights reserved.
//

#import "IWComposeDataTool.h"
#import "IWAccountTool.h"
#import "IWAccount.h"
#import "IWStatus.h"

@implementation IWComposeDataTool

+ (void)sendStatusWithContent:(NSString *)content success:(void(^)(IWStatus *responseObject))success failure:(void (^)(NSError *error))failure{
    NSString *urlStr = @"https://api.weibo.com/2/statuses/update.json";
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [IWAccountTool account].access_token;
    params[@"status"] = content;
    
    [self postWithUrl:urlStr params:params class:[IWStatus class] success:success failure:failure];
}


@end
