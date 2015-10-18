//
//  IWHomeDataTool.m
//  Weibo16
//
//  Created by 0426iOS on 15/8/3.
//  Copyright (c) 2015年 0426iOS. All rights reserved.
//

#import "IWHomeDataTool.h"
#import "IWBaseTool.h"
#import "IWStatusRes.h"
#import "IWAccount.h"
#import "IWAccountTool.h"
#import "IWBaseParams.h"
#import "MJExtension.h"
#import "IWHttpTool.h"
#import "IWStatus.h"


static FMDatabase  *_dataBase;

@implementation IWHomeDataTool
//1.创建数据库 指定数据库的路径  一次

//2.创建表 字段 (id(主键),idstr(微博表示),二进制微博字典,accessToken);
//微博字典(二进制)  id(唯一标示主键)  idstr(微博ID)  user1 user2  accessToken

//3.插入 保存
//4.查询 从本地获取(符合条件情况)

+(void)initialize
{
    
    //1.创建数据库 指定数据库的路径  一次
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject]stringByAppendingPathComponent:@"test.sqlite"];
    _dataBase = [FMDatabase databaseWithPath:path];
    NSLog(@"%@",path);
    BOOL success =  [_dataBase open];
    if (success) {
        NSLog(@"创建数据库成功!");
        //2.创建表 字段 ()
        //(id(主键),idstr(微博标识),二进制微博字典,accessToken)
        
        //2.创建表
        NSString *str = @"CREATE TABLE IF NOT EXISTS t_statuses(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, idstr TEXT NOT NULL, dict BLOB NOT NULL, access_token TEXT NOT NULL);";
        if ([_dataBase executeUpdate:str]) {
            NSLog(@"表创建成功!");
        }else{
            NSLog(@"创建表失败!");
        }
    }else{
        NSLog(@"创建数据库失败!");
    }
}
/**
 * insert
 *
 *  @param dict <#dict description#>
 */
+ (void)saveWithDict:(NSDictionary *)dict
{

    NSString *idstr = dict[@"idstr"];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:NULL];
    
    BOOL success = [_dataBase executeUpdate:@"INSERT INTO t_statuses(idstr, dict, access_token) VALUES(?,?,?);",idstr,data, [[IWAccountTool account]access_token]];
    
    if (success) {
        NSLog(@"添加成功!");
    }else{
        NSLog(@"添加失败!");
    }
}
/**
 *  实现  获取完 都是模型并且返回一个数组
 */
+ (NSArray *)statusWithParams:(NSDictionary *)params
{
    NSString *sql = nil;
    //上拉加载更多 (max_id) 下拉刷新 (since_id)  第一次启动
    if ([params[@"since_id"] longLongValue] != 0) { //下拉刷新 (since_id)
        sql = [NSString stringWithFormat:@"SELECT * FROM t_statuses WHERE idstr > %@ AND access_token = '%@' ORDER BY idstr DESC LIMIT 20;",params[@"since_id"],[[IWAccountTool account]access_token]];
        
    }else if ([params[@"max_id"] longLongValue] != 0){//上拉加载更多 (max_id)
        sql = [NSString stringWithFormat:@"SELECT * FROM t_statuses WHERE idstr <= %@ AND access_token = '%@' ORDER BY idstr DESC LIMIT 20;",params[@"max_id"],[[IWAccountTool account]access_token]];
        
    }else{
         sql = [NSString stringWithFormat:@"SELECT * FROM t_statuses WHERE access_token = '%@' ORDER BY idstr DESC LIMIT 20;",[[IWAccountTool account]access_token]];
        
    }
    FMResultSet *set =  [_dataBase executeQuery:sql];
    NSMutableArray *arrayM = [NSMutableArray array];
    
    while ([set next]) {
        //微博
      NSData *data = [set dataForColumn:@"dict"];
    
      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
       
     IWStatus *status = [IWStatus objectWithKeyValues:dict];
    
    [arrayM addObject:status];
        
    }
    return arrayM;
}
+ (void)getStatusWithSinceId:(long long)sinceId maxId:(long long)maxId count:(NSInteger)count success:(void(^)(IWStatusRes *responseObject))success failure:(void (^)(NSError *error))failure{

    NSString *urlStr = @"https://api.weibo.com/2/statuses/friends_timeline.json";
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [IWAccountTool account].access_token;
    params[@"count"] = @(count);
    params[@"since_id"] = @(sinceId);
    params[@"max_id"] = @(maxId);

    //4.先从本地获取微博数据   查询数据库
    //上拉加载更多 (max_id) 下拉刷新 (since_id)  第一次启动
    NSArray *allData =  [self statusWithParams:params];
    //查询数据库有没有符合条件的数据
    if (allData.count > 0) {
        //返回数据显示到界面上
        if (success) {
            IWStatusRes *res = [[IWStatusRes alloc]init];
            res.statuses = allData;
            success(res);
        }
    }else{
        //本地没有  加载网络的
       
        [IWHttpTool getWithUrl:urlStr params:params success:^(id responseObject) {
            if (success) {
                //得到网络数据
                //3.得到数据 显示界面上   保存
                //NSLog(@"responseObject = %@",responseObject);
                for (NSDictionary *dict in responseObject[@"statuses"]) {
                    [self saveWithDict:dict];
                }
                //字典转模型
                id result = [[IWStatusRes alloc] init];
                [result setKeyValues:responseObject];
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];

    }
   
    
    //[self getWithUrl:urlStr params:params class:[IWStatusRes class] success:success failure:failure];
}

+ (void)getUnReadCountUid:(NSString *)uid success:(void(^)(IWUnReadCount *responseObject))success failure:(void (^)(NSError *error))failure{
    NSString *urlStr = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    //参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [IWAccountTool account].access_token;
    params[@"uid"] = uid;
    
    [self getWithUrl:urlStr params:params class:[IWStatusRes class] success:success failure:failure];
}

@end
