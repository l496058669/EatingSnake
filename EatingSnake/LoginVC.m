//
//  LoginVC.m
//  EatingSnake
//
//  Created by 李志彬 on 2017/6/12.
//  Copyright © 2017年 李志彬. All rights reserved.
//

#import "LoginVC.h"
#import "GameMainVC.h"

@interface LoginVC ()<
UITableViewDelegate,
UITableViewDataSource
>

@property (nonatomic, strong) UITableView *levelView;
@property (nonatomic, assign) NSInteger speedLevel;

@end

static NSString *const loginVCCellIdentifi = @"loginVCCellIdentifi_1";

@implementation LoginVC
-(NSInteger)speedLevel{
    if (!_speedLevel) {
        _speedLevel = [kUSDF integerForKey:KeySL];
        if (!_speedLevel) {
            _speedLevel = 0;
            [kUSDF setInteger:_speedLevel forKey:KeySL];
        }
    }
    return _speedLevel;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"游戏";
    
    _levelView = [[UITableView alloc]initWithFrame:CGRectMake(0, HHeight, WWidth, HHeight) style:UITableViewStyleGrouped];
    _levelView.delegate = self;
    _levelView.dataSource = self;
    _levelView.sectionFooterHeight = 0;
    _levelView.sectionHeaderHeight = 10;
    _levelView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [kWindow addSubview:_levelView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:loginVCCellIdentifi];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:loginVCCellIdentifi];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"速度 %ld",indexPath.row+1];
    if (self.speedLevel == indexPath.row+1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.speedLevel = indexPath.row+1;
    [_levelView reloadData];
    
    kGCDAfter(0.2, ^{
        [kUSDF setInteger:self.speedLevel forKey:KeySL];
        [UIView animateWithDuration:0.3 animations:^{
            _levelView.frame = CGRectMake(0, HHeight, WWidth, HHeight);
        }];
    });
}


- (IBAction)startGame:(id)sender {
    
    GameMainVC *game = [[GameMainVC alloc]initWithLevel:self.speedLevel];
    [self pushWithViewCtrl:game];
}

- (IBAction)levelChose:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        if (_levelView.frame.origin.y == HHeight) {
                _levelView.frame = CGRectMake(0, 0, WWidth, HHeight);
        }else{
            _levelView.frame = CGRectMake(0, HHeight, WWidth, HHeight);
        }
    }];
    
}

@end
