//
//  AppDelegate.m
//  CZFHotUpdateDemo
//
//  Created by 陈帆 on 2019/11/9.
//  Copyright © 2019 陈帆. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self.window setRootViewController:[storyboard instantiateInitialViewController]];
    [self.window makeKeyWindow];
    self.window.frame = [[UIScreen mainScreen] bounds];
    
    return YES;
}



@end
