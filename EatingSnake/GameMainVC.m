//
//  GameMainVC.m
//  EatingSnake
//
//  Created by 李志彬 on 2017/6/12.
//  Copyright © 2017年 李志彬. All rights reserved.
//

#import "GameMainVC.h"
#import "SnakeBody.h"
#import "ScoreModel.h"

#import "Masonry.h"
#import "NSObject+BGModel.h"

@interface GameMainVC ()


@property (nonatomic, strong) NSTimer *gameTimer;
@property (nonatomic, assign) NSInteger level;


//4个方向按钮
@property (nonatomic, strong) UIButton *shang;
@property (nonatomic, strong) UIButton *xia;
@property (nonatomic, strong) UIButton *zuo;
@property (nonatomic, strong) UIButton *you;

@property (nonatomic, strong) SnakeBody *gameMap;

@end


@implementation GameMainVC

{
    UIButton *_rightBtn;
    int _score;
}

-(instancetype)initWithLevel:(NSInteger)inter{
    if (self = [super init]) {
        _level = inter;
    }
    return self;
}

-(SnakeBody *)gameMap{
    if (!_gameMap) {
        int width = WWidth-20;
        if (width%10 != 0) width = width - width%10;
        
        int place = (WWidth - width)/2;
        _gameMap = [[SnakeBody alloc]initWithFrame:CGRectMake(place, place, width, width) Leave:1 Score:^(int score) {
            _score = score;
        }];
    }
    return _gameMap;
}

-(void)setUpAllControl{
    
    UIView *backView = [[UIView alloc]init];
    [self.view addSubview:backView];
    
    [self.view addSubview:self.gameMap];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-10);
        make.top.equalTo(_gameMap.mas_bottom).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    [self.view layoutIfNeeded];
    
    kGCDAfter(0.1,( ^{
        CGFloat bvWidth = backView.bounds.size.width/3;
        CGFloat bvHight = backView.bounds.size.height/3;
        
        for (int i = 0; i<9; i++) {
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((i%3)*bvWidth-1, (i/3)*bvHight-1, bvWidth+1, bvHight+1)];
            NSString *title = [NSString stringWithFormat:@"- %d -",i+1];
            [button setTitle:title forState:0];
            button.layer.borderWidth = 1.0f;
            button.layer.borderColor = ColorGray.CGColor;
            button.tag = i-4;
            [button addTarget:self action:@selector(directionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [backView addSubview:button];
        }
    }));
    
    kGCDAfter(0.5, ^{
        _gameTimer = [NSTimer scheduledTimerWithTimeInterval:_level*0.03 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [self makeSnakeMoving];
        }];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *level = [NSString stringWithFormat:@"Level : %ld",_level];
    self.title = level;
    self.view.backgroundColor = ColorBlack;
    
    //设置导航栏按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popToTop)];
    self.navigationItem.leftBarButtonItem = backItem;
    
    _rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    [_rightBtn setTitle:@"暂停" forState:0];
    _rightBtn.tag = 0;
    [_rightBtn setTitleColor:ColorBlue forState:0];
    [_rightBtn addTarget:self action:@selector(pauseBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *puseItem = [[UIBarButtonItem alloc]initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = puseItem;
    
    
    [self setUpAllControl];
    
}






-(void)directionButtonAction:(UIButton *)btn{
    if (btn.tag == 0) {
        [self makeSnakeMoving];
        [self makeSnakeMoving];
        [self makeSnakeMoving];
    }else{
        NSInteger dir = btn.tag;
        NSInteger lad = _gameMap.lastDirection;
        
        switch (dir) {
            case -4:
                if (lad == -3 || lad == 3) {
                    dir = -1;
                }else{
                    dir = -3;
                }
                break;
                
            case -2:
                if (lad == -3 || lad == 3) {
                    dir = 1;
                }else{
                    dir = -3;
                }
                break;
                
            case 2:
                if (lad == -3 || lad == 3) {
                    dir = -1;
                }else{
                    dir = 3;
                }
                break;
                
            case 4:
                if (lad == -3 || lad == 3) {
                    dir = 1;
                }else{
                    dir = 3;
                }
                break;
                
            default:
                break;
        }
        
            
        if (dir + _gameMap.lastDirection != 0) {
            _gameMap.direction = (SnakeDirection)dir;
        }
    }
}

-(void)makeSnakeMoving{
    BOOL isAlive = [_gameMap moved];
    if (isAlive == NO) {
        [_gameTimer setFireDate:[NSDate distantFuture]];
        _rightBtn.tag = 2;
        [_rightBtn setTitle:@"重来" forState:0];
        NSString *msg = [NSString stringWithFormat:@"游戏结束，当前分数 %d",_score];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"失败" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"重新开始" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _rightBtn.tag = 0;
            [_rightBtn setTitle:@"暂停" forState:0];
            [_gameMap resetGameMap];
            [_gameTimer setFireDate:[NSDate distantPast]];
            NSString *text = alert.textFields[0].text;
            [kUSDF setObject:text forKey:@"FirstPlayer"];
            [self saveScoreWithPlayer:text score:_score];
        }];
        UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSString *text = alert.textFields[0].text;
            [kUSDF setObject:text forKey:@"FirstPlayer"];
            [self saveScoreWithPlayer:text score:_score];
        }];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入大名";
            textField.text = [kUSDF stringForKey:@"FirstPlayer"];
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        
        [alert addAction:act1];
        [alert addAction:act2];
        [self presentViewController:alert animated:YES completion:nil];
        
    }else{
        
    }
}


#pragma mark 导航栏按钮
-(void)popToTop{
    [_gameTimer setFireDate:[NSDate distantFuture]];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要放弃游戏并退出？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        [_gameTimer invalidate];
        _gameTimer = nil;
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [_gameTimer setFireDate:[NSDate distantPast]];
    }];
    
    [alert addAction:act1];
    [alert addAction:act2];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)pauseBtnAction{
    if (_rightBtn.tag == 0) {
        _rightBtn.tag = 1;
        [_gameTimer setFireDate:[NSDate distantFuture]];
        [_rightBtn setTitle:@"继续" forState:0];
    }else if(_rightBtn.tag == 2){
        [_gameMap resetGameMap];
        _rightBtn.tag = 0;
        [_gameTimer setFireDate:[NSDate distantPast]];
        [_rightBtn setTitle:@"暂停" forState:0];
    }else{
        _rightBtn.tag = 0;
        [_gameTimer setFireDate:[NSDate distantPast]];
        [_rightBtn setTitle:@"暂停" forState:0];
    }
    
}

//储存数据
-(void)saveScoreWithPlayer:(NSString *)player score:(int)score{
    ScoreModel *model = [[ScoreModel alloc]init];
    model.player = player;
    model.score = score;
    
    [model saveAsync:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_gameTimer invalidate];
    _gameTimer = nil;
}

@end
