//
//  IWHttpTool.m
//  Weibo16
//
//  Created by 0426iOS on 15/8/3.
//  Copyright (c) 2015年 0426iOS. All rights reserved.
//

#import "IWHttpTool.h"
#import "AFNetworking.h"

@implementation IWHttpTool

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    //使用afn原生的网络请求
    
    //NSLog(@"%@",url);
    //NSLog(@"%@",params);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //发送get请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSLog(@"response=%@",responseObject);
        //加载成功,把数据回调回去
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    
    //NSLog(@"%@",url);
    //NSLog(@"%@",params);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //发送get请求
    
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //加载成功,把数据回调回去
        //NSLog(@"response=%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}






@end
