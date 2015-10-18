//
//  IWBaseTool.h
//  Weibo16
//
//  Created by 0426iOS on 15/8/3.
//  Copyright (c) 2015年 0426iOS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IWBaseTool : NSObject


/**
 *  get方法获取数据,传入class,会自动把返回数据转成对应的class模型
 *
 *  @param url     请求地址
 *  @param params  参数
 *  @param clazz   类-->这个参数就标明了这个方法请求成功之后返回什么类型的模型
 *  @param success 成功之后回调
 *  @param failure 失败回调
 */
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params class:(Class)clazz success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  post方法获取数据,传入class,会自动把返回数据转成对应的class模型
 *
 *  @param url     请求地址
 *  @param params  参数
 *  @param clazz   类-->这个参数就标明了这个方法请求成功之后返回什么类型的模型
 *  @param success 成功之后回调
 *  @param failure 失败回调
 */
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params class:(Class)clazz success:(void(^)(id responseObject))success failure:(void (^)(NSError *error))failure;

@end
