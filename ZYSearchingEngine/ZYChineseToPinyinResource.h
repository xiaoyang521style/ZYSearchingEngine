#ifndef _ChineseToPinyinResource_
#define _ChineseToPinyinResource_
#import <Foundation/Foundation.h>
@class ZYChineseToPinyinResource;
@interface ZYChineseToPinyinResource : NSObject {
    NSString* _directory;
    NSDictionary *_unicodeToHanyuPinyinTable;
}
- (id)init;
- (void)initializeResource;
- (NSArray *)getHanyuPinyinStringArrayWithChar:(unichar)ch;
- (BOOL)isValidRecordWithNSString:(NSString *)record;
- (NSString *)getHanyuPinyinRecordFromCharWithChar:(unichar)ch;
+ (ZYChineseToPinyinResource *)getInstance;
@end
#endif // _ChineseToPinyinResource_
