//
//  ZYTableViewCell.m
//  ZYSearchingEngine
//
//  Created by develop5 on 2018/1/11.
//  Copyright © 2018年 yiqihi. All rights reserved.
//

#import "ZYTableViewCell.h"

@implementation ZYTableViewCell

-(void)setModel:(ZYPersonModel *)model {
    _model = model;
    self.textLabel.text = _model.name;
    // 设置关键字高亮

}
@end
