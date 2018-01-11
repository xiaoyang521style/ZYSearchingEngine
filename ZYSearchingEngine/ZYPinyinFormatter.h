#ifndef _PinyinFormatter_
#define _PinyinFormatter_
#import <Foundation/Foundation.h>
#import "NSString+ZYPinYin4Cocoa.h"
@class ZYPinyinOutputFormat;
@interface ZYPinyinFormatter : NSObject

+ (NSString *)formatHanyuPinyinWithNSString:(NSString *)pinyinStr
                withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat;
+ (NSString *)convertToneNumber2ToneMarkWithNSString:(NSString *)pinyinStr;
- (id)init;
@end
#endif
