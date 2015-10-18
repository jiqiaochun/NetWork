//
//  IWComposeDataTool.h
//  Weibo16
//
//  Created by 0426iOS on 15/8/9.
//  Copyright (c) 2015年 0426iOS. All rights reserved.
//

#import "IWBaseTool.h"
@class IWStatus;

@interface IWComposeDataTool : IWBaseTool


/**
 *  发表文字微博
 *
 *  @param content 发送的内容
 *  @param success
 *  @param failure
 */
+ (void)sendStatusWithContent:(NSString *)content success:(void(^)(IWStatus *responseObject))success failure:(void (^)(NSError *error))failure;
@end
