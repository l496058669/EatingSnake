//
//  BodyPoint.m
//  EatingSnake
//
//  Created by 李志彬 on 2017/6/12.
//  Copyright © 2017年 李志彬. All rights reserved.
//

#import "BodyPoint.h"

@implementation BodyPoint

-(instancetype)initWithX:(int)x Y:(int)y{
    if (self = [super init]) {
        _x = x;
        _y = y;
        self.frame = CGRectMake(x*5, y*5, 5, 5);
        self.backgroundColor = ColorWhite;
        self.layer.borderColor = kRGB(150, 150, 150).CGColor;
        self.layer.borderWidth = 0.5f;
    }
    return self;
}

+(instancetype)pointX:(int)x Y:(int)y{
    BodyPoint *view = [[BodyPoint alloc]initWithX:x Y:y];
    return view;
}

+(instancetype)foodLocat:(int)x Y:(int)y{
    BodyPoint *view = [[BodyPoint alloc]init];
    view.x = x;
    view.y = y;
    view.frame = CGRectMake(x*5, y*5, 5, 5);
    view.backgroundColor = ColorBlue;
    view.layer.borderColor = kRGB(150, 150, 150).CGColor;
    view.layer.borderWidth = 0.5f;
    
    return view;
}

-(void)moveFoodLocationX:(int)x Y:(int)y;{
    _x = x;
    _y = y;
    self.frame = CGRectMake(x*5, y*5, 5, 5);
}


-(void)becomeFirstX:(int)x Y:(int)y;{
    _x = x;
    _y = y;
    self.frame = CGRectMake(x*5, y*5, 5, 5);
    self.backgroundColor = ColorRed;
}


@end
