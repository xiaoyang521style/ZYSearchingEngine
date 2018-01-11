//
//  ZYSearchResultViewController.m
//  ZYSearchingEngine
//
//  Created by develop5 on 2018/1/11.
//  Copyright © 2018年 yiqihi. All rights reserved.
//

#import "ZYSearchResultViewController.h"
#import "ZYSearchResultCell.h"
@interface ZYSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ZYSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)datasoure {
    if (_datasoure == nil) {
        _datasoure = [NSMutableArray new];
    }
    return _datasoure;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.datasoure.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZYSearchResultCell class])];
    if (cell == nil) {
        cell = [[ZYSearchResultCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ZYSearchResultCell class])];
    }
    cell.model = self.datasoure[indexPath.row];
    return cell;
}

@end
