//
//  ZBButton.m
//  澳泰养车
//
//  Created by zbin.lee on 16/9/30.
//  Copyright © 2016年 aotai. All rights reserved.
//

#import "ZBButton.h"
#import <objc/runtime.h>

@implementation ZBButton




//1.button初始化
-(instancetype)init{
    
    if (self = [super init]) {
        [self setTitleColor:[UIColor blackColor] forState:0];
        [self addTarget:self action:@selector(buttonActionBlock) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

//1.1对象方法
-(instancetype)initWithFrame:(CGRect)frame
                       title:(NSString *)title
                  titleColor:(UIColor *)titlecolor
                   backColor:(UIColor *)backcolor
                 actionBlock:(void (^)(__unused ZBButton *callButton))block{
    if (self = [super initWithFrame:frame]) {
        [self setTitle:title forState:0];
        [self setBackgroundColor:backcolor];
        [self setTitleColor:titlecolor forState:0];
        if (block) {
            self.buttonBlock = block;
        }
        [self addTarget:self action:@selector(buttonActionBlock) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


//1.2类方法
+(instancetype)buttonWithTitle:(NSString *)title
                    titleColor:(UIColor *)titlecolor
                     backColor:(UIColor *)backcolor
                   actionBlock:(void (^)(__unused ZBButton *callButton))block{
    
    ZBButton* zBtn = [[ZBButton alloc]init];
    [zBtn setTitle:title forState:0];
    [zBtn setBackgroundColor:backcolor];
    [zBtn setTitleColor:titlecolor forState:0];
    if (block) {
        zBtn.buttonBlock = block;
    }
    [zBtn addTarget:zBtn action:@selector(buttonActionBlock) forControlEvents:UIControlEventTouchUpInside];
    
    return zBtn;
}

//设置图片
-(void)setImageWithName:(NSString *)imageName{
    [self setImage:[UIImage imageNamed:imageName] forState:0];
}

//1.3block调用
-(void)buttonActionBlock{
    if (self.buttonBlock) {
        self.buttonBlock(self);
    }
}


-(NSString*)description{
    NSString *string = [NSString stringWithFormat:@"______ZBButton  title:%@ flag:%@",self.titleLabel.text,_flag];
    return string;
}

@end

@implementation ZBButtonSet

-(ZBButtonSet *(^)(NSString *))normalTitle;{
    return ^ZBButtonSet *(NSString *title){
        [self.oriButton setTitle:title forState:0];
        return self;
    };
}

-(ZBButtonSet * (^)(NSString *))hightlighTitle{
    return ^ZBButtonSet *(NSString *title){
        [self.oriButton setTitle:title forState:UIControlStateHighlighted];
        return self;
    };
}

-(ZBButtonSet * (^)(NSString *))focusedTitle{
    return ^ZBButtonSet *(NSString *title){
        [self.oriButton setTitle:title forState:UIControlStateFocused];
        return self;
    };
}


-(ZBButtonSet *(^)(UIColor *))backgroundColor{
    return ^ZBButtonSet *(UIColor *color){
        [self.oriButton setBackgroundColor:color];
        return self;
    };
}

-(ZBButtonSet *(^)(UIColor *))normaltitleColor{
    return ^ZBButtonSet *(UIColor *color){
        [self.oriButton setTitleColor:color forState:0];
        return self;
    };
}

-(ZBButtonSet *(^)(UIColor *))hightlightitleColor{
    return ^ZBButtonSet *(UIColor *color){
        [self.oriButton setTitleColor:color forState:UIControlStateHighlighted];
        return self;
    };
}

-(ZBButtonSet *(^)(UIColor *))focusedtitleColor{
    return ^ZBButtonSet *(UIColor *color){
        [self.oriButton setTitleColor:color forState:0];
        return self;
    };
}

-(ZBButtonSet *(^)(CGRect))frame{
    return ^ZBButtonSet *(CGRect fra){
        [self.oriButton setFrame:fra];
        return self;
    };
}

@end



@implementation UIButton (ZBButtonModel)

-(ZBButtonSet *)button_seting{
    ZBButtonSet *b = [self ownButtonSetting];
    if (!b) {
        b = [ZBButtonSet new];
        b.oriButton = self;
        [self setOwnButtonSetting:b];
    }
    return b;
}

-(void)setOwnButtonSetting:(ZBButtonSet *)ownButtonSetting{
    objc_setAssociatedObject(self, @selector(ownButtonSetting), ownButtonSetting, OBJC_ASSOCIATION_RETAIN);
}

- (ZBButtonSet *)ownButtonSetting
{
    return objc_getAssociatedObject(self, _cmd);
}

@end
