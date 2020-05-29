//
//  AppDelegate.m
//  
//
//  Created by JZJ on 2019/5/29.
//  Copyright © 2019 JZJ. All rights reserved.
//

#import "AppDelegate.h"
#import "MSParallaxViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  self.window = [[UIWindow alloc]init];
  self.window.rootViewController = [MSParallaxViewController new];
  self.window.frame = [UIScreen mainScreen].bounds;
  self.window.backgroundColor = UIColor.whiteColor;
  [self.window makeKeyAndVisible];
  
  
  return YES;
}


@end
