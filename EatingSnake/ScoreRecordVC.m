//
//  ScoreRecordVC.m
//  EatingSnake
//
//  Created by 李志彬 on 2017/6/12.
//  Copyright © 2017年 李志彬. All rights reserved.
//

#import "ScoreRecordVC.h"
#import "NSObject+BGModel.h"
#import "ScoreModel.h"

@interface ScoreRecordVC ()<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) NSArray<ScoreModel *> *datasOUR;

@end

static NSString *const cellIdentifityString = @"ScoreRecordVC.h cell";

@implementation ScoreRecordVC

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WWidth, HHeight-40) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 0;
        _tableView.backgroundColor = ColorBlack;
    }
    
    return _tableView;
}

-(void)viewWillAppear:(BOOL)animated{
    _datasOUR = [ScoreModel findAllWithLimit:22 orderBy:@"score" desc:YES];
    [self.tableView reloadData];
    kGCDAsync((^{
        NSString *score = [NSString stringWithFormat:@"%d",[[_datasOUR lastObject] score]];
        [ScoreModel deleteAsync:@[@"score",@"<",score] complete:^(BOOL isSuccess) {
            // you code
        }];
    }));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"排行榜";
    
    [self.view addSubview:self.tableView];
}


#pragma mark tableview 代理
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datasOUR.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifityString];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifityString];
        cell.textLabel.textColor = ColorWhite;
        cell.detailTextLabel.textColor = ColorWhite;
        cell.backgroundColor = ColorClear;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ScoreModel *model = _datasOUR[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"  第 %ld 名：%d 分",indexPath.row+1,model.score];
    cell.detailTextLabel.text = model.player;
    
    return cell;
}


@end
