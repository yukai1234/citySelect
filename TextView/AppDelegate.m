//
//  AppDelegate.m
//  TextView
//
//  Created by 俞凯 on 16/3/16.
//  Copyright © 2016年 俞凯. All rights reserved.
//

#import "AppDelegate.h"
#import "SecViewController.h"
#import "FLSideSlipViewController.h"
#import "TirViewController.h"
#import "rightViewController.h"
#import "centerViewController.h"
#import "ViewController.h"
@interface AppDelegate ()
@property(nonatomic,strong)FLSideSlipViewController *slipVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor=[UIColor whiteColor];
    //中间控制器
    TirViewController   *sec=[[TirViewController alloc]init];
    
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:sec];
    
    _slipVC=[[FLSideSlipViewController alloc]initWithRootViewController:nav];
    
    _slipVC.canSlideInPush=NO;
    
    TirViewController *tvc=[[TirViewController alloc]init];
    rightViewController *rvc=[[rightViewController alloc]init];
    _slipVC.leftViewController=tvc;
    _slipVC.rightViewController=rvc;
    self.window.rootViewController=_slipVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    NSString *str=[UIPasteboard generalPasteboard].string;
    if (str) {
        UIAlertView  *alert = [[UIAlertView alloc] initWithTitle:@"淘宝分享" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定 ", nil];
        [alert show];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
