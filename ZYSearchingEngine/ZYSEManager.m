//
//  ZYSearchingEngineManager.m
//  ZYSearchingEngine
//
//  Created by develop5 on 2018/1/11.
//  Copyright © 2018年 yiqihi. All rights reserved.
//

#import "ZYSEManager.h"
#import "ZYSEModel.h"
@interface ZYSEManager ()
@property (nonatomic, strong) ZYPinyinOutputFormat *outputFormat;
@end
@implementation ZYSEManager
/**以字典方式添加解析的单个数据源，id标识为了防止重名*/
+ (id)addInitializeSearchDict:(NSDictionary *)dict value:(NSString *)value identifer:(NSString *)identifier model:(id)model{
    ZYSEManager *manager = [ZYSEManager shareInstance];
    [(ZYSEModel *)model searchWithId:identifier value:value hanyuPinyinOutputFormat:manager.outputFormat];
    return  model;
}
+ (ZYSEManager *)shareInstance {
    static dispatch_once_t onceToken;
    static ZYSEManager *_instance;
    dispatch_once(&onceToken, ^{
        _instance = [[ZYSEManager alloc] init];
    });
    return _instance;
}


@end