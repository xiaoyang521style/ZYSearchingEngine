//
//  ViewController.m
//  ZYSearchingEngine
//
//  Created by develop5 on 2018/1/11.
//  Copyright © 2018年 yiqihi. All rights reserved.
//

#import "ViewController.h"
#import "ZYPersonModel.h"
#import "ZYSEManager.h"
#import "ZYTableViewCell.h"
#import "ZYSearchResultViewController.h"
@interface ViewController ()<
UITableViewDelegate,
UITableViewDataSource,
UISearchResultsUpdating>
@property(nonatomic, strong)NSMutableArray *modelArr;
@property(nonatomic, strong)UITableView *tabelView;
@property(nonatomic, strong)UISearchController *searchController;
@property(nonatomic, strong)ZYSearchResultViewController *searchResultVC;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self addData];
    [self addUI];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)addData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"PersonList" ofType:@"json"];
    NSData *data = [[NSData alloc]initWithContentsOfFile: path];
    NSDictionary *dict  = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    NSArray *array = dict[@"data"];
    NSMutableArray *dataSoure = [NSMutableArray new];
    for (NSString *str in array) {
        NSMutableDictionary *mydict = [[NSMutableDictionary alloc]init];
        [mydict setObject:str  forKey:@"name"];
        [mydict setObject:@"SE" forKey:@"my"];
        [dataSoure addObject:mydict];
    }
    int i = 0;
    for (NSDictionary *dic in dataSoure ) {
        ZYPersonModel *model = [[ZYPersonModel alloc]init];
        model.other = dic[@"my"];
        model.name =  dic[@"name"];
        [ZYSEManager addInitializeSearchValue:dic[@"name"] identifer:[NSString stringWithFormat:@"%d",i] model:model];
        [self.modelArr addObject:model];
        i++;
    }
}
-(void)addUI{
    self.navigationItem.title = @"ZYSearchingEngine";
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barStyle =  UIBarStyleBlackOpaque;
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
    self.definesPresentationContext = YES;
    [self.view addSubview:self.tabelView];
}
-(NSMutableArray *)modelArr {
    if(_modelArr == nil){
        _modelArr = [NSMutableArray new];
    }
    return _modelArr;
}

-(UITableView *)tabelView {
    if (_tabelView == nil) {
        _tabelView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tabelView.delegate = self;
        _tabelView.dataSource = self;
        _tabelView.tableFooterView = [[UIView alloc]init];
        _tabelView.estimatedRowHeight = 0;
        _tabelView.estimatedSectionFooterHeight = 0;
        _tabelView.estimatedSectionHeaderHeight = 0;
        _tabelView.tableHeaderView = self.searchController.searchBar;
    }
    return _tabelView;
}
-(ZYSearchResultViewController *)searchResultVC {
    if (_searchResultVC == nil) {
        _searchResultVC = [[ZYSearchResultViewController alloc]init];
    }
    return _searchResultVC;
}
-(UISearchController *)searchController {
    if (_searchController == nil) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:self.searchResultVC];
        _searchController.searchResultsUpdater = self;

    }
    return _searchController;
}
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSMutableArray *resultDataSource = [NSMutableArray new];
    NSString *keyWord = searchController.searchBar.text;
    for (ZYPersonModel *model in self.modelArr) {
         SearchResultModel *resultModel = [ZYPinYinTools searchEffectiveResultWithSearchString:keyWord model:model];
        if (resultModel.highlightedRange.length) {
            model.highlightLoaction = resultModel.highlightedRange.location;
            model.textRange = resultModel.highlightedRange;
            model.matchType = resultModel.matchType;
            [resultDataSource addObject:model];
        }
    }
    self.searchResultVC.datasoure = resultDataSource;
    [self.searchResultVC.tableView reloadData];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZYTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZYTableViewCell class])];
    if (cell == nil) {
        cell = [[ZYTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([ZYTableViewCell class])];
    }
    cell.model = self.modelArr[indexPath.row];
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
