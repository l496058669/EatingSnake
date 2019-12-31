//
//  SnakeBody.m
//  EatingSnake
//
//  Created by 李志彬 on 2017/6/12.
//  Copyright © 2017年 李志彬. All rights reserved.
//

#import "SnakeBody.h"

@interface SnakeBody()

@property (nonatomic, strong) BodyPoint *foodPoint;
@property (nonatomic, copy) void (^block)(int score);

@end




@implementation SnakeBody
{
    int _game_score;
}

-(void)creatOriginalSnakeBody{
    _direction = Directionright;
    _lastDirection = _direction;
    for (int i = 6; i < 17; i++) {
        BodyPoint *point = [BodyPoint pointX:_limitSize/2-i Y:_limitSize/2];
        point.tag = point.x*10000+point.y;
        if (i == 6) {
            point.backgroundColor = ColorRed;
        }
        [_dataSource addObject:point];
        [self addSubview:point];
    }
}

-(instancetype)initWithFrame:(CGRect)frame Leave:(int)speed Score:(void (^)(int))block{
    if (self = [super initWithFrame:frame]) {
        _limitSize = frame.size.width/5;
        _dataSource = [NSMutableArray new];
        _bodyView = [NSMutableArray new];
        _block = block;
        _game_score = 0;
        
        [self creatOriginalSnakeBody];
        
        CGPoint point = [self foodLocation];
        _foodPoint = [BodyPoint foodLocat:point.x Y:point.y];
        [self addSubview:_foodPoint];
        self.backgroundColor = kRGB(150, 150, 150);
    }
    
    return self;
}

//设置食物出现位置
-(CGPoint)foodLocation{
    int x = arc4random() % _limitSize;
    int y = arc4random() % _limitSize;
    
    for (int i = 0; i<_dataSource.count; i++) {
        BodyPoint *point = _dataSource[i];
        if (x == point.x && y == point.y) {
            x = arc4random() % _limitSize;
            y = arc4random() % _limitSize;
            i = 0;
        }
    }
    return CGPointMake(x, y);
}

-(BOOL)moved{
    BodyPoint *movePoint = [_dataSource lastObject];
    
    //获取头部x、y值，并更换颜色
    BodyPoint *head = [_dataSource firstObject];
    head.backgroundColor = ColorWhite;
    [_dataSource replaceObjectAtIndex:0 withObject:head];
    
    int x = head.x;
    int y = head.y;
    
    switch (_direction) {
        case DirectionTop:
            if (y < 1) {
                y = _limitSize-1;
            }else{
                y--;
            }
            break;
            
        case DirectionLeft:
            if (x < 1) {
                x = _limitSize-1;
            }else{
                x--;
            }
            break;
            
        case DirectionBottom:
            if (y == _limitSize-1) {
                y = 0;
            }else{
                y++;
            }
            break;
            
        default:
            if (x == _limitSize-1) {
                x = 0;
            }else{
                x++;
            }
            break;
    }
    
    NSLog(@"x: %d   y:%d",x,y);
    if (x == _foodPoint.x && y == _foodPoint.y) {
        CGPoint fp = [self foodLocation];
        [_foodPoint moveFoodLocationX:fp.x Y:fp.y];
        movePoint = [BodyPoint pointX:x Y:y];
        movePoint.backgroundColor = ColorRed;
        
        _game_score++;
        _block(_game_score);
    }else{
        //移除最后一节View，并添加到前面去
        [movePoint removeFromSuperview];
        [_dataSource removeObject:movePoint];
        [movePoint becomeFirstX:x Y:y];
        
        //判断是否与自己的身体相撞
        for (BodyPoint *body in _dataSource) {
            if (x == body.x && y == body.y) {
                body.backgroundColor = ColorRed;
                return NO;
            }
        }
    }
    
    
    [self addSubview:movePoint];
    [_dataSource insertObject:movePoint atIndex:0];
    _lastDirection = _direction;
    return YES;
}

-(void)resetGameMap{
    _game_score = 0;
    while (_dataSource.count > 0) {
        BodyPoint *body = _dataSource[0];
        [body removeFromSuperview];
        [_dataSource removeObject:body];
    }
    [self creatOriginalSnakeBody];
    
}

@end
