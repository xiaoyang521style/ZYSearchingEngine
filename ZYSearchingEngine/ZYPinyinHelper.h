#ifndef _PinyinHelper_
#define _PinyinHelper_
#import <Foundation/Foundation.h>
typedef void(^OutputStringBlock)(NSString *pinYin) ;
typedef void(^OutputArrayBlock)(NSArray *array) ;
@class ZYPinyinOutputFormat;
@interface ZYPinyinHelper : NSObject
/* async methods, "ui blocking" is gone, make ui update smoothly ,recommend use methods below*/

+ (void)toHanyuPinyinStringArrayWithChar:(unichar)ch
                             outputBlock:(OutputArrayBlock)outputBlock;
+ (void)toHanyuPinyinStringArrayWithChar:(unichar)ch
             withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                             outputBlock:(OutputArrayBlock)outputBlock;
+ (void)getFormattedHanyuPinyinStringArrayWithChar:(unichar)ch
                       withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                                       outputBlock:(OutputArrayBlock)outputBlock;
+ (void)getUnformattedHanyuPinyinStringArrayWithChar:(unichar)ch
                                         outputBlock:(OutputArrayBlock)outputBlock;
+ (void)toTongyongPinyinStringArrayWithChar:(unichar)ch
                                outputBlock:(OutputArrayBlock)outputBlock;
+ (void)toWadeGilesPinyinStringArrayWithChar:(unichar)ch
                                 outputBlock:(OutputArrayBlock)outputBlock;
+ (void)toMPS2PinyinStringArrayWithChar:(unichar)ch
                            outputBlock:(OutputArrayBlock)outputBlock;
+ (void)toYalePinyinStringArrayWithChar:(unichar)ch
                            outputBlock:(OutputArrayBlock)outputBlock;
+ (void)convertToTargetPinyinStringArrayWithChar:(unichar)ch
                      withPinyinRomanizationType:(NSString *)targetPinyinSystem
                                     outputBlock:(OutputArrayBlock)outputBlock;
+ (void)toGwoyeuRomatzyhStringArrayWithChar:(unichar)ch
                                outputBlock:(OutputArrayBlock)outputBlock;
+ (void)convertToGwoyeuRomatzyhStringArrayWithChar:(unichar)ch
                                       outputBlock:(OutputArrayBlock)outputBlock;
+ (void)toHanyuPinyinStringWithNSString:(NSString *)str
            withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                           withNSString:(NSString *)seperater
                            outputBlock:(OutputStringBlock)outputBlock;
+ (void)getFirstHanyuPinyinStringWithChar:(unichar)ch
              withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                              outputBlock:(OutputStringBlock)outputBlock;

/* sync methods */

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch
                  withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat;
+ (NSArray *)getFormattedHanyuPinyinStringArrayWithChar:(unichar)ch
                            withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat  *)outputFormat;
+ (NSArray *)getUnformattedHanyuPinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toTongyongPinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toWadeGilesPinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toMPS2PinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)toYalePinyinStringArrayWithChar:(unichar)ch;
+ (NSArray *)convertToTargetPinyinStringArrayWithChar:(unichar)ch
                           withPinyinRomanizationType:(NSString *)targetPinyinSystem;
+ (NSArray *)toGwoyeuRomatzyhStringArrayWithChar:(unichar)ch;
+ (NSArray *)convertToGwoyeuRomatzyhStringArrayWithChar:(unichar)ch;
+ (NSString *)toHanyuPinyinStringWithNSString:(NSString *)str
                  withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                                 withNSString:(NSString *)seperater;
+ (NSString *)getFirstHanyuPinyinStringWithChar:(unichar)ch
                    withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat;
@end
#endif // _PinyinHelper_
