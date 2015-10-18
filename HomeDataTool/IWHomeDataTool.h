//
//  IWHomeDataTool.h
//  Weibo16
//
//  Created by 0426iOS on 15/8/3.
//  Copyright (c) 2015年 0426iOS. All rights reserved.
//  保存了一系列首页获取数据的方法

#import <Foundation/Foundation.h>
#import "IWBaseTool.h"
@class IWStatusRes,IWUnReadCount;

@interface IWHomeDataTool : IWBaseTool

/**
 *  获取首页微博数据
 *
 *  @param accessToken <#accessToken description#>
 *  @param sinceId     <#sinceId description#>
 *  @param count       <#count description#>
 *  @param clazz       <#clazz description#>
 *  @param success     <#success description#>
 *  @param failure     <#failure description#>
 */
+ (void)getStatusWithSinceId:(long long)sinceId maxId:(long long)maxId count:(NSInteger)count success:(void(^)(IWStatusRes *responseObject))success failure:(void (^)(NSError *error))failure;

/**
 *  获取未读消息
 *
 *  @param uid     用户的uid
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)getUnReadCountUid:(NSString *)uid success:(void(^)(IWUnReadCount *responseObject))success failure:(void (^)(NSError *error))failure;






@end
