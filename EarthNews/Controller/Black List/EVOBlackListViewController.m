//
//  EVOBlackListViewController.m
//  EarthNews
//
//  Created by zkeBoy on 2020/6/11.
//  Copyright © 2020 zkeBoy. All rights reserved.
//

#import "EVOBlackListViewController.h"
#import "EVOBlackListManager.h"
#import "EVOBlackListCellView.h"

@interface EVOBlackListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIImageView * emptyImgView;
@end

@implementation EVOBlackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = MainBgColor;
    
    [self setUIConfig];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshBlackList) name:EVORemoveBlackListSuccessKey object:nil];
    
    [self refreshBlackList];
}

- (void)setUIConfig {
    self.tableView.separatorColor = UIColor.clearColor;
    self.tableView.rowHeight = 83;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"EVOBlackListCellView" bundle:nil] forCellReuseIdentifier:@"EVOBlackListCellView"];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.01)];
    
    self.emptyImgView = [[UIImageView alloc] initWithImage:CreateImage(@"icon_empty")];
    [self.view addSubview:self.emptyImgView];
    [self.emptyImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(79);
        make.height.mas_equalTo(50);
        make.center.equalTo(self.view);
    }];
}

- (void)refreshBlackList {
    [self.tableView reloadData];
    self.emptyImgView.hidden = [EVOBlackListManager getAllBlackList].count;
}

- (IBAction)clickBackAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [EVOBlackListManager getAllBlackList].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EVOBlackListCellView * cell = [tableView dequeueReusableCellWithIdentifier:@"EVOBlackListCellView" forIndexPath:indexPath];
    cell.dataObj = [EVOBlackListManager getAllBlackList][indexPath.row];
    return cell;
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
