//
//  AppDelegate.m
//  MyResume
//
//  Created by jiemo on 15/11/23.
//  Copyright © 2015年 jiemo. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIApplicationShortcutItem *shortItem1 = [[UIApplicationShortcutItem alloc] initWithType:@"技能能力" localizedTitle:@"技能能力"];
    UIApplicationShortcutItem *shortItem2 = [[UIApplicationShortcutItem alloc] initWithType:@"奖状证书" localizedTitle:@"奖状证书"];
    UIApplicationShortcutItem *shortItem3 = [[UIApplicationShortcutItem alloc] initWithType:@"参加活动" localizedTitle:@"参加活动"];
    UIApplicationShortcutItem *shortItem4 = [[UIApplicationShortcutItem alloc] initWithType:@"个人简介" localizedTitle:@"个人简介"];
    NSArray *shortItems = [[NSArray alloc] initWithObjects:shortItem1, shortItem2, shortItem3,shortItem4,nil];
    [[UIApplication sharedApplication] setShortcutItems:shortItems];
    
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.localizedTitle  isEqual: @"技能能力"]) {
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"skill" bundle:nil];
        UIViewController *vc = [secondStoryBoard instantiateInitialViewController];

        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    }
    if ([shortcutItem.localizedTitle  isEqual: @"奖状证书"]) {
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"certificate" bundle:nil];
        UIViewController *vc = [secondStoryBoard instantiateInitialViewController];
        
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    }
    if ([shortcutItem.localizedTitle  isEqual: @"参加活动"]) {
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Activities" bundle:nil];
        UIViewController *vc = [secondStoryBoard instantiateInitialViewController];
        
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    }
    if ([shortcutItem.localizedTitle  isEqual: @"个人简介"]) {
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Interduce" bundle:nil];
        UIViewController *vc = [secondStoryBoard instantiateInitialViewController];
        
        [self.window.rootViewController presentViewController:vc animated:YES completion:nil];
    }
}
@end
