

#import <Foundation/Foundation.h>
#import "ZYPinYinTools.h"
@interface ZYSEModel : NSObject
/** 唯一标识符 */
@property (nonatomic, copy) NSString *searchId;
/** 搜索的value*/
@property (nonatomic, copy) NSString *searchValue;
/** 高亮位置 */
@property (nonatomic, assign) NSInteger highlightLoaction;
/** 关键字范围 */
@property (nonatomic, assign) NSRange textRange;
/** 匹配类型 */
@property (nonatomic, assign) NSInteger matchType;
/** 拼音全拼（小写）如：@"wangpengfei" */
@property (nonatomic, copy) NSString *completeSpelling;
/** 拼音首字母（小写）如：@"wpf" */
@property (nonatomic, copy) NSString *initialString;
@property (nonatomic, copy) NSString *pinyinLocationString;
/** 拼音首字母拼音（小写）数组字符串位置，如@"0,1,2" */
/** 高亮位置 */
//以下四个属性为多音字的适配，暂时只支持双多音字
/** 是否包含多音字 */
@property (nonatomic, assign) BOOL isContainPolyPhone;
/** 第二个多音字 拼音全拼（小写） */
@property (nonatomic, copy) NSString *polyPhoneCompleteSpelling;
/** 第二个多音字 拼音首字母（小写）*/
@property (nonatomic, copy) NSString *polyPhoneInitialString;
/** 第二个多音字 拼音全拼（小写）位置 */
@property (nonatomic, copy) NSString *polyPhonePinyinLocationString;

/** 拼音首字母拼音（小写）数组字符串位置，如@"0,1,2" */
@property (nonatomic, copy) NSString *initialLocationString;
-(id)searchWithId:(NSString *)searchId  value:(NSString *)value hanyuPinyinOutputFormat:(ZYPinyinOutputFormat *)pinyinFormat;

@end
