//
//  IWHttpTool.h
//  Weibo16
//
//  Created by 0426iOS on 15/8/3.
//  Copyright (c) 2015年 0426iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWHttpTool : NSObject

/**
 *  get方法请求网络数据
 *
 *  @param url     请求地址
 *  @param params  参数<字典类型>
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  post方法请求网络数据
 *
 *  @param url     请求地址
 *  @param params  参数<字典类型>
 *  @param success 成功的回调
 *  @param failure 失败的回调
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;


@end
