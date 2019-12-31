//
//  AppDelegate.m
//  EatingSnake
//
//  Created by 李志彬 on 2017/6/12.
//  Copyright © 2017年 李志彬. All rights reserved.
//

#import "AppDelegate.h"

//tabbar设置
#import "ScoreRecordVC.h"
#import "LoginVC.h"

@interface AppDelegate ()

@property (nonatomic, strong) UITabBarController *onlyTabbar;


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    self.navigationController.navigationBar.translucent = NO;
    
    [self creatTabbar];
    
    return YES;
}

-(void)creatTabbar{
    ScoreRecordVC *s = [[ScoreRecordVC alloc]init];
    LoginVC *l = [[LoginVC alloc]init];
    
    //建立分栏item
    UINavigationController *nv1 = [[UINavigationController alloc]initWithRootViewController:l];
    UINavigationController *nv2 = [[UINavigationController alloc]initWithRootViewController:s];

    
    //    NSString *messageStr = [notice.userInfo objectForKey:@"net"];
    //    shouye.title = messageStr;
    UITabBarItem *item1 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:100];
    UITabBarItem *item2 = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:101];
    
    
    nv1.tabBarItem = item1;
    nv2.tabBarItem = item2;
    
    //建立分栏
    _onlyTabbar = [[UITabBarController alloc]init];
    _onlyTabbar.viewControllers = @[nv1,nv2];
    _onlyTabbar.tabBar.tintColor = [UIColor blueColor];
    self.window.rootViewController = _onlyTabbar;
    
    [[UINavigationBar appearance] setTintColor:ColorBlue];
    [[UINavigationBar appearance] setBarTintColor:ColorGray];
    [UINavigationBar appearance].translucent = NO;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
