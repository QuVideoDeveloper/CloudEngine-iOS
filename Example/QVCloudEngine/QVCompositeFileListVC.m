//
//  QVCompositeVC.m
//  QVCloudEngineSDK_Example
//
//  Created by 夏澄 on 2020/3/20.
//  Copyright © 2020 Sunshine. All rights reserved.
//

#import "QVCompositeFileListVC.h"
#import <QVCloudEngineSDK/QVCloudEngineSDK.h>
#import <YYWebImage.h>
#import "QVPlayerViewController.h"

@interface QVCompositetableCell : UITableViewCell

@property (strong, nonatomic) UIImageView *cImageView;
@property (nonatomic, strong) QVCompositeFileDataModel *model;
@property (strong, nonatomic) UILabel *businessIdLabel;

@end

@implementation QVCompositetableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setModel:(QVCompositeFileDataModel *)model {
    _model = model;
    self.businessIdLabel.text = [NSString stringWithFormat:@"已合成的businessId：%@",model.businessId];
    [self.cImageView yy_setImageWithURL:[NSURL URLWithString:model.coverImageUrl] placeholder:nil];
}

- (UIImageView *)cImageView {
    if (!_cImageView) {
        _cImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width - 65, 6, 44, 44)];
        [self addSubview:_cImageView];
    }
    return _cImageView;
}

- (UILabel *)businessIdLabel {
    if (!_businessIdLabel) {
        _businessIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.frame.size.width, 15)];
        _businessIdLabel.font = [UIFont systemFontOfSize:10];
        _businessIdLabel.textColor = [UIColor blackColor];
        [self addSubview:_businessIdLabel];
    }
    return _businessIdLabel;
}

@end

@interface QVCompositeFileListVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSArray <QVCompositeFileDataModel *> *dataList;

@end

@implementation QVCompositeFileListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [QVCloudEngine getVideosWithPageNum:1 pageSize:15 success:^(QVCompositeFileListResponse * _Nonnull response) {
        self.dataList = response.data;
        [self.tableView reloadData];
        [QVCloudEngine report:[response fetchFileIds]];
    } failure:^(QVErrorModel * _Nonnull errorModel) {
           
       }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[QVCompositetableCell class] forCellReuseIdentifier:@"TableViewCellID"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

//懒加载
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

//分区，组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}
//每个单元格的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QVCompositetableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellID" forIndexPath:indexPath];
    if (indexPath.row < self.dataList.count) {
        cell.model = self.dataList[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataList.count) {
        QVPlayerViewController *vc = [[QVPlayerViewController alloc] init];
        vc.fileUrl = self.dataList[indexPath.row].fileUrl;
        [self.navigationController pushViewController:vc animated:NO];
      }
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
