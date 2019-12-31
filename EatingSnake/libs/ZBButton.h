//
//  ZBButton.h
//  澳泰养车
//
//  Created by zbin.lee on 16/9/30.
//  Copyright © 2016年 aotai. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ZBButton : UIButton

//button点击事件block
@property(nonatomic,copy)void (^buttonBlock)(ZBButton *block);

//button附带各类属性
@property (nonatomic,copy) NSString *flag;
@property (nonatomic,retain) NSArray *array;
@property (nonatomic,retain) NSDictionary *dictionary;


//各类放法

-(instancetype)initWithFrame:(CGRect)frame
                       title:(NSString*)title
                  titleColor:(UIColor*)titlecolor
                   backColor:(UIColor*)backcolor
                 actionBlock:(void (^)(__unused ZBButton *callButton))block;

+(instancetype)buttonWithTitle:(NSString*)title
                    titleColor:(UIColor*)titlecolor
                     backColor:(UIColor*)backcolor
                   actionBlock:(void (^)(__unused ZBButton *callButton))block;


-(void)setImageWithName:(NSString *)imageName;

@end





@interface ZBButtonSet : NSObject

@property (nonatomic,weak) UIButton *oriButton;

-(ZBButtonSet * (^)(NSString *))normalTitle;
-(ZBButtonSet * (^)(NSString *))hightlighTitle;
-(ZBButtonSet * (^)(NSString *))focusedTitle;

-(ZBButtonSet *(^)(UIColor *))normaltitleColor;
-(ZBButtonSet *(^)(UIColor *))hightlightitleColor;
-(ZBButtonSet *(^)(UIColor *))focusedtitleColor;

-(ZBButtonSet *(^)(UIColor *))backgroundColor;
-(ZBButtonSet *(^)(CGRect))frame;

@end




@interface UIButton (ButtonSet)

-(ZBButtonSet *)button_seting;
@property (nonatomic) ZBButtonSet *ownButtonSetting;








@end
