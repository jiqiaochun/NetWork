//
//  IWBaseTool.m
//  Weibo16
//
//  Created by 0426iOS on 15/8/3.
//  Copyright (c) 2015年 0426iOS. All rights reserved.
//

#import "IWBaseTool.h"
#import "AFNetworking.h"
#import "IWHttpTool.h"
#import "MJExtension.h"

@implementation IWBaseTool

+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params class:(Class)clazz success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
 
    [IWHttpTool getWithUrl:url params:params success:^(id responseObject) {
        if (success) {
            //得到网络数据
            
            //字典转模型
            id result = [[clazz alloc] init];
            [result setKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        //字典转模型
//        id result = [[clazz alloc] init];
//        [result setKeyValues:responseObject];
//        
//        if (success) {
//            success(result);
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        if (failure) {
//            failure(error);
//        }
//    }];
}

+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params class:(Class)clazz success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure{
    [IWHttpTool postWithUrl:url params:params success:^(id responseObject) {
        if (success) {
            //字典转模型
            id result = [[clazz alloc] init];
            [result setKeyValues:responseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

@end
