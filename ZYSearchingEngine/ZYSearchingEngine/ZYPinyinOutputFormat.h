

#ifndef _PinyinOutputFormat_
#define _PinyinOutputFormat_

typedef enum {
    ToneTypeWithToneNumber,
    ToneTypeWithoutTone,
    ToneTypeWithToneMark
}ToneType;

typedef enum {
    CaseTypeUppercase,
    CaseTypeLowercase
}CaseType;

typedef enum {
    VCharTypeWithUAndColon,
    VCharTypeWithV,
    VCharTypeWithUUnicode
}VCharType;

#import <Foundation/Foundation.h>

@interface ZYPinyinOutputFormat : NSObject
@property(nonatomic, assign) VCharType vCharType;
@property(nonatomic, assign) CaseType caseType;
@property(nonatomic, assign) ToneType toneType;
- (id)init;
- (void)restoreDefault;
@end

#endif // PinyinOutputFormat
