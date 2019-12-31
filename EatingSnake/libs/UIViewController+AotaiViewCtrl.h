//
//  UIViewController+AotaiViewCtrl.h
//  澳泰养车
//
//  Created by zbin.lee on 16/10/17.
//  Copyright © 2016年 aotai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AotaiViewCtrl)

//显示隐藏导航栏及分栏
-(void)hiddenTabbar;
-(void)showTabbar;
-(void)hiddenNavigationBar;
-(void)showNavigationBar;
-(void)doubleHidden;
-(void)doubleShow;

//push和POP
-(void)pushWithViewCtrl:(UIViewController *)viewCtrl;
-(void)popToComingViewCtrl;

//设置返回键按钮
-(void)setBackButtonWithImage:(NSString *)imagename frame:(CGRect)frame title:(NSString *)title;
-(void)changeBackButton;

@end
