//
//  EVOCommunityViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/5/7.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOCommunityViewController.h"
#import "EVOCommunityViewCell.h"
#import "EVOCommunityDataManager.h"

@interface EVOCommunityViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel * titleTextLabel;
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) EVOCommunityDataManager * dataManager;
@end

@implementation EVOCommunityViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCommunityList) name:EVOUserSubmitCommunitySuccessKey object:nil];
    
    self.dataManager = [EVOCommunityDataManager new];
    
    self.view.backgroundColor = MainBgColor;
    
    self.titleTextLabel = [UILabel new];
    self.titleTextLabel.text = @"地球新闻";
    self.titleTextLabel.font = [UIFont boldSystemFontOfSize:17];
    self.titleTextLabel.textColor = UIColor.whiteColor;
    self.titleTextLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleTextLabel];
    [self.titleTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(kStatusBarHeight+10);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    self.tableView.separatorColor = UIColor.clearColor;
    self.tableView.rowHeight = 288;
    self.tableView.sectionFooterHeight = 10;
    self.tableView.sectionHeaderHeight = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"EVOCommunityViewCell" bundle:nil] forCellReuseIdentifier:@"EVOCommunityViewCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.width.equalTo(self.view);
        make.top.equalTo(self.titleTextLabel.mas_bottom).offset(20);
    }];
}

- (void)refreshCommunityList {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataManager.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EVOCommunityViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"EVOCommunityViewCell" forIndexPath:indexPath];
    cell.dataObj = self.dataManager.dataSourceArray[indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
