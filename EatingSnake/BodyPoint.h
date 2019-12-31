//
//  BodyPoint.h
//  EatingSnake
//
//  Created by 李志彬 on 2017/6/12.
//  Copyright © 2017年 李志彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BodyPoint : UIView

@property(nonatomic,assign) int x;
@property(nonatomic,assign) int y;


//初始化
-(instancetype)initWithX:(int)x Y:(int)y;
+(instancetype)pointX:(int)x Y:(int)y;
+(instancetype)foodLocat:(int)x Y:(int)y;


//移动蛇及食物
-(void)moveFoodLocationX:(int)x Y:(int)y;
-(void)becomeFirstX:(int)x Y:(int)y;

@end
