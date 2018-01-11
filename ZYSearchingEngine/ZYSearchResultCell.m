

//
//  ZYSearchResultCell.m
//  ZYSearchingEngine
//
//  Created by develop5 on 2018/1/11.
//  Copyright © 2018年 yiqihi. All rights reserved.
//

#import "ZYSearchResultCell.h"

@implementation ZYSearchResultCell

-(void)setModel:(ZYPersonModel *)model {
    [super setModel:model];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.name];
    UIColor *highlightedColor = [UIColor colorWithRed:0 green:131/255.0 blue:0 alpha:1.0];
    [attributedString addAttribute:NSForegroundColorAttributeName value:highlightedColor range:model.textRange];
    self.textLabel.attributedText = attributedString;
}
@end
