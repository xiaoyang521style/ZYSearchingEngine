
#include "ZYChineseToPinyinResource.h"
#include "ZYPinyinOutputFormat.h"
#include "ZYPinyinFormatter.h"
#include "ZYPinyinHelper.h"

#define HANYU_PINYIN @"Hanyu"
#define WADEGILES_PINYIN @"Wade"
#define MPS2_PINYIN @"MPSII"
#define YALE_PINYIN @"Yale"
#define TONGYONG_PINYIN @"Tongyong"
#define GWOYEU_ROMATZYH @"Gwoyeu"
@implementation ZYPinyinHelper
//////async methods
+ (void)toHanyuPinyinStringArrayWithChar:(unichar)ch
                             outputBlock:(OutputArrayBlock)outputBlock
{
    [ZYPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch outputBlock:outputBlock];
}

+ (void)toHanyuPinyinStringArrayWithChar:(unichar)ch
             withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                             outputBlock:(OutputArrayBlock)outputBlock
{
    return [ZYPinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withHanyuPinyinOutputFormat:outputFormat outputBlock:outputBlock];
}

+ (void)getFormattedHanyuPinyinStringArrayWithChar:(unichar)ch
                       withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                                       outputBlock:(OutputArrayBlock)outputBlock {
    [ZYPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch outputBlock:^(NSArray *array) {
        if (outputBlock) {
            if (nil != array) {
                NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:array.count];
                for (int i = 0; i < (int) [array count]; i++) {
                    [targetPinyinStringArray replaceObjectAtIndex:i withObject:[ZYPinyinFormatter formatHanyuPinyinWithNSString:
                                                                                [array objectAtIndex:i]withHanyuPinyinOutputFormat:outputFormat]];
                }
                outputBlock(targetPinyinStringArray);
            }
            else{
                outputBlock(nil);
            }
        }
    }];
}

+ (void)getUnformattedHanyuPinyinStringArrayWithChar:(unichar)ch
                                         outputBlock:(OutputArrayBlock)outputBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray *array= [[ZYChineseToPinyinResource getInstance] getHanyuPinyinStringArrayWithChar:ch];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (outputBlock) {
                outputBlock(array);
            }
        });
    });
}

+ (void)toTongyongPinyinStringArrayWithChar:(unichar)ch
                                outputBlock:(OutputArrayBlock)outputBlock {
    return [ZYPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: TONGYONG_PINYIN outputBlock:outputBlock];
}

+ (void)toWadeGilesPinyinStringArrayWithChar:(unichar)ch
                                 outputBlock:(OutputArrayBlock)outputBlock {
    [ZYPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: WADEGILES_PINYIN outputBlock:outputBlock];
}

+ (void)toMPS2PinyinStringArrayWithChar:(unichar)ch
                            outputBlock:(OutputArrayBlock)outputBlock {
    [ZYPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: MPS2_PINYIN outputBlock:outputBlock];
}

+ (void)toYalePinyinStringArrayWithChar:(unichar)ch
                            outputBlock:(OutputArrayBlock)outputBlock {
    [ZYPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: YALE_PINYIN outputBlock:outputBlock];
}

+ (void)convertToTargetPinyinStringArrayWithChar:(unichar)ch
                      withPinyinRomanizationType:(NSString *)targetPinyinSystem
                                     outputBlock:(OutputArrayBlock)outputBlock {
    
    [ZYPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch outputBlock:^(NSArray *array) {
        if (outputBlock) {
            if (nil != array) {
                NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:array.count];
                for (int i = 0; i < (int) [array count]; i++) {
                    ///to do
                }
                outputBlock(targetPinyinStringArray);
            }
            else{
                outputBlock(nil);
            }
        }
    }];
}
+ (void)toGwoyeuRomatzyhStringArrayWithChar:(unichar)ch
                                outputBlock:(OutputArrayBlock)outputBlock {
    
    [ZYPinyinHelper convertToGwoyeuRomatzyhStringArrayWithChar:ch outputBlock:outputBlock];
}

+ (void)convertToGwoyeuRomatzyhStringArrayWithChar:(unichar)ch
                                       outputBlock:(OutputArrayBlock)outputBlock {
    [ZYPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch outputBlock:^(NSArray *array) {
        if (outputBlock) {
            if (nil != array) {
                NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:array.count];
                for (int i = 0; i < (int) [array count]; i++) {
                    ///to do
                }
                outputBlock(targetPinyinStringArray);
            }
            else{
                outputBlock(nil);
            }
        }
    }];
    
}

+ (void)toHanyuPinyinStringWithNSString:(NSString *)str
            withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                           withNSString:(NSString *)seperater
                            outputBlock:(OutputStringBlock)outputBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        __block NSMutableString *resultPinyinStrBuf = [[NSMutableString alloc] init];
        for (int i = 0; i <  str.length; i++) {
            NSString *mainPinyinStrOfChar = [ZYPinyinHelper getFirstHanyuPinyinStringWithChar:[str characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
            if (nil != mainPinyinStrOfChar) {
                [resultPinyinStrBuf appendString:mainPinyinStrOfChar];
                if (i != [str length] - 1) {
                    [resultPinyinStrBuf appendString:seperater];
                }
            }
            else {
                [resultPinyinStrBuf appendFormat:@"%C",[str characterAtIndex:i]];
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if (outputBlock) {
                outputBlock(resultPinyinStrBuf);
            }
        });
    });
}

