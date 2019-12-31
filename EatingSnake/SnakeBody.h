//
//  SnakeBody.h
//  EatingSnake
//
//  Created by 李志彬 on 2017/6/12.
//  Copyright © 2017年 李志彬. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BodyPoint.h"


typedef enum SnakeDirection{
    DirectionTop = -3,
    DirectionBottom = 3,
    DirectionLeft = -1,
    Directionright = 1
}SnakeDirection;

@interface SnakeBody : UIView

@property (nonatomic, retain) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray<BodyPoint *> *bodyView;


@property (nonatomic, assign) int limitSize;
@property (nonatomic, assign) SnakeDirection direction;
@property (nonatomic, assign) SnakeDirection lastDirection;


//初始化
-(instancetype)initWithFrame:(CGRect)frame Leave:(int)speed Score:(void(^)(int score))block;

//移动
-(BOOL)moved;

//重新开始
-(void)resetGameMap;

@end
