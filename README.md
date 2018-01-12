# ZYSearchingEngine

说明
-----------------------------------
汉字拼音搜索，多音节，位置计算

使用方法
-----------------------------------
pod 'ZYSearchingEngine'

1.首先建立继承ZYSEModel类

#import "ZYSEModel.h"

@interface ZYPersonModel : ZYSEModel
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *other;
@end

2.建立继承ZYSEModel的对象并添加搜索关键字

ZYPersonModel *model = [[ZYPersonModel alloc]init];
        model.other = dic[@"my"];
        model.name =  dic[@"name"];
        [ZYSEManager addInitializeSearchValue:dic[@"name"] identifer:[NSString stringWithFormat:@"%d",i] model:model];
        [self.modelArr addObject:model];

3.查询搜索对象

  for (ZYPersonModel *model in self.modelArr) {
         SearchResultModel *resultModel = [ZYPinYinTools searchEffectiveResultWithSearchString:keyWord model:model];
        if (resultModel.highlightedRange.length) {
            model.highlightLoaction = resultModel.highlightedRange.location;
            model.textRange = resultModel.highlightedRange;
            model.matchType = resultModel.matchType;
            [resultDataSource addObject:model];
        }
        
        
效果图
-----------------------------------
![baidu-images](https://github.com/xiaoyang521style/ZYSearchingEngine/blob/master/Resoures/ZYSearchingEngine.gif?raw=true) 
