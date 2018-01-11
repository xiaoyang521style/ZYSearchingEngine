
#import <Foundation/Foundation.h>

@interface ZYSEManager : NSObject

/**以字典方式添加解析的单个数据源，id标识为了防止重名*/
+ (id)addInitializeSearchValue:(NSString *)value identifer:(NSString *)identifier model:(id)model;
@end