+ (void)getFirstHanyuPinyinStringWithChar:(unichar)ch
              withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                              outputBlock:(OutputStringBlock)outputBlock {
    [self getFormattedHanyuPinyinStringArrayWithChar:ch withHanyuPinyinOutputFormat:outputFormat outputBlock:^(NSArray *array) {
        if (outputBlock) {
            if ((nil != array) && ((int) [array count] > 0)) {
                outputBlock([array objectAtIndex:0]);
            }else {
                outputBlock(nil);
            }
            
        }
    }];
}

/////sync methods

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch {
    return [ZYPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
}

+ (NSArray *)toHanyuPinyinStringArrayWithChar:(unichar)ch
                  withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat {
    return [ZYPinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withHanyuPinyinOutputFormat:outputFormat];
}

+ (NSArray *)getFormattedHanyuPinyinStringArrayWithChar:(unichar)ch
                            withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat {
    NSMutableArray *pinyinStrArray =[NSMutableArray arrayWithArray:[ZYPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch]];
    if (nil != pinyinStrArray) {
        for (int i = 0; i < (int) [pinyinStrArray count]; i++) {
            [pinyinStrArray replaceObjectAtIndex:i withObject:[ZYPinyinFormatter formatHanyuPinyinWithNSString:
                                                               [pinyinStrArray objectAtIndex:i]withHanyuPinyinOutputFormat:outputFormat]];
        }
        return pinyinStrArray;
    }
    else return nil;
}

+ (NSArray *)getUnformattedHanyuPinyinStringArrayWithChar:(unichar)ch {
    return [[ZYChineseToPinyinResource getInstance] getHanyuPinyinStringArrayWithChar:ch];
}

+ (NSArray *)toTongyongPinyinStringArrayWithChar:(unichar)ch {
    return [ZYPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: TONGYONG_PINYIN];
}

+ (NSArray *)toWadeGilesPinyinStringArrayWithChar:(unichar)ch {
    return [ZYPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: WADEGILES_PINYIN];
}

+ (NSArray *)toMPS2PinyinStringArrayWithChar:(unichar)ch {
    return [ZYPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: MPS2_PINYIN];
}

+ (NSArray *)toYalePinyinStringArrayWithChar:(unichar)ch {
    return [ZYPinyinHelper convertToTargetPinyinStringArrayWithChar:ch withPinyinRomanizationType: YALE_PINYIN];
}

+ (NSArray *)convertToTargetPinyinStringArrayWithChar:(unichar)ch
                           withPinyinRomanizationType:(NSString *)targetPinyinSystem {
    NSArray *hanyuPinyinStringArray = [ZYPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
    if (nil != hanyuPinyinStringArray) {
        NSMutableArray *targetPinyinStringArray = [NSMutableArray arrayWithCapacity:hanyuPinyinStringArray.count];
        for (int i = 0; i < (int) [hanyuPinyinStringArray count]; i++) {
            
        }
        return targetPinyinStringArray;
    }
    else return nil;
}

+ (NSArray *)toGwoyeuRomatzyhStringArrayWithChar:(unichar)ch {
    return [ZYPinyinHelper convertToGwoyeuRomatzyhStringArrayWithChar:ch];
}

+ (NSArray *)convertToGwoyeuRomatzyhStringArrayWithChar:(unichar)ch {
    NSArray *hanyuPinyinStringArray = [ZYPinyinHelper getUnformattedHanyuPinyinStringArrayWithChar:ch];
    if (nil != hanyuPinyinStringArray) {
        NSMutableArray *targetPinyinStringArray =[NSMutableArray arrayWithCapacity:hanyuPinyinStringArray.count];
        for (int i = 0; i < (int) [hanyuPinyinStringArray count]; i++) {
        }
        return targetPinyinStringArray;
    }
    else return nil;
}

+ (NSString *)toHanyuPinyinStringWithNSString:(NSString *)str
                  withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat
                                 withNSString:(NSString *)seperater {
    NSMutableString *resultPinyinStrBuf = [[NSMutableString alloc] init];
    for (int i = 0; i <  str.length; i++) {
        NSString *mainPinyinStrOfChar = [ZYPinyinHelper getFirstHanyuPinyinStringWithChar:[str characterAtIndex:i] withHanyuPinyinOutputFormat:outputFormat];
        if (nil != mainPinyinStrOfChar) {
            [resultPinyinStrBuf appendString:mainPinyinStrOfChar];
            if (i != [str length] - 1) {
                [resultPinyinStrBuf appendString:seperater];
            }
        }
        else {
            [resultPinyinStrBuf appendFormat:@"%C",[str characterAtIndex:i]];
        }
    }
    return resultPinyinStrBuf;
}

+ (NSString *)getFirstHanyuPinyinStringWithChar:(unichar)ch
                    withHanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)outputFormat {
    NSArray *pinyinStrArray = [ZYPinyinHelper getFormattedHanyuPinyinStringArrayWithChar:ch withHanyuPinyinOutputFormat:outputFormat];
    if ((nil != pinyinStrArray) && ((int) [pinyinStrArray count] > 0)) {
        return [pinyinStrArray objectAtIndex:0];
    }
    else {
        return nil;
    }
}

@end
