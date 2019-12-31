//
//  UIViewController+AotaiViewCtrl.m
//  澳泰养车
//
//  Created by zbin.lee on 16/10/17.
//  Copyright © 2016年 aotai. All rights reserved.
//

#import "UIViewController+AotaiViewCtrl.h"

@implementation UIViewController (AotaiViewCtrl)

//显示隐藏导航栏及分栏
-(void)hiddenTabbar{
    self.tabBarController.tabBar.hidden = YES;
}
-(void)showTabbar{
    self.tabBarController.tabBar.hidden = NO;
}

-(void)hiddenNavigationBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    self.navigationController.navigationBar.hidden = YES;
}
-(void)showNavigationBar{
//    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

-(void)doubleHidden{
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}
-(void)doubleShow{
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = NO;
}

//push和POP
-(void)pushWithViewCtrl:(UIViewController *)viewCtrl;{
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)popToComingViewCtrl{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setBackButtonWithImage:(NSString *)imagename frame:(CGRect)frame title:(NSString *)title; {
    
    UIImage* image = [UIImage imageNamed:imagename];
    ZBButton* someButton = [[ZBButton alloc]initWithFrame:frame title:nil titleColor:ColorBlack backColor:nil actionBlock:^(ZBButton *callButton) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [someButton setImage:image forState:0];
    someButton.imageEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 6);
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:someButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
}

-(void)changeBackButton;{
    [self setBackButtonWithImage:@"left_arrow" frame:CGRectMake(0, 0, 22, 40)title:nil];
}


@end
