//
//  NEAppDelegate.m
//  news-objc
//
//  Created by stlndm on 2018/10/10.
//  Copyright © 2018 stlndm. All rights reserved.
//

#import "NEAppDelegate.h"
#import "NENavigationController.h"
#import "NENewsViewController.h"
#import <Aspects/Aspects.h>
#import <YYModel/YYModel.h>
#import "NSObject+STListener.h"
#import "STListener.h"
@interface NEAppDelegate ()

@end

@implementation NEAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSClassFromString(@"NENewsViewController") aspect_hookSelector:@selector(init) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo) {
        id instance = aspectInfo.instance;
        NSLog(@"st_allPropertyKey===%@", [instance st_allPropertyKey]);
        if (![[instance st_allPropertyKey] containsObject:@"searchButton"]) return;
        UIButton *searchButton = [instance valueForKey:@"searchButton"];
        [searchButton aspect_hookSelector:@selector(touchesBegan:withEvent:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo) {
            UIControlState searchButonState = [[aspectInfo.instance valueForKey:@"state"] integerValue];
            NSLog(@"searchButonState===%ld", searchButonState);
        } error:nil];
    } error:nil];
    self.window = [[UIWindow alloc] initWithFrame:kScreenRect];
    NENewsViewController *newsViewController = [[NENewsViewController alloc] init];
    NENavigationController *navigationController = [[NENavigationController alloc] initWithRootViewController:newsViewController];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
    
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
